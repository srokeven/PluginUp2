unit plugin.monitoramento.datamodule;

interface

uses
  System.SysUtils, System.Classes, Vcl.ExtCtrls, System.Threading, Vcl.FileCtrl,
  System.JSON, System.Generics.Collections,
  uUtils, plugin.controller.schemas, plugin.controller.databases,
  plugin.datamodule, FileSearchUnit, System.StrUtils;

type
  TPluginStatus = (psParado, psIniciado, psExecutando);
  TdmMonitoramento = class(TDataModule)
    tmCiclos: TTimer;
    procedure DataModuleCreate(Sender: TObject);
    procedure tmCiclosTimer(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
    procedure SetStatus(AStatus: TPluginStatus);
  private
    FIndex: integer;
    FTarefa: ITask;
    FListaArquivos: TFileSearch;
    FListaSchemas: TObjectList<TPluginSchemas>;
    FSchema: TPluginSchemas;
    FStatus: TPluginStatus;
    FExecucaoManual: boolean;
    procedure CarregarArquivosSchemas;
    function TestarConexoes: boolean;
    function ExecutarSchema: boolean;
    procedure CriarTask;
    procedure Processar;
    procedure PosProcessamento;
  public
    procedure IniciarEx;
    procedure Iniciar;
    procedure Retornar;
    procedure Pausar;
    procedure Parar;
    function GetStatus: string;
    function GetStatusValue: integer;
    function GetLog(ADate: TDate): string;
    function GetListLogs(ATotalRecords: integer = 0; ASkip: integer = 0): string;
    procedure SetInterlavoCiclos(AMilliseconds: integer);
  end;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

procedure TdmMonitoramento.CarregarArquivosSchemas;
var
  I: integer;
  lArquivoAtual, lJsonAtual: string;
begin
  FListaArquivos.Directory(DirSchemas);
  FListaArquivos.Execute;
  FListaSchemas.Clear;
  for I := 0 to FListaArquivos.GetFileList.Count -1 do
  begin
    lArquivoAtual := FListaArquivos.GetFileList[I];
    lJsonAtual := LerJsonFromFile(lArquivoAtual);
    FListaSchemas.Add(TPluginSchemas.Novo(lArquivoAtual));
  end;
end;

procedure TdmMonitoramento.CriarTask;
begin
  FTarefa := TTask.Create(
      procedure
      begin
        TThread.Synchronize(TThread.CurrentThread,
        procedure
        begin
          Processar;
        end);

        TThread.Synchronize(TThread.CurrentThread,
        procedure
        begin
          PosProcessamento;
        end);
      end);
end;

procedure TdmMonitoramento.DataModuleCreate(Sender: TObject);
begin
  SetStatus(psParado);
  FListaSchemas := TObjectList<TPluginSchemas>.Create;
  FIndex := 0;
  FListaArquivos := TFileSearch.Create(DirConsultasPendentes, '.json');
end;

procedure TdmMonitoramento.DataModuleDestroy(Sender: TObject);
begin
  FListaSchemas.Free;
  FListaArquivos.Free;
end;

function TdmMonitoramento.ExecutarSchema: boolean;
begin
  Result := False;
  FSchema := TPluginSchemas.Create;
  if FSchema.Executar then
    Result := True
  else

  FreeAndNil(FSchema);
end;

procedure TdmMonitoramento.Retornar;
begin
  CarregarArquivosSchemas;
  tmCiclos.Enabled := True;
  FExecucaoManual := False;
end;

function TdmMonitoramento.GetListLogs(ATotalRecords: integer = 0; ASkip: integer = 0): string;
var
  I, lCount: integer;
  lArquivoAtual: string;
begin
  FListaArquivos.Directory(IncludeTrailingPathDelimiter(IncludeTrailingPathDelimiter(DirLocal)+'logs'));
  FListaArquivos.Extension('.txt');
  FListaArquivos.Execute;
  lCount := 0;
  for I := 0 to FListaArquivos.GetFileList.Count -1 do
  begin
    if I >= ASkip then
    begin
      if lCount <= ATotalRecords then
      begin
        lArquivoAtual := FListaArquivos.GetFileList[I];
        Result := Result + lArquivoAtual + sLineBreak;
        Inc(lCount);
      end
      else break;
    end;
  end;
end;

function TdmMonitoramento.GetLog(ADate: TDate): string;
var
  lDiretorio, lArquivo: string;
begin
  lDiretorio := IncludeTrailingPathDelimiter(ExtractFilePath(ParamStr(0)))+'logs';
  lArquivo := IncludeTrailingPathDelimiter(lDiretorio)+'log'+FormatDateTime('ddMMyyyy',ADate)+'.txt';
  Result := '';
  if FileExists(lArquivo) then
    Result := LerTextFromFile(lArquivo);
end;

function TdmMonitoramento.GetStatus: string;
begin
  case FStatus of
    psParado: Result := 'O serviço encontra-se parado';
    psIniciado: Result := 'O serviço está aguardando por um novo ciclo';
    psExecutando: Result := 'O serviço está em execução nesse momento';
  end;
  if Assigned(FTarefa) then
    case FTarefa.Status of
      TTaskStatus.Created: Result := Result + ' - Thread: Criada';
      TTaskStatus.WaitingToRun: Result := Result + ' - Thread: Esperando para rodar';
      TTaskStatus.Running: Result := Result + ' - Thread: Rodando';
      TTaskStatus.Completed: Result := Result + ' - Thread: Completado';
      TTaskStatus.WaitingForChildren: Result := Result + ' - Thread: Esperando thread filha';
      TTaskStatus.Canceled: Result := Result + ' - Thread: Cancelada';
      TTaskStatus.Exception: Result := Result + ' - Thread: Com erro';
    end;
  Result := Result + ' - Ciclo: '+IfThen(tmCiclos.Enabled, 'Ativo', 'Parado');
end;

function TdmMonitoramento.GetStatusValue: integer;
begin
  case FStatus of
    psParado: Result := 0;
    psIniciado: Result := 1;
    psExecutando: Result := 2;
  end;
end;

procedure TdmMonitoramento.Iniciar;
begin
  SetStatus(psIniciado);
  CarregarArquivosSchemas;
  CriarTask;
  FExecucaoManual := False;
  tmCiclos.Enabled := True;
end;

procedure TdmMonitoramento.IniciarEx;
begin
  CarregarArquivosSchemas;
  CriarTask;
  FExecucaoManual := True;
  FTarefa.Start;
end;

procedure TdmMonitoramento.Parar;
begin
  tmCiclos.Enabled := False;
  if Assigned(FTarefa) then
    case FTarefa.Status of
      TTaskStatus.Running: begin
        FTarefa.Cancel;
        tmCiclos.Enabled := False;
        Sleep(1000);
      end;
      else begin
        tmCiclos.Enabled := False;
        Sleep(1000);
      end;
    end;
  SetStatus(psParado);
end;

procedure TdmMonitoramento.Pausar;
begin
  FExecucaoManual := True;
  tmCiclos.Enabled := False;
end;

procedure TdmMonitoramento.Processar;
var
  I: Integer;
begin
  SetStatus(psExecutando);
  for I := 0 to FListaSchemas.Count - 1 do
  begin
    if FListaSchemas[I].Consultar then
      FListaSchemas[I].Executar;
  end;
end;

procedure TdmMonitoramento.PosProcessamento;
var
  I: Integer;
begin
  for I := 0 to FListaSchemas.Count - 1 do
  begin
    FListaSchemas[I].Atualizar;
    FListaSchemas[I].Mover;
  end;
  FTarefa.CheckCanceled;
  SetStatus(psIniciado);
  if not (FExecucaoManual) then
    tmCiclos.Enabled := True;
end;

procedure TdmMonitoramento.SetInterlavoCiclos(AMilliseconds: integer);
begin
  tmCiclos.Enabled := False;
  tmCiclos.Interval := AMilliseconds;
end;

procedure TdmMonitoramento.SetStatus(AStatus: TPluginStatus);
begin
  FStatus := AStatus;
end;

function TdmMonitoramento.TestarConexoes: boolean;
begin
 //
end;

procedure TdmMonitoramento.tmCiclosTimer(Sender: TObject);
begin
  tmCiclos.Enabled := False;
  if FTarefa.Status = TTaskStatus.Completed then
  begin
    CriarTask;
  end;
  if (FTarefa.Status = TTaskStatus.WaitingToRun) or (FTarefa.Status = TTaskStatus.Created) then
  begin
    FTarefa.Start;
  end;
end;

end.
