program PluginUp2Servico;

uses
  Vcl.SvcMgr,
  plugin.servico.datamodule in 'servico\plugin.servico.datamodule.pas' {dmService: TService},
  plugin.controller.databases in 'controller\plugin.controller.databases.pas',
  plugin.controller.links in 'controller\plugin.controller.links.pas',
  plugin.controller.schemas in 'controller\plugin.controller.schemas.pas',
  plugin.controller.tables in 'controller\plugin.controller.tables.pas',
  plugin.datamodule in 'dao\plugin.datamodule.pas' {dmConexao: TDataModule},
  uUtils in 'utils\uUtils.pas',
  FileSearchUnit in 'utils\FileSearchUnit.pas',
  plugin.monitoramento.datamodule in 'servico\plugin.monitoramento.datamodule.pas' {dmMonitoramento: TDataModule};

{$R *.RES}

begin
  // Windows 2003 Server requires StartServiceCtrlDispatcher to be
  // called before CoRegisterClassObject, which can be called indirectly
  // by Application.Initialize. TServiceApplication.DelayInitialize allows
  // Application.Initialize to be called from TService.Main (after
  // StartServiceCtrlDispatcher has been called).
  //
  // Delayed initialization of the Application object may affect
  // events which then occur prior to initialization, such as
  // TService.OnCreate. It is only recommended if the ServiceApplication
  // registers a class object with OLE and is intended for use with
  // Windows 2003 Server.
  //
  // Application.DelayInitialize := True;
  //
  if not Application.DelayInitialize or Application.Installing then
    Application.Initialize;
  Application.CreateForm(TdmService, dmService);
  Application.Run;
end.
