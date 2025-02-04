program PluginUp2ServicoConsole;

{$APPTYPE CONSOLE}

{$R *.res}

uses
  Horse,
  Horse.Jhonson,
  Horse.HandleException,
  System.JSON,
  System.SysUtils,
  plugin.controller.databases in 'controller\plugin.controller.databases.pas',
  plugin.controller.links in 'controller\plugin.controller.links.pas',
  plugin.controller.schemas in 'controller\plugin.controller.schemas.pas',
  plugin.controller.tables in 'controller\plugin.controller.tables.pas',
  plugin.datamodule in 'dao\plugin.datamodule.pas' {dmConexao: TDataModule},
  uUtils in 'utils\uUtils.pas',
  FileSearchUnit in 'utils\FileSearchUnit.pas',
  plugin.monitoramento.datamodule.console in 'servico\plugin.monitoramento.datamodule.console.pas' {dmMonitoramento: TDataModule};

var
  FdmMonitoramento: TdmMonitoramento;

begin
  try
    FdmMonitoramento := TdmMonitoramento.Create(nil);
    FdmMonitoramento.CarregarConfiguracao;
    FdmMonitoramento.SalvarConfiguracao;
    FdmMonitoramento.RegistrarEndpoints;
    FdmMonitoramento.Start;
    WriteLn('Serviço online');
  except
    on E: Exception do
      Writeln(E.ClassName, ': ', E.Message);
  end;
end.
