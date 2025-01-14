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
    FdmMonitoramento: TdmMonitoramento;
  public
    function GetServiceController: TServiceController; override;
  end;

var
  dmService: TdmService;

implementation

{$R *.dfm}

procedure ServiceController(CtrlCode: DWord); stdcall;
begin
  dmService.Controller(CtrlCode);
end;

function TdmService.GetServiceController: TServiceController;
begin
  Result := ServiceController;
end;

procedure TdmService.ServiceBeforeInstall(Sender: TService);
begin
  Self.DisplayName := 'PluginUp2 - Serviço de sincronia de dados entre os sistemas Up2 Soluções';
end;

procedure TdmService.ServiceContinue(Sender: TService; var Continued: Boolean);
begin
  FdmMonitoramento.Start;
  Continued := True;
end;

procedure TdmService.ServiceCreate(Sender: TObject);
begin
  FdmMonitoramento := TdmMonitoramento.Create(nil);
  FdmMonitoramento.CarregarConfiguracao;
  FdmMonitoramento.SalvarConfiguracao;
  FdmMonitoramento.RegistrarEndpoints;
end;

procedure TdmService.ServiceDestroy(Sender: TObject);
begin
  FdmMonitoramento.Stop;
  FdmMonitoramento.Free;
end;

procedure TdmService.ServicePause(Sender: TService; var Paused: Boolean);
begin
  FdmMonitoramento.Stop;
  Paused := True;
end;

procedure TdmService.ServiceStart(Sender: TService; var Started: Boolean);
begin
  FdmMonitoramento.CarregarConfiguracao;
  FdmMonitoramento.Start;
  Started := True;
end;

procedure TdmService.ServiceStop(Sender: TService; var Stopped: Boolean);
begin
  FdmMonitoramento.Stop;
  Stopped := True;
end;

end.
