program PluginUp2Util;

uses
  Vcl.Forms,
  plugin.main in 'plugin.main.pas' {fmrMainPlugin},
  plugin.controller.databases in 'controller\plugin.controller.databases.pas',
  uUtils in 'utils\uUtils.pas',
  plugin.controller.tables in 'controller\plugin.controller.tables.pas',
  plugin.controller.links in 'controller\plugin.controller.links.pas',
  plugin.controller.schemas in 'controller\plugin.controller.schemas.pas',
  plugin.cadastros in 'plugin.cadastros.pas' {fmCadastros},
  plugin.datamodule in 'dao\plugin.datamodule.pas' {dmConexao: TDataModule},
  plugin.expressoes in 'plugin.expressoes.pas' {fmMontarExperssao},
  uColorUtils in 'utils\uColorUtils.pas',
  plugin.servico.manutencao in 'plugin.servico.manutencao.pas' {fmServicos},
  plugin.monitoramento.datamodule in 'servico\plugin.monitoramento.datamodule.pas' {dmMonitoramento: TDataModule},
  FileSearchUnit in 'utils\FileSearchUnit.pas',
  uApi in 'utils\uApi.pas',
  udmAPI in 'utils\udmAPI.pas' {dmAPI: TDataModule},
  plugin.selecao.tabela.join in 'plugin.selecao.tabela.join.pas' {fmSelecionarTabelaJoin},
  plugin.monta.where in 'plugin.monta.where.pas' {fmMontaWhere};

{$R *.res}

begin
  //ReportMemoryLeaksOnShutdown := True;
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfmrMainPlugin, fmrMainPlugin);
  Application.Run;
end.
