unit plugin.servico.datamodule;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.SvcMgr, Vcl.Dialogs,
  uUtils, plugin.monitoramento.datamodule;

type
  TdmService = class(TService)
    procedure ServiceBeforeInstall(Sender: TService);
    procedure ServiceCreate(Sender: TObject);
    procedure ServiceStart(Sender: TService; var Started: Boolean);
    procedure ServiceStop(Sender: TService; var Stopped: Boolean);
    procedure ServicePause(Sender: TService; var Paused: Boolean);
    procedure ServiceContinue(Sender: TService; var Continued: Boolean);
    procedure ServiceDestroy(Sender: TObject);
  private
    FPortaAPI, FIntervaloCiclos: integer;
    FdmMonitoramento: TdmMonitoramento;
    procedure SalvarConfiguracao;
    procedure CarregarConfiguracao;
    procedure RegistrarEndpoints;
    procedure Start;
    procedure Stop;
    procedure IniciaCiclos;
    procedure PararCiclos;
    procedure PausarCiclos;
    procedure RetornarCiclos;
  public
    function GetServiceController: TServiceController; override;
  end;

var
  dmService: TdmService;

implementation

{$R *.dfm}


uses Horse, Horse.Jhonson;

procedure ServiceController(CtrlCode: DWord); stdcall;
begin
  dmService.Controller(CtrlCode);
end;

procedure TdmService.CarregarConfiguracao;
begin
  FPortaAPI := StrToIntDef(LerIni('GERAL', 'PORTA_GERENCIAL', '49255', IncludeTrailingPathDelimiter(ExtractFilePath(ParamStr(0)))+'configuracao.ini'), 49255);
  FIntervaloCiclos := StrToIntDef(LerIni('GERAL', 'INTERVALO', '15000', IncludeTrailingPathDelimiter(ExtractFilePath(ParamStr(0)))+'configuracao.ini'), 15000);
  Self.DisplayName := 'PluginUp2 - Serviço de sincronia de dados entre os sistemas Up2 Soluções';
end;

function TdmService.GetServiceController: TServiceController;
begin
  Result := ServiceController;
end;

procedure TdmService.IniciaCiclos;
begin
  FdmMonitoramento := TdmMonitoramento.Create(nil);
  FdmMonitoramento.SetInterlavoCiclos(FIntervaloCiclos);
  FdmMonitoramento.Iniciar;
end;

procedure TdmService.PararCiclos;
begin
  if Assigned(FdmMonitoramento) then
  begin
    FdmMonitoramento.Parar;
    FreeAndNil(FdmMonitoramento);
  end;
end;

procedure TdmService.PausarCiclos;
begin
  if Assigned(FdmMonitoramento) then
  begin
    FdmMonitoramento.Pausar;
  end;
end;

procedure TdmService.RegistrarEndpoints;
begin
  THorse.Post('/logs/:skip/:quantidade',
    procedure(Req: THorseRequest; Res: THorseResponse)
    var
      lSkip, lQuantidade, lLogs: string;
    begin
      if Assigned(FdmMonitoramento) then
      begin
        lSkip := Req.Params['skip'].Replace('*', '');
        lQuantidade := Req.Params['quantidade'].Replace('*', '');
        lLogs := FdmMonitoramento.GetListLogs(StrToIntDef(lQuantidade, 10), StrToIntDef(lSkip, 0));
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
      if Assigned(FdmMonitoramento) then
      begin
        lData := Req.Params['data'].Replace('*', '');
        dia := Copy(lData, 1, 2);
        mes := Copy(lData, 3, 2);
        ano := Copy(lData, 5, 4);

        // Montar a string da data no formato "DD/MM/AAAA"
        lData := Format('%s/%s/%s', [dia, mes, ano]);
        lLogs := FdmMonitoramento.GetLog(StrToDateDef(lData, Date));
        Res.Send(lLogs).Status(THTTPStatus.OK);
      end else
      begin
        Res.Send('Serviço não iniciado').Status(THTTPStatus.OK);
      end;
    end);

  THorse.Get('/parar',
    procedure(Req: THorseRequest; Res: THorseResponse)
    begin
      if Assigned(FdmMonitoramento) then
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
      if Assigned(FdmMonitoramento) then
      begin
        case FdmMonitoramento.GetStatusValue of
          0, 1: begin
            FdmMonitoramento.Retornar;
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
      if Assigned(FdmMonitoramento) then
      begin
        Res.Send(FdmMonitoramento.GetStatus).Status(THTTPStatus.OK);
      end else
        Res.Send('Serviço não iniciado').Status(THTTPStatus.OK);
    end);

  THorse.Get('/online',
    procedure(Req: THorseRequest; Res: THorseResponse)
    begin
      Res.Send('ok').Status(THTTPStatus.OK);
    end);
end;

procedure TdmService.RetornarCiclos;
begin

end;

procedure TdmService.SalvarConfiguracao;
begin
  GravarIni('GERAL', 'PORTA_GERENCIAL', FPortaAPI.ToString, IncludeTrailingPathDelimiter(ExtractFilePath(ParamStr(0)))+'configuracao.ini');
  GravarIni('GERAL', 'INTERVALO', FIntervaloCiclos.ToString, IncludeTrailingPathDelimiter(ExtractFilePath(ParamStr(0)))+'configuracao.ini');
end;

procedure TdmService.ServiceBeforeInstall(Sender: TService);
begin
  CarregarConfiguracao;
  SalvarConfiguracao;
end;

procedure TdmService.ServiceContinue(Sender: TService; var Continued: Boolean);
begin
  Start;
  Continued := True;
end;

procedure TdmService.ServiceCreate(Sender: TObject);
begin
  THorse.Use(Jhonson());
  RegistrarEndpoints;
end;

procedure TdmService.ServiceDestroy(Sender: TObject);
begin
  Stop;
end;

procedure TdmService.ServicePause(Sender: TService; var Paused: Boolean);
begin
  Stop;
  Paused := True;
end;

procedure TdmService.ServiceStart(Sender: TService; var Started: Boolean);
begin
  CarregarConfiguracao;
  Start;
  Started := True;
end;

procedure TdmService.ServiceStop(Sender: TService; var Stopped: Boolean);
begin
  Stop;
  Stopped := True;
end;

procedure TdmService.Start;
begin
  THorse.Listen(FPortaAPI);
  GravaLog('Serviço iniciado, ouvindo na porta: '+FPortaAPI.ToString, 'log');

  IniciaCiclos;
end;

procedure TdmService.Stop;
begin
  if THorse.IsRunning then
    THorse.StopListen;
  GravaLog('Serviço parado', 'log');

  PararCiclos;
end;

end.
