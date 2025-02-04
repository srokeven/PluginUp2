unit plugin.monitoramento.datamodule;

interface

uses
  System.SysUtils, System.Classes, Vcl.ExtCtrls,  Vcl.FileCtrl,
  System.JSON, System.Generics.Collections, System.Threading,
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
    FPortaAPI, FIntervaloCiclos: integer;
    procedure CarregarArquivosSchemas;
    function TestarConexoes: boolean;
    function ExecutarSchema: boolean;
    procedure CriarTask;
    procedure Processar;
    procedure PosProcessamento;
    procedure IniciaCiclos;
    procedure PararCiclos;
    procedure PausarCiclos;
  public
    procedure Start;
    procedure Stop;
    procedure CarregarConfiguracao;
    procedure SalvarConfiguracao;
    procedure RegistrarEndpoints;

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

uses Horse, Horse.Jhonson;

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

procedure TdmMonitoramento.CarregarConfiguracao;
begin
  FPortaAPI := StrToIntDef(LerIni('GERAL', 'PORTA_GERENCIAL', '49255', IncludeTrailingPathDelimiter(ExtractFilePath(ParamStr(0)))+'configuracao.ini'), 49255);
  FIntervaloCiclos := StrToIntDef(LerIni('GERAL', 'INTERVALO', '15000', IncludeTrailingPathDelimiter(ExtractFilePath(ParamStr(0)))+'configuracao.ini'), 15000);
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

procedure TdmMonitoramento.RegistrarEndpoints;
begin
  THorse.Use(Jhonson());
  THorse.Post('/logs/:skip/:quantidade',
    procedure(Req: THorseRequest; Res: THorseResponse)
    var
      lSkip, lQuantidade, lLogs: string;
    begin
      if not (FStatus = psParado) then
      begin
        lSkip := Req.Params['skip'].Replace('*', '');
        lQuantidade := Req.Params['quantidade'].Replace('*', '');
        lLogs := GetListLogs(StrToIntDef(lQuantidade, 10), StrToIntDef(lSkip, 0));
        Res.Send(lLogs).Status(THTTPStatus.OK);
      end else
      begin
        Res.Send('Serviço não iniciado').Status(THTTPStatus.OK);
      end;
    end);

  THorse.Post('/log/:data',
    procedure(Req: THorseRequest; Res: THorseResponse)
    var
      lData, lLogs, dia, mes, ano: string;
    begin
      if not (FStatus = psParado) then
      begin
        lData := Req.Params['data'].Replace('*', '');
        dia := Copy(lData, 1, 2);
        mes := Copy(lData, 3, 2);
        ano := Copy(lData, 5, 4);

        // Montar a string da data no formato "DD/MM/AAAA"
        lData := Format('%s/%s/%s', [dia, mes, ano]);
        lLogs := GetLog(StrToDateDef(lData, Date));
        Res.Send(lLogs).Status(THTTPStatus.OK);
      end else
      begin
        Res.Send('Serviço não iniciado').Status(THTTPStatus.OK);
      end;
    end);

  THorse.Get('/parar',
    procedure(Req: THorseRequest; Res: THorseResponse)
    begin
      if not (FStatus = psParado) then
      begin
        PausarCiclos;
        Res.Send('Serviço pausado').Status(THTTPStatus.OK);
      end else
      begin
        Res.Send('Serviço não iniciado').Status(THTTPStatus.OK);
      end;
    end);

  THorse.Get('/iniciar',
    procedure(Req: THorseRequest; Res: THorseResponse)
    begin
      if not (FStatus = psParado) then
      begin
        case GetStatusValue of
          0, 1: begin
            Retornar;
            Res.Send('Retornando serviço').Status(THTTPStatus.OK);
          end;
          2: begin
            Res.Send('Serviço já iniciado').Status(THTTPStatus.Accepted);
          end;
        end;
      end else
      begin
        IniciaCiclos;
        Res.Send('Iniciando serviço').Status(THTTPStatus.OK);
      end;
    end);

  THorse.Get('/status',
    procedure(Req: THorseRequest; Res: THorseResponse)
    begin
      if not (FStatus = psParado) then
      begin
        Res.Send(GetStatus).Status(THTTPStatus.OK);
      end else
        Res.Send('Serviço não iniciado').Status(THTTPStatus.OK);
    end);

  THorse.Get('/online',
    procedure(Req: THorseRequest; Res: THorseResponse)
    begin
      Res.Send('ok').Status(THTTPStatus.OK);
    end);
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

procedure TdmMonitoramento.IniciaCiclos;
begin
  SetInterlavoCiclos(FIntervaloCiclos);
  Iniciar;
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

procedure TdmMonitoramento.PararCiclos;
begin
  Parar;
end;

procedure TdmMonitoramento.Pausar;
begin
  FExecucaoManual := True;
  tmCiclos.Enabled := False;
end;

procedure TdmMonitoramento.PausarCiclos;
begin
  Pausar;
end;

procedure TdmMonitoramento.Processar;
var
  I: Integer;
  lDataConsultas: string;
begin
  SetStatus(psExecutando);
  lDataConsultas := DateToSQLDateTime(Now);
  for I := 0 to FListaSchemas.Count - 1 do
  begin
    if FListaSchemas[I].Consultar(lDataConsultas) then
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
    FListaSchemas[I].MoverArquivoAtualizado;
  end;
  FTarefa.CheckCanceled;
  SetStatus(psIniciado);
  if not (FExecucaoManual) then
    tmCiclos.Enabled := True;
end;

procedure TdmMonitoramento.SalvarConfiguracao;
begin
  GravarIni('GERAL', 'PORTA_GERENCIAL', FPortaAPI.ToString, IncludeTrailingPathDelimiter(ExtractFilePath(ParamStr(0)))+'configuracao.ini');
  GravarIni('GERAL', 'INTERVALO', FIntervaloCiclos.ToString, IncludeTrailingPathDelimiter(ExtractFilePath(ParamStr(0)))+'configuracao.ini');
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

procedure TdmMonitoramento.Start;
begin
  THorse.Listen(FPortaAPI);
  GravaLog('Serviço iniciado, ouvindo na porta: '+FPortaAPI.ToString, 'log');

  IniciaCiclos;
end;

procedure TdmMonitoramento.Stop;
begin
  if THorse.IsRunning then
    THorse.StopListen;
  GravaLog('Serviço parado', 'log');

  PararCiclos;
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
