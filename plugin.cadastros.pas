unit plugin.cadastros;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ComCtrls, Vcl.ExtCtrls,
  Vcl.StdCtrls, Vcl.Buttons, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, Data.DB, Vcl.Grids, Vcl.DBGrids, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, Vcl.DBCtrls, Vcl.Mask, JvExStdCtrls, JvCombobox,
  JvDBCombobox, Vcl.Graphics, System.JSON, plugin.datamodule, uUtils,
  plugin.controller.databases, Vcl.FileCtrl, plugin.controller.tables,
  plugin.controller.schemas, System.Math, System.StrUtils,
  plugin.controller.links, plugin.expressoes, uColorUtils, FileSearchUnit,
  Vcl.Menus, plugin.selecao.tabela.join, plugin.monta.where, cxGraphics,
  cxLookAndFeels, cxLookAndFeelPainters, cxButtons;

type
  TfmCadastros = class(TForm)
    pnlSide: TPanel;
    pcPrincipal: TPageControl;
    btnCadBancoDados: TBitBtn;
    tsCadBancoDados: TTabSheet;
    tsCadTabelas: TTabSheet;
    btnRegTabelas: TBitBtn;
    pnlEdicaoBancos: TPanel;
    pnlListaBancos: TPanel;
    fmtBancosDeDados: TFDMemTable;
    grBancoDados: TDBGrid;
    dsBancosDeDados: TDataSource;
    fmtBancosDeDadosNOME: TStringField;
    fmtBancosDeDadosSERVIDOR: TStringField;
    fmtBancosDeDadosPORTA: TStringField;
    fmtBancosDeDadosCAMINHO: TStringField;
    fmtBancosDeDadosUSUARIO: TStringField;
    fmtBancosDeDadosSENHA: TStringField;
    fmtBancosDeDadosTIPO: TIntegerField;
    Label1: TLabel;
    edNome: TDBEdit;
    Label2: TLabel;
    edServidor: TDBEdit;
    Label3: TLabel;
    edPorta: TDBEdit;
    Label4: TLabel;
    edCaminho: TDBEdit;
    Label5: TLabel;
    edUsuario: TDBEdit;
    Label6: TLabel;
    edSenha: TDBEdit;
    Label7: TLabel;
    btnSalvarDB: TButton;
    cbTipoDB: TJvDBComboBox;
    pnlButtonsCadBancoDados: TPanel;
    btnNovoDB: TButton;
    btnEditarDB: TButton;
    pnlTabelasSelecionadas: TPanel;
    pnlListaTabelas: TPanel;
    grTabelas: TDBGrid;
    pnlButtonsTabelas: TPanel;
    btnSelecionarTabela: TButton;
    btnTabelasDB: TButton;
    fmtTabelas: TFDMemTable;
    fmtTabelasNOME: TStringField;
    fmtTabelasSELECIONADO: TIntegerField;
    dsTabelas: TDataSource;
    lbListaTabelasSelecionadas: TListBox;
    pnlButtonsTabelasSelecionadas: TPanel;
    btnTestarBancoDados: TButton;
    Label8: TLabel;
    btnSalvarTabelas: TButton;
    fmtBancosDeDadosSISTEMA: TStringField;
    Label9: TLabel;
    cbSistema: TJvDBComboBox;
    fmtTabelasSISTEMA: TStringField;
    tsCadSchemas: TTabSheet;
    tsSelBancosDados: TTabSheet;
    tsCadLinks: TTabSheet;
    pnlEditsSchemas: TPanel;
    btnSalvarSchema: TButton;
    pnlListaSchemas: TPanel;
    grListaSchemas: TDBGrid;
    pnlButtonsSchemas: TPanel;
    btnNovoSchema: TButton;
    btnAlterarSchema: TButton;
    fmtSchemas: TFDMemTable;
    dsSchemas: TDataSource;
    fmtSchemasDESCRICAO: TStringField;
    fmtSchemasDIR_ARQUIVO: TStringField;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    mmBancoOrigem: TMemo;
    mmBancoDestino: TMemo;
    lbSelecionarArquivoOrigem: TLabel;
    lbSelecionarArquivoDestino: TLabel;
    mmTabelasSchema: TMemo;
    lbCriarLinks: TLabel;
    grSelecaoBancos: TDBGrid;
    pnlButtonsSelecionaBanco: TPanel;
    fmtSelecionaBancos: TFDMemTable;
    fmtSelecionaBancosNOME: TStringField;
    fmtSelecionaBancosSERVIDOR: TStringField;
    fmtSelecionaBancosPORTA: TStringField;
    fmtSelecionaBancosCAMINHO: TStringField;
    fmtSelecionaBancosUSUARIO: TStringField;
    fmtSelecionaBancosSENHA: TStringField;
    fmtSelecionaBancosTIPO: TIntegerField;
    fmtSelecionaBancosSISTEMA: TStringField;
    dsSelecionaBancos: TDataSource;
    btnSelecionarBanco: TButton;
    fmtSelecionaBancosARQUIVO: TStringField;
    tsCadLinksCampos: TTabSheet;
    pnlTabelaOrigem: TPanel;
    pnlTabelaDestino: TPanel;
    grTabelasOrigem: TDBGrid;
    grTabelasDestino: TDBGrid;
    pnlLinks: TPanel;
    fmtTabelasOrigem: TFDMemTable;
    fmtTabelasDestino: TFDMemTable;
    fmtTabelasOrigemSEL: TIntegerField;
    fmtTabelasOrigemORDEM: TIntegerField;
    fmtTabelasOrigemDESCRICAO: TStringField;
    dsTabelasOrigem: TDataSource;
    dsTabelasDestino: TDataSource;
    fmtTabelasDestinoSEL: TIntegerField;
    fmtTabelasDestinoORDEM: TIntegerField;
    fmtTabelasDestinoDESCRICAO: TStringField;
    lbListaLinks: TListBox;
    btnSalvarLink: TButton;
    pnlBottomListLinks: TPanel;
    btnCriarLinkCampos: TButton;
    pnlCamposOrigem: TPanel;
    pnlCamposDestino: TPanel;
    grCamposOrigem: TDBGrid;
    grCamposDestino: TDBGrid;
    pnlListaLinksCriados: TPanel;
    lbListaCamposLink: TListBox;
    Panel2: TPanel;
    btnSalvarCamposLinks: TButton;
    pnlCriarLink: TPanel;
    fmtCamposOrigem: TFDMemTable;
    fmtCamposOrigemCAMPO: TStringField;
    fmtCamposOrigemTIPO: TIntegerField;
    fmtCamposOrigemTAMANHO: TIntegerField;
    fmtCamposOrigemCHAVEPRIMARIA: TStringField;
    fmtCamposOrigemCHAVEESTRANGEIRA: TStringField;
    fmtCamposOrigemCHAVEESTRANGEIRANOMETABELA: TStringField;
    fmtCamposOrigemPERMITENULO: TStringField;
    fmtCamposOrigemVALORPADRAO: TStringField;
    fmtCamposOrigemUSADO: TIntegerField;
    fmtCamposDestino: TFDMemTable;
    fmtCamposDestinoCAMPO: TStringField;
    fmtCamposDestinoTIPO: TIntegerField;
    fmtCamposDestinoTAMANHO: TIntegerField;
    fmtCamposDestinoCHAVEPRIMARIA: TStringField;
    fmtCamposDestinoCHAVEESTRANGEIRA: TStringField;
    fmtCamposDestinoCHAVEESTRANGEIRANOMETABELA: TStringField;
    fmtCamposDestinoPERMITENULO: TStringField;
    fmtCamposDestinoVALORPADRAO: TStringField;
    fmtCamposDestinoUSADO: TIntegerField;
    dsCamposOrigem: TDataSource;
    dsCamposDestino: TDataSource;
    chkSemCampoOrigem: TCheckBox;
    Label13: TLabel;
    Label14: TLabel;
    Label15: TLabel;
    Label16: TLabel;
    Label17: TLabel;
    Label18: TLabel;
    Label19: TLabel;
    Label20: TLabel;
    txTipoOrigem: TDBText;
    txTabelaEstrangeiraOrigem: TDBText;
    txCampoOrigem: TDBText;
    Label21: TLabel;
    Label22: TLabel;
    txTamanhoOrigem: TDBText;
    txChavePrimariaOrigem: TDBText;
    txChaveEstrangeiraOrigem: TDBText;
    txPermiteNuloOrigem: TDBText;
    txValorPadraoOrigem: TDBText;
    txValorPadraoDestino: TDBText;
    Label23: TLabel;
    Label24: TLabel;
    txPermiteNuloDestino: TDBText;
    txTabelaEstrangeira: TDBText;
    Label25: TLabel;
    txChaveEstrangeiraDestino: TDBText;
    Label26: TLabel;
    txChavePrimariaDestino: TDBText;
    Label27: TLabel;
    txTamanhoDestino: TDBText;
    Label28: TLabel;
    txTipoDestino: TDBText;
    Label29: TLabel;
    txCampoDestino: TDBText;
    Label30: TLabel;
    fmtTabelasOrigemARQUIVO: TStringField;
    fmtTabelasDestinoARQUIVO: TStringField;
    Label31: TLabel;
    mmExpressaoLivre: TMemo;
    Label32: TLabel;
    btnCriarLink: TButton;
    pnlTopoSelecaoBancos: TPanel;
    btnGerarExpressao: TButton;
    btnAlterarLink: TButton;
    tsBoasVindas: TTabSheet;
    Label33: TLabel;
    Label34: TLabel;
    Label35: TLabel;
    Label36: TLabel;
    fmtTabelasDependentes: TFDMemTable;
    fmtTabelasDependentesTABELA_MASTER: TStringField;
    fmtTabelasDependentesTABELA_DEPENDENTE: TStringField;
    btnZerarDatas: TButton;
    popZerarTabelas: TPopupMenu;
    CLIENTES1: TMenuItem;
    FORNECEDORES1: TMenuItem;
    GRUPOS1: TMenuItem;
    GRUPOSCLIENTE1: TMenuItem;
    MARCAS1: TMenuItem;
    SUBGRUPOS1: TMenuItem;
    PRODUTOS1: TMenuItem;
    CAIXAS1: TMenuItem;
    CAIXATIPOSMOVIMENTOS1: TMenuItem;
    DESPESAS1: TMenuItem;
    EQUIPAMENTOS1: TMenuItem;
    EQUIPAMENTOSCLIENTES1: TMenuItem;
    ESTOQUE1: TMenuItem;
    FILIAIS1: TMenuItem;
    PARCELASPRAZOS1: TMenuItem;
    PRAZOS1: TMenuItem;
    REGRASTRIBUTACAO1: TMenuItem;
    SERVICOS1: TMenuItem;
    ECNICOS1: TMenuItem;
    IPOSDOCUMENTOS1: TMenuItem;
    IPOSPAGAMENTOS1: TMenuItem;
    IPOESTOQUEMOV1: TMenuItem;
    UNIDADEMEDIDA1: TMenuItem;
    VENDEDORES1: TMenuItem;
    popZerarTabelasPDV: TPopupMenu;
    BCAIXA1: TMenuItem;
    BFORMAPAGAMENTO1: TMenuItem;
    BFORNECEDOR1: TMenuItem;
    BGRUPO1: TMenuItem;
    BMARCA1: TMenuItem;
    BPESSOA1: TMenuItem;
    BPRODUTO1: TMenuItem;
    BUNIDADE1: TMenuItem;
    BOPERADOR1: TMenuItem;
    btnProcurarBanco: TSpeedButton;
    odArquivosBanco: TOpenDialog;
    PRODUTOSFORNECEDORES1: TMenuItem;
    BRELACIONAR1: TMenuItem;
    btnJoinTabela: TButton;
    btnAlterarWhere: TButton;
    btnExportarSQL: TButton;
    sdArquivos: TSaveDialog;
    btnDeletarDB: TcxButton;
    btnCancelaDB: TcxButton;
    btnRemoverTabelas: TcxButton;
    btnCancelaSchema: TcxButton;
    btnDeletaSchema: TcxButton;
    btnCancelaBanco: TcxButton;
    btnCancelaLink: TcxButton;
    btnRemoveLink: TcxButton;
    btnRemoverLinkCampo: TcxButton;
    btnCancelaCamposLink: TcxButton;
    btnVoltarTabela: TButton;
    pcSchemas: TPageControl;
    tsSchemaSincronia: TTabSheet;
    tsSchemaMigracao: TTabSheet;
    grListaMigracao: TDBGrid;
    dsMigracao: TDataSource;
    fmtMigracao: TFDMemTable;
    fmtMigracaoDESCRICAO: TStringField;
    fmtMigracaoDIR_ARQUIVO: TStringField;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btnCadBancoDadosClick(Sender: TObject);
    procedure btnRegTabelasClick(Sender: TObject);
    procedure dsBancosDeDadosStateChange(Sender: TObject);
    procedure btnNovoDBClick(Sender: TObject);
    procedure btnEditarDBClick(Sender: TObject);
    procedure btnSalvarDBClick(Sender: TObject);
    procedure btnTestarBancoDadosClick(Sender: TObject);
    procedure btnTabelasDBClick(Sender: TObject);
    procedure btnSelecionarTabelaClick(Sender: TObject);
    procedure btnSalvarTabelasClick(Sender: TObject);
    procedure btnVoltarTabelaClick(Sender: TObject);
    procedure dsSchemasStateChange(Sender: TObject);
    procedure btnNovoSchemaClick(Sender: TObject);
    procedure fmtSchemasAfterInsert(DataSet: TDataSet);
    procedure fmtSchemasAfterCancel(DataSet: TDataSet);
    procedure lbSelecionarArquivoOrigemClick(Sender: TObject);
    procedure lbSelecionarArquivoDestinoClick(Sender: TObject);
    procedure btnSelecionarBancoClick(Sender: TObject);
    procedure lbCriarLinksClick(Sender: TObject);
    procedure btnCriarLinkCamposClick(Sender: TObject);
    procedure Label32Click(Sender: TObject);
    procedure fmtCamposOrigemTIPOGetText(Sender: TField; var Text: string;
      DisplayText: Boolean);
    procedure fmtCamposDestinoTIPOGetText(Sender: TField; var Text: string;
      DisplayText: Boolean);
    procedure btnCriarLinkClick(Sender: TObject);
    procedure btnSalvarCamposLinksClick(Sender: TObject);
    procedure fmtCamposOrigemTAMANHOGetText(Sender: TField; var Text: string;
      DisplayText: Boolean);
    procedure fmtCamposDestinoTAMANHOGetText(Sender: TField; var Text: string;
      DisplayText: Boolean);
    procedure chkSemCampoOrigemClick(Sender: TObject);
    procedure btnSalvarLinkClick(Sender: TObject);
    procedure btnSalvarSchemaClick(Sender: TObject);
    procedure btnGerarExpressaoClick(Sender: TObject);
    procedure btnAlterarSchemaClick(Sender: TObject);
    procedure fmtSchemasAfterEdit(DataSet: TDataSet);
    procedure fmtTabelasOrigemSELGetText(Sender: TField; var Text: string;
      DisplayText: Boolean);
    procedure btnAlterarLinkClick(Sender: TObject);
    procedure fmtSchemasAfterPost(DataSet: TDataSet);
    procedure fmtSchemasAfterClose(DataSet: TDataSet);
    procedure VENDEDORES1Click(Sender: TObject);
    procedure btnZerarDatasClick(Sender: TObject);
    procedure BOPERADOR1Click(Sender: TObject);
    procedure dsBancosDeDadosDataChange(Sender: TObject; Field: TField);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btnProcurarBancoClick(Sender: TObject);
    procedure btnJoinTabelaClick(Sender: TObject);
    procedure btnAlterarWhereClick(Sender: TObject);
    procedure btnExportarSQLClick(Sender: TObject);
    procedure btnDeletarDBClick(Sender: TObject);
    procedure btnCancelaDBClick(Sender: TObject);
    procedure btnRemoverTabelasClick(Sender: TObject);
    procedure btnCancelaSchemaClick(Sender: TObject);
    procedure btnDeletaSchemaClick(Sender: TObject);
    procedure btnCancelaBancoClick(Sender: TObject);
    procedure btnCancelaLinkClick(Sender: TObject);
    procedure btnRemoveLinkClick(Sender: TObject);
    procedure btnRemoverLinkCampoClick(Sender: TObject);
    procedure btnCancelaCamposLinkClick(Sender: TObject);
    procedure fmtMigracaoAfterEdit(DataSet: TDataSet);
  private
    FSchema: TPluginSchemas;
    FLink: TPluginLink;
    FJoin: TPluginLinkJoin;
    FNomeOrigem, FNomeDestino: string;
    flbListaArquivos: TFileSearch;
    procedure CarregarBancosDeDados;
    procedure CarregaBancosParaSelecao(ATipo: integer);
    procedure CarregarTabelas;
    procedure CarregarSchemas;
    procedure CarregarMigracao;
    procedure AdicionarTabelaLista(ATabela: string);
    function TextoMemoBancos(var AMemo: TMemo; AJson: string): string;
    function TextoMemoTabelas(AJson: string): string;
    procedure CarregarTabelasOrigem(ASistema: string);
    procedure CarregarTabelasDestino(ASistema: string);
    procedure HandleDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure HandleCellClick(var AMemTable: TFDMemTable);
    procedure HandleCellClickDestino(Column: TColumn);
    procedure HandleCellClickOrigem(Column: TColumn);
    procedure CarregarCamposTabelaOrigem(ANovo: boolean);
    procedure CarregarCamposTabelaDestino(ANovo: boolean);
    procedure AdicionarLinkCampoLista(ACampoOrigem, ACampoDestino: string);
    procedure DesabilitarDataSetCamposOrigem(AEnabled: boolean);
    procedure AdicionarTabelasLinkadas(ATabelaOrigem, ATabelaDestino: string);
    procedure NumerarOrdemTabelasRelacionadas;
    procedure HandleDrawColumnCellTabelas(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    function VerificarCamposDestinosObrigatoriosNaoSelecionados: boolean;
    procedure HandleDrawColumnCellCampos(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure CarregaTabelasDependentes;
    function CheckTabelasDependentes: boolean;
    procedure UnirTabelaAOrigem(AJson: string; ANovo: boolean);
  public
    { Public declarations }
  end;

var
  fmCadastros: TfmCadastros;

implementation

{$R *.dfm}

procedure TfmCadastros.AdicionarLinkCampoLista(ACampoOrigem,
  ACampoDestino: string);
begin
  lbListaCamposLink.Items.Add(ACampoOrigem+' --> '+ACampoDestino);
end;

procedure TfmCadastros.AdicionarTabelaLista(ATabela: string);
begin
  lbListaTabelasSelecionadas.Items.Add(ATabela);
end;

procedure TfmCadastros.AdicionarTabelasLinkadas(ATabelaOrigem,
  ATabelaDestino: string);
begin
  lbListaLinks.Items.Add(ATabelaOrigem+' --> '+ATabelaDestino);
end;

procedure TfmCadastros.BOPERADOR1Click(Sender: TObject);
var
  lConexao: TJSONObject;
  ldmCon: TdmConexao;
begin
  lConexao := TJSONObject.Create
                .AddPair('nome', edNome.Text)
                .AddPair('servidor', edServidor.Text)
                .AddPair('porta', edPorta.Text)
                .AddPair('caminho',edCaminho.Text)
                .AddPair('usuario', edUsuario.Text)
                .AddPair('senha', edSenha.Text)
                .AddPair('tipo', cbTipoDB.ItemIndex.ToString)
                .AddPair('sistema', fmtBancosDeDadosSISTEMA.AsString);
  ldmCon := TdmConexao.Create(nil);
  try
    ldmCon.Conectar(lConexao.ToJSON);
    if ldmCon.Conectado then
      ldmCon.Execute('update SINCRONIZACAO_PLUGIN set '+TMenuItem(Sender).Caption+' = dateadd(year, -10, current_timestamp)', ldmCon.Conexao);
  finally
    lConexao.Free;
    ldmCon.Free;
  end;
end;

procedure TfmCadastros.btnAlterarLinkClick(Sender: TObject);
var
  lTabelaOrigem, lTabelaDestino: string;
begin
  if lbListaLinks.ItemIndex < 0 then
  begin
    raise Exception.Create('Nenhum link selecionado');
  end;
  lbListaCamposLink.Items.Clear;
  lTabelaOrigem := ExtrairTextoAPartirDePosicao(lbListaLinks.Items[lbListaLinks.ItemIndex], ' --> ', EXTRAIR_PRE_TRECHO);
  lTabelaDestino := ExtrairTextoAPartirDePosicao(lbListaLinks.Items[lbListaLinks.ItemIndex], ' --> ', EXTRAIR_POS_TRECHO);

  if not fmtTabelasOrigem.Locate('DESCRICAO', lTabelaOrigem, [loCaseInsensitive]) then
  begin
    raise Exception.Create('Tabela de ORIGEM não encontrada');
  end;

  if not fmtTabelasDestino.Locate('DESCRICAO', lTabelaDestino, [loCaseInsensitive]) then
  begin
    raise Exception.Create('Tabela de DESTINO não encontrada');
  end;

  FLink := TPluginLink.Novo(FSchema.GetLinkByTables(lTabelaOrigem, lTabelaDestino).Salvar);
  CarregarCamposTabelaOrigem(False);
  CarregarCamposTabelaDestino(False);
  pcPrincipal.ActivePage := tsCadLinksCampos;
end;

procedure TfmCadastros.btnAlterarSchemaClick(Sender: TObject);
begin
  if pcSchemas.ActivePage = tsSchemaSincronia then
  begin
    TextoMemoBancos(mmBancoOrigem,  LerJsonFromJson(LerJsonFromFile(fmtSchemasDIR_ARQUIVO.AsString), 'bancoorigem'));
    TextoMemoBancos(mmBancoDestino, LerJsonFromJson(LerJsonFromFile(fmtSchemasDIR_ARQUIVO.AsString), 'bancodestino'));
    TextoMemoTabelas(LerJsonArray(LerJsonFromFile(fmtSchemasDIR_ARQUIVO.AsString), 'links'));
    fmtSchemas.Edit;
  end
  else
  begin
    TextoMemoBancos(mmBancoOrigem,  LerJsonFromJson(LerJsonFromFile(fmtMigracaoDIR_ARQUIVO.AsString), 'bancoorigem'));
    TextoMemoBancos(mmBancoDestino, LerJsonFromJson(LerJsonFromFile(fmtMigracaoDIR_ARQUIVO.AsString), 'bancodestino'));
    TextoMemoTabelas(LerJsonArray(LerJsonFromFile(fmtMigracaoDIR_ARQUIVO.AsString), 'links'));
    fmtMigracao.Edit;
  end;
end;

procedure TfmCadastros.btnAlterarWhereClick(Sender: TObject);
begin
  fmMontaWhere := TfmMontaWhere.Create(Self);
  try
    fmMontaWhere.mmWhereAdicional.Lines.Text := FLink.WhereAdicional;
    fmMontaWhere.mmWherePadrao.Lines.Text := FLink.WhereSelect;
    if fmMontaWhere.ShowModal = mrOk then
      FLink.WhereAdicional := fmMontaWhere.mmWhereAdicional.Lines.Text;
  finally
    fmMontaWhere.Free;
  end;
end;

procedure TfmCadastros.btnCadBancoDadosClick(Sender: TObject);
begin
  pcPrincipal.ActivePage := tsCadBancoDados;
  CarregarBancosDeDados;
end;

procedure TfmCadastros.btnCancelaBancoClick(Sender: TObject);
begin
  pcPrincipal.ActivePage := tsCadSchemas;
end;

procedure TfmCadastros.btnCancelaCamposLinkClick(Sender: TObject);
begin
  pcPrincipal.ActivePage := tsCadLinks;
  FLink.Free;
end;

procedure TfmCadastros.btnCancelaDBClick(Sender: TObject);
begin
  if fmtBancosDeDados.State in [dsInsert, dsEdit] then
    fmtBancosDeDados.Cancel;
end;

procedure TfmCadastros.btnCancelaLinkClick(Sender: TObject);
begin
  TextoMemoTabelas(LerJsonArray(FSchema.Salvar, 'links'));
  pcPrincipal.ActivePage := tsCadSchemas;
end;

procedure TfmCadastros.btnCancelaSchemaClick(Sender: TObject);
begin
  if ShowQuestion('Deseja cancelar?') then
  begin
    if pcSchemas.ActivePage = tsSchemaSincronia then
    begin
      fmtSchemas.Cancel;
      CarregarSchemas;
    end
    else
    begin
      fmtMigracao.Cancel;
      CarregarMigracao;
    end;
  end;
end;

procedure TfmCadastros.btnDeletarDBClick(Sender: TObject);
begin
  fmtBancosDeDados.Delete;
end;

procedure TfmCadastros.btnDeletaSchemaClick(Sender: TObject);
begin
  if pcSchemas.ActivePage = tsSchemaSincronia then
  begin
    if fmtSchemas.IsEmpty then
      raise Exception.Create('Nenhum registro encontrado');
    if ShowQuestion('Deseja excluir o registro de esquema selecionado?') then
      if FileExists(fmtSchemasDIR_ARQUIVO.AsString) then
      begin
        DeleteFile(fmtSchemasDIR_ARQUIVO.AsString);
        fmtSchemas.Delete;
      end;
  end
  else
  begin
    if fmtMigracao.IsEmpty then
      raise Exception.Create('Nenhum registro encontrado');
    if ShowQuestion('Deseja excluir o registro de esquema selecionado?') then
      if FileExists(fmtMigracaoDIR_ARQUIVO.AsString) then
      begin
        DeleteFile(fmtMigracaoDIR_ARQUIVO.AsString);
        fmtMigracao.Delete;
      end;
  end;
end;

procedure TfmCadastros.btnEditarDBClick(Sender: TObject);
begin
  fmtBancosDeDados.Edit;
  edNome.SetFocus;
end;

procedure TfmCadastros.btnExportarSQLClick(Sender: TObject);
var
  lTabelaOrigem, lTabelaDestino, lArquivoLocal: string;
  lListaSQL: TStringList;
  I: Integer;
begin
  if lbListaLinks.Count = 0 then
    raise Exception.Create('Nenhum link cadastrado');

  if ShowQuestion('Deseja exportar o SQL?') then
  begin
    lListaSQL := TStringList.Create;
    if lbListaLinks.ItemIndex < 0 then
    begin
      for I := 0 to lbListaLinks.Items.Count - 1 do
      begin
        lTabelaOrigem := ExtrairTextoAPartirDePosicao(lbListaLinks.Items[I], ' --> ', EXTRAIR_PRE_TRECHO);
        lTabelaDestino := ExtrairTextoAPartirDePosicao(lbListaLinks.Items[I], ' --> ', EXTRAIR_POS_TRECHO);
        lListaSQL.Add('/******************************** '+lTabelaOrigem+' ********************************/');
        lListaSQL.Add(' ');
        lListaSQL.Add(FSchema.GetLinkByTables(lTabelaOrigem, lTabelaDestino).GetSelect);
        lListaSQL.Add(' ');
        lListaSQL.Add(' ');
      end;
      sdArquivos.FileName := LerJson(FSchema.BaseOrigem.Salvar, 'nome')+'_PARA_'+LerJson(FSchema.BaseDestino.Salvar, 'nome');
      if sdArquivos.Execute then
        lArquivoLocal := sdArquivos.FileName;
      if not (lArquivoLocal.IsEmpty) then
      begin
        lListaSQL.SaveToFile(lArquivoLocal);
        ShowMessage('Arquivo criado com sucesso');
        lbListaLinks.ItemIndex := -1;
      end;
    end else
    begin
      lTabelaOrigem := ExtrairTextoAPartirDePosicao(lbListaLinks.Items[lbListaLinks.ItemIndex], ' --> ', EXTRAIR_PRE_TRECHO);
      lTabelaDestino := ExtrairTextoAPartirDePosicao(lbListaLinks.Items[lbListaLinks.ItemIndex], ' --> ', EXTRAIR_POS_TRECHO);
      lListaSQL.Add(FSchema.GetLinkByTables(lTabelaOrigem, lTabelaDestino).GetSelect);
      sdArquivos.FileName := lTabelaOrigem;
      if sdArquivos.Execute then
        lArquivoLocal := sdArquivos.FileName;
      if not (lArquivoLocal.IsEmpty) then
      begin
        lListaSQL.SaveToFile(lArquivoLocal);
        ShowMessage('Arquivo criado com sucesso');
        lbListaLinks.ItemIndex := -1;
      end;
    end;
    lListaSQL.Free;
  end;
end;

procedure TfmCadastros.btnGerarExpressaoClick(Sender: TObject);
var
  lExpressao: string;
begin
  lExpressao := TfmMontarExperssao.GetExpression(fmtCamposOrigemCAMPO.AsString,
                                                 fmtCamposDestinoCAMPO.AsString,
                                                 fmtCamposOrigemTIPO.AsString,
                                                 fmtCamposDestinoTIPO.AsString,
                                                 fmtCamposDestinoTAMANHO.AsString);
  if not (lExpressao.IsEmpty) then
    mmExpressaoLivre.Lines.Text := lExpressao;
end;

procedure TfmCadastros.btnJoinTabelaClick(Sender: TObject);
begin
  if (not (fmtCamposOrigemCHAVEESTRANGEIRA.AsString = 'S')) and (not (fmtCamposOrigemCHAVEPRIMARIA.AsString = 'S')) then
    if not ShowQuestion('O campo "'+fmtCamposOrigemCAMPO.AsString+'" não é uma chave Primaria/Estrangeira. Deseja criar união de tabelas mesmo assim?') then
      Exit;
  fmSelecionarTabelaJoin := TfmSelecionarTabelaJoin.Create(Self);
  try
    fmSelecionarTabelaJoin.SetDadosAtual(LerJson(FSchema.BaseOrigem.Salvar, 'sistema'), fmtCamposOrigemCAMPO.AsString, FLink.TabelaOrigem);
    if fmSelecionarTabelaJoin.ShowModal = mrOk then
    begin
      UnirTabelaAOrigem(LerJsonFromFile(fmSelecionarTabelaJoin.fmtTabelasOrigemARQUIVO.AsString), True);
      FLink.AddTabelaJoin(fmSelecionarTabelaJoin.fmtTabelasOrigemDESCRICAO.AsString, fmSelecionarTabelaJoin.GetTipoJoin, fmSelecionarTabelaJoin.mmCondicao.Lines.Text);
    end;
  finally
    fmSelecionarTabelaJoin.Free;
  end;
end;

procedure TfmCadastros.btnNovoDBClick(Sender: TObject);
begin
  fmtBancosDeDados.Append;
  edNome.SetFocus;
end;

procedure TfmCadastros.btnNovoSchemaClick(Sender: TObject);
begin
  TextoMemoBancos(mmBancoOrigem, '');
  TextoMemoBancos(mmBancoDestino, '');
  TextoMemoTabelas('');
  if pcSchemas.ActivePage = tsSchemaSincronia then
    fmtSchemas.Insert
  else
    fmtMigracao.Insert;
end;

procedure TfmCadastros.btnProcurarBancoClick(Sender: TObject);
var
  lArquivo: string;
begin
  if odArquivosBanco.Execute then
  begin
    lArquivo := odArquivosBanco.FileName;
    if LowerCase(ExtractFileExt(lArquivo)) = '.fdb' then
      fmtBancosDeDadosCAMINHO.AsString := lArquivo;
    if LowerCase(ExtractFileExt(lArquivo)) = '.ini' then
    begin
      fmtBancosDeDadosSERVIDOR.AsString := LerIni(IfThen(cbSistema.ItemIndex = 0, 'DB', 'BANCO'), IfThen(cbSistema.ItemIndex = 0, 'SERVER', 'SERVIDOR'), '', lArquivo);
      fmtBancosDeDadosPORTA.AsString    := LerIni(IfThen(cbSistema.ItemIndex = 0, 'DB', 'BANCO'), IfThen(cbSistema.ItemIndex = 0, 'PORT', 'PORTA'), '', lArquivo);
      fmtBancosDeDadosCAMINHO.AsString  := LerIni(IfThen(cbSistema.ItemIndex = 0, 'DB', 'BANCO'), IfThen(cbSistema.ItemIndex = 0, 'DATABASE', 'ARQUIVO'), '', lArquivo);
      fmtBancosDeDadosUSUARIO.AsString  := LerIni(IfThen(cbSistema.ItemIndex = 0, 'DB', 'BANCO'), IfThen(cbSistema.ItemIndex = 0, 'USER_NAME', 'USERNAME'), '', lArquivo);
      fmtBancosDeDadosSENHA.AsString    := LerIni(IfThen(cbSistema.ItemIndex = 0, 'DB', 'BANCO'), IfThen(cbSistema.ItemIndex = 0, 'PASSWORD', 'PASSWORD'), '', lArquivo);
    end;
  end;
end;

procedure TfmCadastros.btnRegTabelasClick(Sender: TObject);
begin
  pcPrincipal.ActivePage := tsCadSchemas;
  CarregarSchemas;
  CarregarMigracao;
end;

procedure TfmCadastros.btnRemoveLinkClick(Sender: TObject);
var
  lTabelaOrigem, lTabelaDestino: string;
begin
  if lbListaLinks.ItemIndex < 0 then
  begin
    raise Exception.Create('Nenhum item selecionado');
  end;
  if ShowQuestion('Tem certeza que deseja remover o link entre as tabelas selecionado?') then
  begin
    lTabelaOrigem := ExtrairTextoAPartirDePosicao(lbListaLinks.Items[lbListaLinks.ItemIndex], ' --> ', EXTRAIR_PRE_TRECHO);
    lTabelaDestino := ExtrairTextoAPartirDePosicao(lbListaLinks.Items[lbListaLinks.ItemIndex], ' --> ', EXTRAIR_POS_TRECHO);
    FSchema.DeleteLink(FSchema.GetLinkByTables(lTabelaOrigem, lTabelaDestino));
    lbListaLinks.DeleteSelected;
    if fmtTabelasOrigem.Locate('DESCRICAO', lTabelaOrigem, [loCaseInsensitive]) then
    begin
      fmtTabelasOrigem.Edit;
      fmtTabelasOrigemORDEM.Clear;
      fmtTabelasOrigem.Post;
    end;
    if fmtTabelasDestino.Locate('DESCRICAO', lTabelaDestino, [loCaseInsensitive]) then
    begin
      fmtTabelasDestino.Edit;
      fmtTabelasDestinoORDEM.Clear;
      fmtTabelasDestino.Post;
    end;
  end;
end;

procedure TfmCadastros.btnRemoverLinkCampoClick(Sender: TObject);
var
  lCampoOrigem, lCampoDestino: string;
begin
  if lbListaCamposLink.ItemIndex < 0 then
  begin
    raise Exception.Create('Nenhum item selecionado');
  end;
  lCampoOrigem := ExtrairTextoAPartirDePosicao(lbListaCamposLink.Items[lbListaCamposLink.ItemIndex], ' --> ', EXTRAIR_PRE_TRECHO);
  lCampoDestino := ExtrairTextoAPartirDePosicao(lbListaCamposLink.Items[lbListaCamposLink.ItemIndex], ' --> ', EXTRAIR_POS_TRECHO);
  if FLink.RemoverLinkFields(
       IfThen(
         ExtrairTabelaJoin(ExtrairTextoAPartirDePosicao(lbListaCamposLink.Items[lbListaCamposLink.ItemIndex], ' --> ', EXTRAIR_PRE_TRECHO)).IsEmpty,
         FLink.TabelaOrigem,
         ExtrairTabelaJoin(ExtrairTextoAPartirDePosicao(lbListaCamposLink.Items[lbListaCamposLink.ItemIndex], ' --> ', EXTRAIR_PRE_TRECHO))
       ),
       IfThen(ExtrairCampoJoin(lCampoOrigem).IsEmpty, lCampoOrigem, ExtrairCampoJoin(lCampoOrigem)),
       lCampoDestino
  ) then
  begin
    if not (lCampoOrigem.IsEmpty) then
      if fmtCamposOrigem.Locate('CAMPO', lCampoOrigem, [loCaseInsensitive]) then
      begin
        fmtCamposOrigem.Edit;
        fmtCamposOrigemUSADO.AsInteger := 0;
        fmtCamposOrigem.Post;
      end;

    if fmtCamposDestino.Locate('CAMPO', lCampoDestino, [loCaseInsensitive]) then
    begin
      fmtCamposDestino.Edit;
      fmtCamposDestinoUSADO.AsInteger := 0;
      fmtCamposDestino.Post;
    end;
    lbListaCamposLink.DeleteSelected;
  end;
end;

procedure TfmCadastros.btnRemoverTabelasClick(Sender: TObject);
var
  lNomeTabela: string;
begin
  if lbListaTabelasSelecionadas.ItemIndex < 0 then
  begin
    raise Exception.Create('Nenhum item selecionado');
  end;
  if ShowQuestion('Tem certeza que deseja remover o arquivo da tabela selecionada?') then
  begin
    lNomeTabela := lbListaTabelasSelecionadas.Items[lbListaTabelasSelecionadas.ItemIndex];
    fmtTabelas.Filtered := False;
    if fmtTabelas.Locate('NOME', lNomeTabela, [loCaseInsensitive]) then
    begin
      fmtTabelas.Edit;
      fmtTabelasSELECIONADO.AsInteger := 0;
      fmtTabelas.Post;
    end;
    lbListaTabelasSelecionadas.DeleteSelected;
    fmtTabelas.Filtered := True;
    if FileExists(IncludeTrailingPathDelimiter(DirTabelas)+lNomeTabela+'.json') then
      DeleteFile(IncludeTrailingPathDelimiter(DirTabelas)+lNomeTabela+'.json');
  end;
end;

procedure TfmCadastros.btnSalvarDBClick(Sender: TObject);
var
  lConexao: TJSONObject;
  lBancos: TPluginDatabases;
  lJson: string;
begin
  if fmtBancosDeDados.State in [dsInsert, dsEdit] then
  begin
    lConexao := TJSONObject.Create
                .AddPair('nome', fmtBancosDeDadosNOME.AsString)
                .AddPair('servidor', fmtBancosDeDadosSERVIDOR.AsString)
                .AddPair('porta', fmtBancosDeDadosPORTA.AsString)
                .AddPair('caminho', fmtBancosDeDadosCAMINHO.AsString)
                .AddPair('usuario', fmtBancosDeDadosUSUARIO.AsString)
                .AddPair('senha', fmtBancosDeDadosSENHA.AsString)
                .AddPair('tipo', cbTipoDB.ItemIndex.ToString)
                .AddPair('sistema', fmtBancosDeDadosSISTEMA.AsString);
    lJson := lConexao.ToJSON;
    lConexao.Free;
    lBancos := TPluginDatabases.Create(lJson);
    try
      if lBancos.SalvarArquivo then
        fmtBancosDeDados.Post;
    finally
      lBancos.Free;
    end;
  end;
end;

procedure TfmCadastros.btnSalvarLinkClick(Sender: TObject);
begin
  //Validações
  if lbListaLinks.Items.Count = 0 then
  begin
    raise Exception.Create('Nenhum link entre tabelas encontrado');
  end;
  TextoMemoTabelas(LerJsonArray(FSchema.Salvar, 'links'));
  pcPrincipal.ActivePage := tsCadSchemas;
end;

procedure TfmCadastros.btnSalvarSchemaClick(Sender: TObject);
begin
  if FSchema.SalvarArquivo(IfThen(pcSchemas.ActivePage = tsSchemaSincronia, DirSchemas, DirSchemasMigracao)) then
  begin
    if pcSchemas.ActivePage = tsSchemaSincronia then
      fmtSchemas.Post
    else
      fmtMigracao.Post;
  end;
end;

procedure TfmCadastros.btnSalvarTabelasClick(Sender: TObject);
var
  I, O: Integer;
  lJsonCampos, lConexaoStr: string;
  lConexao: TJSONObject;
  ldmConexao: TdmConexao;
  lTables: TPluginTables;
  lCampos: TJSONArray;
  lACampo: string;
  lTipo, lTamanho: integer;
  lChavePrimaria, lChaveEstrangeira: boolean;
  lChaveEstrangeiraNomeTabela: string;
  lPermiteNulo: boolean;
  lValorPadrao: string;
begin
  if lbListaTabelasSelecionadas.Count = 0 then
  begin
    raise Exception.Create('Nenhum item lançado');
  end;
  lConexao := TJSONObject.Create
                .AddPair('nome', fmtBancosDeDadosNOME.AsString)
                .AddPair('servidor', fmtBancosDeDadosSERVIDOR.AsString)
                .AddPair('porta', fmtBancosDeDadosPORTA.AsString)
                .AddPair('caminho', fmtBancosDeDadosCAMINHO.AsString)
                .AddPair('usuario', fmtBancosDeDadosUSUARIO.AsString)
                .AddPair('senha', fmtBancosDeDadosSENHA.AsString)
                .AddPair('tipo', fmtBancosDeDadosTIPO.AsString)
                .AddPair('sistema', fmtBancosDeDadosSISTEMA.AsString);
  lConexaoStr := lConexao.ToJSON;
  lConexao.Free;
  ldmConexao := TdmConexao.Create(nil);
  try
    ldmConexao.Conectar(lConexaoStr);
    if ldmConexao.Conectado then
    begin
      for I := 0 to lbListaTabelasSelecionadas.Count - 1 do
      begin
        lJsonCampos := ldmConexao.Select(ldmConexao.GetScript(1).Replace(':TABELA', QuotedStr(lbListaTabelasSelecionadas.Items[I])));
        lTables := TPluginTables.Create;
        try
          lTables.SetTabela(lbListaTabelasSelecionadas.Items[I]);
          lTables.SetSistema(LerJson(lConexaoStr, 'sistema'));
          lCampos := TJSONObject.ParseJSONValue(lJsonCampos) as TJSONArray;
          try
            for O := 0 to lCampos.Count - 1 do
            begin
              lACampo := lCampos.Items[O].GetValue<string>('FIELD_NAME');
              lTipo := lTables.StrTypeFieldsToIntTypeFields(lCampos.Items[O].GetValue<string>('FIELD_TYPE'));
              case lTipo of
                0: lTamanho := lCampos.Items[O].GetValue<integer>('FIELD_LENGTH');
                1,2,3,4,5: lTamanho := 0;
              end;
              lChavePrimaria := lCampos.Items[O].GetValue<string>('CONSTRAINT_TYPE') = 'PRIMARY KEY';
              lChaveEstrangeira := lCampos.Items[O].GetValue<string>('CONSTRAINT_TYPE') = 'FOREIGN KEY';
              lChaveEstrangeiraNomeTabela := lCampos.Items[O].GetValue<string>('RELATION_NAME');
              lPermiteNulo := lCampos.Items[O].GetValue<integer>('NOT_NULL') = 0;
              lValorPadrao := lCampos.Items[O].GetValue<string>('DEFAULT_VALUE');
              lTables.AddCampo(
                lACampo,
                lTipo,
                lTamanho,
                lChavePrimaria,
                lChaveEstrangeira,
                lChaveEstrangeiraNomeTabela,
                lPermiteNulo,
                lValorPadrao
              );
            end;
            lTables.SalvarArquivo;
          finally
            lCampos.Free;
          end;
        finally
          lTables.Free;
        end;
      end;
    end;
  finally
    ldmConexao.Free;
  end;
  pcPrincipal.ActivePage := tsCadBancoDados;
end;

procedure TfmCadastros.btnSelecionarBancoClick(Sender: TObject);
begin
  pcPrincipal.ActivePage := tsCadSchemas;
  if fmtSelecionaBancosTIPO.AsInteger = 0 then //Origem
  begin
    FSchema.AddBaseOrigem(LerJsonFromFile(fmtSelecionaBancosARQUIVO.AsString));
    TextoMemoBancos(mmBancoOrigem, LerJsonFromFile(fmtSelecionaBancosARQUIVO.AsString));
  end;
  if fmtSelecionaBancosTIPO.AsInteger = 1 then //Destino
  begin
    FSchema.AddBaseDestino(LerJsonFromFile(fmtSelecionaBancosARQUIVO.AsString));
    TextoMemoBancos(mmBancoDestino, LerJsonFromFile(fmtSelecionaBancosARQUIVO.AsString));
  end;
end;

procedure TfmCadastros.btnSelecionarTabelaClick(Sender: TObject);
var
  lNomeTabela: string;
begin
  lNomeTabela := fmtTabelasNOME.AsString;
  if not CheckTabelasDependentes then
    Exit;

  AdicionarTabelaLista(lNomeTabela);
  if fmtTabelas.Locate('NOME', lNomeTabela, [loPartialKey]) then
  begin
    fmtTabelas.Edit;
    fmtTabelasSELECIONADO.AsInteger := 1;
    fmtTabelas.Post;
  end;
end;

procedure TfmCadastros.btnTabelasDBClick(Sender: TObject);
begin
  pcPrincipal.ActivePage := tsCadTabelas;
  CarregarTabelas;
  CarregaTabelasDependentes;
end;

procedure TfmCadastros.btnTestarBancoDadosClick(Sender: TObject);
var
  lConexao: TJSONObject;
begin
  lConexao := TJSONObject.Create
                .AddPair('nome', edNome.Text)
                .AddPair('servidor', edServidor.Text)
                .AddPair('porta', edPorta.Text)
                .AddPair('caminho',edCaminho.Text)
                .AddPair('usuario', edUsuario.Text)
                .AddPair('senha', edSenha.Text)
                .AddPair('tipo', cbTipoDB.ItemIndex.ToString)
                .AddPair('sistema', fmtBancosDeDadosSISTEMA.AsString);
  if TdmConexao.TestarConexao(lConexao.ToJSON) then
    ShowMessage('Conectado com sucesso')
  else
    ShowMessage('Erro ao se conectar');
  lConexao.Free;
end;

procedure TfmCadastros.btnVoltarTabelaClick(Sender: TObject);
begin
  pcPrincipal.ActivePage := tsCadBancoDados;
end;

procedure TfmCadastros.btnZerarDatasClick(Sender: TObject);
var
  lConexao: TJSONObject;
  ldmCon: TdmConexao;
begin
  lConexao := TJSONObject.Create
                .AddPair('nome', edNome.Text)
                .AddPair('servidor', edServidor.Text)
                .AddPair('porta', edPorta.Text)
                .AddPair('caminho',edCaminho.Text)
                .AddPair('usuario', edUsuario.Text)
                .AddPair('senha', edSenha.Text)
                .AddPair('tipo', cbTipoDB.ItemIndex.ToString)
                .AddPair('sistema', fmtBancosDeDadosSISTEMA.AsString);
  ldmCon := TdmConexao.Create(nil);
  try
    ldmCon.Conectar(lConexao.ToJSON);
    if ldmCon.Conectado then
      if cbSistema.ItemIndex = 0 then
      begin
        ldmCon.Execute('update SINCRONIZACAO_PLUGIN ' +
                       'set CLIENTES = dateadd(year, -10, current_timestamp), ' +
                         'FORNECEDORES = dateadd(year, -10, current_timestamp), ' +
                         'GRUPOS = dateadd(year, -10, current_timestamp), ' +
                         'GRUPOSCLIENTE = dateadd(year, -10, current_timestamp), ' +
                         'MARCAS = dateadd(year, -10, current_timestamp), ' +
                         'SUBGRUPOS = dateadd(year, -10, current_timestamp), ' +
                         'PRODUTOS = dateadd(year, -10, current_timestamp), ' +
                         'CAIXAS = dateadd(year, -10, current_timestamp), ' +
                         'CAIXA_TIPOS_MOVIMENTOS = dateadd(year, -10, current_timestamp), ' +
                         'DESPESAS = dateadd(year, -10, current_timestamp), ' +
                         'EQUIPAMENTOS = dateadd(year, -10, current_timestamp), ' +
                         'EQUIPAMENTOS_CLIENTES = dateadd(year, -10, current_timestamp), ' +
                         'ESTOQUE = dateadd(year, -10, current_timestamp), ' +
                         'FILIAIS = dateadd(year, -10, current_timestamp), ' +
                         'PARCELAS_PRAZOS = dateadd(year, -10, current_timestamp), ' +
                         'PRAZOS = dateadd(year, -10, current_timestamp), ' +
                         'REGRASTRIBUTACAO = dateadd(year, -10, current_timestamp), ' +
                         'SERVICOS = dateadd(year, -10, current_timestamp), ' +
                         'TECNICOS = dateadd(year, -10, current_timestamp), ' +
                         'TIPOS_DOCUMENTOS = dateadd(year, -10, current_timestamp), ' +
                         'TIPOS_PAGAMENTOS = dateadd(year, -10, current_timestamp), ' +
                         'TIPO_ESTOQUE_MOV = dateadd(year, -10, current_timestamp), ' +
                         'UNIDADE_MEDIDA = dateadd(year, -10, current_timestamp), ' +
                         'VENDEDORES = dateadd(year, -10, current_timestamp), '+
                         'PRODUTOS_FORNECEDORES = dateadd(year, -10, current_timestamp)', ldmCon.Conexao);
        ldmCon.Execute(['update CLIENTES set DATA_ALTERADO = current_timestamp; ',
                        'update FORNECEDORES set DATA_ALTERADO = current_timestamp; ',
                        'update GRUPOS set DATA_ALTERADO = current_timestamp; ',
                        'update GRUPOSCLIENTE set DATA_ALTERADO = current_timestamp; ',
                        'update MARCAS set DATA_ALTERADO = current_timestamp; ',
                        'update SUBGRUPOS set DATA_ALTERADO = current_timestamp; ',
                        'update PRODUTOS set DATA_ALTERADO = current_timestamp; ',
                        'update CAIXAS set DATA_ALTERADO = current_timestamp; ',
                        'update CAIXA_TIPOS_MOVIMENTOS set DATA_ALTERADO = current_timestamp; ',
                        'update DESPESAS set DATA_ALTERADO = current_timestamp; ',
                        'update EQUIPAMENTOS set DATA_ALTERADO = current_timestamp; ',
                        'update EQUIPAMENTOS_CLIENTES set DATA_ALTERADO = current_timestamp; ',
                        'update ESTOQUE set DATA_ALTERADO = current_timestamp; ',
                        'update FILIAIS set DATA_ALTERADO = current_timestamp; ',
                        'update PARCELAS_PRAZOS set DATA_ALTERADO = current_timestamp; ',
                        'update PRAZOS set DATA_ALTERADO = current_timestamp; ',
                        'update REGRASTRIBUTACAO set DATA_ALTERADO = current_timestamp; ',
                        'update SERVICOS set DATA_ALTERADO = current_timestamp; ',
                        'update TECNICOS set DATA_ALTERADO = current_timestamp; ',
                        'update TIPOS_DOCUMENTOS set DATA_ALTERADO = current_timestamp; ',
                        'update TIPOS_PAGAMENTOS set DATA_ALTERADO = current_timestamp; ',
                        'update TIPO_ESTOQUE_MOV set DATA_ALTERADO = current_timestamp; ',
                        'update UNIDADE_MEDIDA set DATA_ALTERADO = current_timestamp; ',
                        'update VENDEDORES set DATA_ALTERADO = current_timestamp; ' ,
                        'update PRODUTOS_FORNECEDORES set DATA_ALTERADO = current_timestamp; '], ldmCon.Conexao);
      end
      else if cbSistema.ItemIndex = 0 then
      begin
        ldmCon.Execute('update SINCRONIZACAO_PLUGIN ' +
                       'set TB_CAIXA = dateadd(year, -10, current_timestamp), ' +
                           'TB_FORMA_PAGAMENTO = dateadd(year, -10, current_timestamp), ' +
                           'TB_FORNECEDOR = dateadd(year, -10, current_timestamp), ' +
                           'TB_GRUPO = dateadd(year, -10, current_timestamp), ' +
                           'TB_MARCA = dateadd(year, -10, current_timestamp), ' +
                           'TB_PESSOA = dateadd(year, -10, current_timestamp), ' +
                           'TB_PRODUTO = dateadd(year, -10, current_timestamp), ' +
                           'TB_UNIDADE = dateadd(year, -10, current_timestamp), ' +
                           'TB_OPERADOR = dateadd(year, -10, current_timestamp), '+
                           'TB_RELACIONAR = dateadd(year, -10, current_timestamp)', ldmCon.Conexao);
        ldmCon.Execute(['update TB_CAIXA set DATA_ALTERADO = current_timestamp; ',
                        'update TB_FORMA_PAGAMENTO set DATA_ALTERADO = current_timestamp; ',
                        'update TB_FORNECEDOR set DATA_ALTERADO = current_timestamp; ',
                        'update TB_GRUPO set DATA_ALTERADO = current_timestamp; ',
                        'update TB_MARCA set DATA_ALTERADO = current_timestamp; ',
                        'update TB_PESSOA set DATA_ALTERADO = current_timestamp; ',
                        'update TB_PRODUTO set DATA_ALTERADO = current_timestamp; ',
                        'update TB_UNIDADE set DATA_ALTERADO = current_timestamp; ',
                        'update TB_OPERADOR set DATA_ALTERADO = current_timestamp; ',
                        'update TB_RELACIONAR set DATA_ALTERADO = current_timestamp; '], ldmCon.Conexao);
      end;
  finally
    lConexao.Free;
    ldmCon.Free;
  end;
end;

procedure TfmCadastros.btnSalvarCamposLinksClick(Sender: TObject);
begin
  if VerificarCamposDestinosObrigatoriosNaoSelecionados then
  begin
    FSchema.AddLink(FLink);
    if lbListaLinks.ItemIndex < 0 then
      AdicionarTabelasLinkadas(FLink.TabelaOrigem, FLink.TabelaDestino);
    NumerarOrdemTabelasRelacionadas;
    pcPrincipal.ActivePage := tsCadLinks;
  end else
  begin
    ShowWarning('Existem campos obrigatorios na tabela de destino que não foram informados');
  end;
end;

procedure TfmCadastros.btnCriarLinkCamposClick(Sender: TObject);
begin
  if fmtTabelasOrigem.IsEmpty then
  begin
    raise Exception.Create('Nenhuma tabela de origem encontrada');
  end;
  if fmtTabelasDestino.IsEmpty then
  begin
    raise Exception.Create('Nenhuma tabela de destino encontrada');
  end;
  if not (fmtTabelasOrigem.Locate('SEL', 1, [loCaseInsensitive])) then
  begin
    raise Exception.Create('Nenhuma tabela de origem selecionada');
  end;
  if not (fmtTabelasDestino.Locate('SEL', 1, [loCaseInsensitive])) then
  begin
    raise Exception.Create('Nenhuma tabela de destino selecionada');
  end;
  if lbListaLinks.Count > 0 then
    lbListaLinks.ItemIndex := -1;
  FLink := TPluginLink.Novo;
  FLink.TabelaOrigem := fmtTabelasOrigemDESCRICAO.AsString;
  FLink.TabelaDestino := fmtTabelasDestinoDESCRICAO.AsString;
  CarregarCamposTabelaOrigem(True);
  CarregarCamposTabelaDestino(True);
  lbListaCamposLink.Items.Clear;
  pcPrincipal.ActivePage := tsCadLinksCampos;
end;

procedure TfmCadastros.btnCriarLinkClick(Sender: TObject);
begin
  if FLink.AddLinkFields(IfThen(chkSemCampoOrigem.Checked, '', IfThen(ExtrairTabelaJoin(fmtCamposOrigemCAMPO.AsString).IsEmpty, FLink.TabelaOrigem, ExtrairTabelaJoin(fmtCamposOrigemCAMPO.AsString)) ),
                         IfThen(chkSemCampoOrigem.Checked, '', IfThen(ExtrairTabelaJoin(fmtCamposOrigemCAMPO.AsString).IsEmpty, fmtCamposOrigemCAMPO.AsString, ExtrairCampoJoin(fmtCamposOrigemCAMPO.AsString))),
                         IfThen(chkSemCampoOrigem.Checked, '', fmtCamposOrigemTIPO.AsString),
                         fmtCamposDestinoCAMPO.AsString,
                         fmtCamposDestinoTIPO.AsString,
                         fmtCamposDestinoVALORPADRAO.AsString,
                         fmtCamposDestinoPERMITENULO.AsString,
                         mmExpressaoLivre.Lines.Text,
                         fmtCamposDestinoTAMANHO.AsInteger,
                         fmtCamposDestinoCHAVEPRIMARIA.AsString = 'S') then
  begin
    fmtCamposOrigem.Edit;
    fmtCamposOrigemUSADO.AsInteger := 1;
    fmtCamposOrigem.Post;

    fmtCamposDestino.Edit;
    fmtCamposDestinoUSADO.AsInteger := 1;
    fmtCamposDestino.Post;
    AdicionarLinkCampoLista(IfThen(chkSemCampoOrigem.Checked, '', fmtCamposOrigemCAMPO.AsString), fmtCamposDestinoCAMPO.AsString);
    mmExpressaoLivre.Lines.Clear;
  end;
end;

procedure TfmCadastros.CarregaBancosParaSelecao(ATipo: integer);
var
  I: integer;
  lArquivoAtual, lJsonAtual: string;
begin
  fmtSelecionaBancos.Close;
  fmtSelecionaBancos.Open;
  flbListaArquivos.Directory(DirBancoDeDados);
  flbListaArquivos.Extension('.json');
  flbListaArquivos.Execute;
  for I := 0 to flbListaArquivos.GetFileList.Count -1 do
  begin
    lArquivoAtual := flbListaArquivos.GetFileList[I];
    lJsonAtual := LerJsonFromFile(lArquivoAtual);
    if LerJson(lJsonAtual, 'tipo') = ATipo.ToString then
    begin
      fmtSelecionaBancos.Append;
      fmtSelecionaBancosNOME.AsString := LerJson(lJsonAtual, 'nome');
      fmtSelecionaBancosSERVIDOR.AsString := LerJson(lJsonAtual, 'servidor');
      fmtSelecionaBancosPORTA.AsString := LerJson(lJsonAtual, 'porta');
      fmtSelecionaBancosCAMINHO.AsString := LerJson(lJsonAtual, 'caminho');
      fmtSelecionaBancosUSUARIO.AsString := LerJson(lJsonAtual, 'usuario');
      fmtSelecionaBancosSENHA.AsString := LerJson(lJsonAtual, 'senha');
      fmtSelecionaBancosTIPO.AsString := LerJson(lJsonAtual, 'tipo');
      fmtSelecionaBancosSISTEMA.AsString := LerJson(lJsonAtual, 'sistema');
      fmtSelecionaBancosARQUIVO.AsString := lArquivoAtual;
      fmtSelecionaBancos.Post;
    end;
  end;
  fmtSelecionaBancos.First;
end;

procedure TfmCadastros.CarregarBancosDeDados;
var
  I: integer;
  lArquivoAtual, lJsonAtual: string;
begin
  fmtBancosDeDados.Close;
  fmtBancosDeDados.Open;
  flbListaArquivos.Directory(IncludeTrailingPathDelimiter(DirBancoDeDados));
  flbListaArquivos.Extension('.json');
  flbListaArquivos.Execute;
  for I := 0 to flbListaArquivos.GetFileList.Count -1 do
  begin
    lArquivoAtual := flbListaArquivos.GetFileList[I];
    lJsonAtual := LerJsonFromFile(lArquivoAtual);
    fmtBancosDeDados.Append;
    fmtBancosDeDadosNOME.AsString := LerJson(lJsonAtual, 'nome');
    fmtBancosDeDadosSERVIDOR.AsString := LerJson(lJsonAtual, 'servidor');
    fmtBancosDeDadosPORTA.AsString := LerJson(lJsonAtual, 'porta');
    fmtBancosDeDadosCAMINHO.AsString := LerJson(lJsonAtual, 'caminho');
    fmtBancosDeDadosUSUARIO.AsString := LerJson(lJsonAtual, 'usuario');
    fmtBancosDeDadosSENHA.AsString := LerJson(lJsonAtual, 'senha');
    fmtBancosDeDadosTIPO.AsString := LerJson(lJsonAtual, 'tipo');
    fmtBancosDeDadosSISTEMA.AsString := LerJson(lJsonAtual, 'sistema');
    fmtBancosDeDados.Post;
  end;
  fmtBancosDeDados.First;
end;

procedure TfmCadastros.CarregarCamposTabelaOrigem(ANovo: boolean);
var
  lJsonTabela, lJsonCampos: string;
  lCampos: TJSONArray;
  I: Integer;
begin
  fmtCamposOrigem.Close;
  fmtCamposOrigem.Open;
  lJsonTabela := LerJsonFromFile(fmtTabelasOrigemARQUIVO.AsString);
  lJsonCampos := LerJsonArray(lJsonTabela, 'campos');
  lCampos := TJSONObject.ParseJSONValue(lJsonCampos) as TJSONArray;
  try
    for I := 0 to lCampos.Count - 1 do
    begin
      if not (lCampos.Items[I].GetValue<string>('campo') = 'DATA_ALTERADO') then
      begin
        fmtCamposOrigem.Append;
        fmtCamposOrigemCAMPO.AsString := lCampos.Items[I].GetValue<string>('campo');
        fmtCamposOrigemTIPO.AsString := lCampos.Items[I].GetValue<string>('tipo');
        fmtCamposOrigemTAMANHO.AsString := lCampos.Items[I].GetValue<string>('tamanho');
        fmtCamposOrigemCHAVEPRIMARIA.AsString := lCampos.Items[I].GetValue<string>('chaveprimaria');
        fmtCamposOrigemCHAVEESTRANGEIRA.AsString := lCampos.Items[I].GetValue<string>('chaveestrangeira');
        fmtCamposOrigemCHAVEESTRANGEIRANOMETABELA.AsString := lCampos.Items[I].GetValue<string>('chaveestrangeiranometabela');
        fmtCamposOrigemPERMITENULO.AsString := lCampos.Items[I].GetValue<string>('permitenulo');
        fmtCamposOrigemVALORPADRAO.AsString := lCampos.Items[I].GetValue<string>('valorpadrao');

        if not (ANovo) then
          if FLink.LinkOrigemJaRegistrado(FLink.TabelaOrigem, fmtCamposOrigemCAMPO.AsString) then
            fmtCamposOrigemUSADO.AsInteger := 1;
        fmtCamposOrigem.Post;
      end
      else
      begin
        FLink.MontaWhereSelect;
      end;
    end;
  finally
    lCampos.Free;
  end;

  //Carregar tabela join
  if not (ANovo) then
  begin
    for I := 0 to FLink.GetJoins.Count - 1 do
    begin
      if FileExists(IncludeTrailingPathDelimiter(DirTabelas)+ LerJson(FLink.GetJoins[I].Salvar, 'join')+'.json') then
        UnirTabelaAOrigem(LerJsonFromFile(IncludeTrailingPathDelimiter(DirTabelas)+ LerJson(FLink.GetJoins[I].Salvar, 'join')+'.json'), False);
    end;
  end;

  fmtCamposOrigem.First;
end;

procedure TfmCadastros.CarregarMigracao;
var
  I: integer;
  lArquivoAtual, lJsonAtual: string;
begin
  fmtMigracao.Close;
  fmtMigracao.Open;
  flbListaArquivos.Directory(DirSchemasMigracao);
  flbListaArquivos.Extension('.json');
  flbListaArquivos.Execute;
  for I := 0 to flbListaArquivos.GetFileList.Count -1 do
  begin
    lArquivoAtual := flbListaArquivos.GetFileList[I];
    lJsonAtual := LerJsonFromFile(lArquivoAtual);
    fmtMigracao.Append;
    fmtMigracaoDESCRICAO.AsString := LerJson(LerJsonFromJson(lJsonAtual, 'bancoorigem'), 'nome') +' --> '+LerJson(LerJsonFromJson(lJsonAtual, 'bancodestino'), 'nome');
    fmtMigracaoDIR_ARQUIVO.AsString := lArquivoAtual;
    fmtMigracao.Post;
  end;
  fmtMigracao.First;
  tsSchemaMigracao.TabVisible := not (fmtMigracao.IsEmpty);
end;

procedure TfmCadastros.CarregarCamposTabelaDestino(ANovo: boolean);
var
  lJsonTabela, lJsonCampos: string;
  lCampos: TJSONArray;
  I: Integer;
begin
  lJsonTabela := LerJsonFromFile(fmtTabelasDestinoARQUIVO.AsString);
  fmtCamposDestino.Close;
  fmtCamposDestino.Open;
  lJsonCampos := LerJsonArray(lJsonTabela, 'campos');
  lCampos := TJSONObject.ParseJSONValue(lJsonCampos) as TJSONArray;
  for I := 0 to lCampos.Count - 1 do
  begin
    if not (lCampos.Items[I].GetValue<string>('campo') = 'DATA_ALTERADO') then
    begin
      fmtCamposDestino.Append;
      fmtCamposDestinoCAMPO.AsString := lCampos.Items[I].GetValue<string>('campo');
      fmtCamposDestinoTIPO.AsString := lCampos.Items[I].GetValue<string>('tipo');
      fmtCamposDestinoTAMANHO.AsString := lCampos.Items[I].GetValue<string>('tamanho');
      fmtCamposDestinoCHAVEPRIMARIA.AsString := lCampos.Items[I].GetValue<string>('chaveprimaria');
      fmtCamposDestinoCHAVEESTRANGEIRA.AsString := lCampos.Items[I].GetValue<string>('chaveestrangeira');
      fmtCamposDestinoCHAVEESTRANGEIRANOMETABELA.AsString := lCampos.Items[I].GetValue<string>('chaveestrangeiranometabela');
      fmtCamposDestinoPERMITENULO.AsString := lCampos.Items[I].GetValue<string>('permitenulo');
      fmtCamposDestinoVALORPADRAO.AsString := lCampos.Items[I].GetValue<string>('valorpadrao');
      if not (ANovo) then
      begin
        if FLink.LinkDestinoJaRegistrado(fmtCamposDestinoCAMPO.AsString) then
        begin
          fmtCamposDestinoUSADO.AsInteger := 1;
          AdicionarLinkCampoLista(FLink.GetCampoOrigemDoDestino(fmtCamposDestinoCAMPO.AsString), fmtCamposDestinoCAMPO.AsString);
        end;
      end;
      fmtCamposDestino.Post;
    end;
  end;
  lCampos.Free;
  fmtCamposDestino.First;
end;

procedure TfmCadastros.CarregarSchemas;
var
  I: integer;
  lArquivoAtual, lJsonAtual: string;
begin
  fmtSchemas.Close;
  fmtSchemas.Open;
  flbListaArquivos.Directory(DirSchemas);
  flbListaArquivos.Extension('.json');
  flbListaArquivos.Execute;
  for I := 0 to flbListaArquivos.GetFileList.Count -1 do
  begin
    lArquivoAtual := flbListaArquivos.GetFileList[I];
    lJsonAtual := LerJsonFromFile(lArquivoAtual);
    fmtSchemas.Append;
    fmtSchemasDESCRICAO.AsString := LerJson(LerJsonFromJson(lJsonAtual, 'bancoorigem'), 'nome') +' --> '+LerJson(LerJsonFromJson(lJsonAtual, 'bancodestino'), 'nome');
    fmtSchemasDIR_ARQUIVO.AsString := lArquivoAtual;
    fmtSchemas.Post;
  end;
  fmtSchemas.First;
  tsSchemaSincronia.TabVisible := not (fmtSchemas.IsEmpty);
end;

procedure TfmCadastros.CarregarTabelas;
var
  lConexao: TJSONObject;
  lTabelas: TJSONArray;
  lConexaoStr, lJsonTabelas, lSistema: string;
  ldmConexao: TdmConexao;
  I: Integer;
  lTabelasCarregadas: TStringList;
  procedure CarregaTabelasSalvas(ASistema: string);
  var
    lArquivoAtual: string;
    O: Integer;
  begin
    flbListaArquivos.Directory(DirTabelas);
    flbListaArquivos.Extension('.json');
    flbListaArquivos.Execute;
    for O := 0 to flbListaArquivos.GetFileList.Count -1 do
    begin
      lArquivoAtual := LerJsonFromFile(flbListaArquivos.GetFileList[O]);
      if LerJson(lArquivoAtual, 'sistema') = ASistema then
        lTabelasCarregadas.Add(LerJson(lArquivoAtual, 'tabela'));
    end;
  end;
  function VerificaTabelaSalva(ATabela: string): integer;
  var
     U: Integer;
  begin
    Result := 0;
    for U := 0 to lTabelasCarregadas.Count - 1 do
    begin
      if ATabela = lTabelasCarregadas[U] then
      begin
        Result := 1;
        AdicionarTabelaLista(ATabela);
        break;
      end;
    end;
  end;
begin
  fmtTabelas.Close;
  fmtTabelas.Open;
  lConexao := TJSONObject.Create
                .AddPair('nome', fmtBancosDeDadosNOME.AsString)
                .AddPair('servidor', fmtBancosDeDadosSERVIDOR.AsString)
                .AddPair('porta', fmtBancosDeDadosPORTA.AsString)
                .AddPair('caminho', fmtBancosDeDadosCAMINHO.AsString)
                .AddPair('usuario', fmtBancosDeDadosUSUARIO.AsString)
                .AddPair('senha', fmtBancosDeDadosSENHA.AsString)
                .AddPair('tipo', fmtBancosDeDadosTIPO.AsString)
                .AddPair('sistema', fmtBancosDeDadosSISTEMA.AsString);
  lConexaoStr := lConexao.ToJSON;
  lConexao.Free;
  lbListaTabelasSelecionadas.Clear;
  lSistema := fmtBancosDeDadosSISTEMA.AsString;
  ldmConexao := TdmConexao.Create(nil);
  lTabelasCarregadas := TStringList.Create;
  try
    ldmConexao.Conectar(lConexaoStr);
    if ldmConexao.Conectado then
      lJsonTabelas := ldmConexao.Select(0);
    if IsJSONValid(lJsonTabelas) then
    begin
      CarregaTabelasSalvas(lSistema);
      lTabelas := TJSONObject.ParseJSONValue(lJsonTabelas) as TJSONArray;
      for I := 0 to lTabelas.Count - 1 do
      begin
        fmtTabelas.Append;
        fmtTabelasNOME.AsString := lTabelas.Items[I].Value;
        fmtTabelasSISTEMA.AsString := lSistema;
        fmtTabelasSELECIONADO.AsInteger := VerificaTabelaSalva(lTabelas.Items[I].Value); //Marcar o que ja existe
        fmtTabelas.Post;
      end;
      lTabelas.Free;
    end;
  finally
    ldmConexao.Free;
    lTabelasCarregadas.Free;
  end;
  fmtTabelas.First;
end;

procedure TfmCadastros.CarregarTabelasOrigem(ASistema: string);
var
  lArquivoAtual: string;
  I, O: Integer;
begin
  fmtTabelasOrigem.Close;
  fmtTabelasOrigem.Open;
  flbListaArquivos.Directory(DirTabelas);
  flbListaArquivos.Extension('.json');
  flbListaArquivos.Execute;
  for I := 0 to flbListaArquivos.GetFileList.Count -1 do
  begin
    lArquivoAtual := LerJsonFromFile(flbListaArquivos.GetFileList[I]);
    if LerJson(lArquivoAtual, 'sistema') = ASistema then
    begin
      fmtTabelasOrigem.Append;
      fmtTabelasOrigemDESCRICAO.AsString := LerJson(lArquivoAtual, 'tabela');
      fmtTabelasOrigemARQUIVO.AsString := flbListaArquivos.GetFileList[I];
      //Verificar se ja existe link
      if Assigned(FSchema) then
      begin
        if FSchema.LinksCount > 0 then
        begin
          for O := 0 to FSchema.LinksCount - 1 do
          begin
            if LerJson(lArquivoAtual, 'tabela') = FSchema.GetLink(O).TabelaOrigem then
            begin
              fmtTabelasOrigemORDEM.AsInteger := O + 1;
              AdicionarTabelasLinkadas(FSchema.GetLink(O).TabelaOrigem, FSchema.GetLink(O).TabelaDestino);
            end;
          end;
        end;
      end;
      fmtTabelasOrigem.Post;
    end;
  end;
  fmtTabelasOrigem.First;
end;

procedure TfmCadastros.CarregaTabelasDependentes;
var
  lConexao: TJSONObject;
  lDependencias: TJSONArray;
  lConexaoStr, lJsonDependencias: string;
  ldmConexao: TdmConexao;
  I: Integer;
begin
  fmtTabelasDependentes.Close;
  fmtTabelasDependentes.Open;
  lConexao := TJSONObject.Create
                .AddPair('nome', fmtBancosDeDadosNOME.AsString)
                .AddPair('servidor', fmtBancosDeDadosSERVIDOR.AsString)
                .AddPair('porta', fmtBancosDeDadosPORTA.AsString)
                .AddPair('caminho', fmtBancosDeDadosCAMINHO.AsString)
                .AddPair('usuario', fmtBancosDeDadosUSUARIO.AsString)
                .AddPair('senha', fmtBancosDeDadosSENHA.AsString)
                .AddPair('tipo', fmtBancosDeDadosTIPO.AsString)
                .AddPair('sistema', fmtBancosDeDadosSISTEMA.AsString);
  lConexaoStr := lConexao.ToJSON;
  lConexao.Free;
  ldmConexao := TdmConexao.Create(nil);
  try
    ldmConexao.Conectar(lConexaoStr);
    if ldmConexao.Conectado then
      lJsonDependencias := ldmConexao.Select(2);
    if IsJSONValid(lJsonDependencias) then
    begin
      lDependencias := TJSONObject.ParseJSONValue(lJsonDependencias) as TJSONArray;
      for I := 0 to lDependencias.Count - 1 do
      begin
        fmtTabelasDependentes.Append;
        fmtTabelasDependentesTABELA_MASTER.AsString := lDependencias.Items[I].GetValue('TABELA', '');
        fmtTabelasDependentesTABELA_DEPENDENTE.AsString := lDependencias.Items[I].GetValue('TABELA_ESTRANGEIRA', '');
        fmtTabelasDependentes.Post;
      end;
      lDependencias.Free;
    end;
  finally
    ldmConexao.Free;
  end;
  fmtTabelasDependentes.First;
end;

function TfmCadastros.CheckTabelasDependentes: boolean;
var
  lListaTabelas, lTabela: string;
begin
  Result := True;
  lTabela := fmtTabelasNOME.AsString;
  fmtTabelasDependentes.Filter := 'TABELA_MASTER = '+QuotedStr(lTabela);
  fmtTabelasDependentes.Filtered := True;
  if not (fmtTabelasDependentes.IsEmpty) then
  begin
    fmtTabelasDependentes.First;
    while not (fmtTabelasDependentes.Eof) do
    begin
      if fmtTabelas.Locate('NOME', fmtTabelasDependentesTABELA_DEPENDENTE.AsString, [loCaseInsensitive]) then
        if fmtTabelasSELECIONADO.AsInteger = 0 then
        begin
          if ShowQuestion('A tabela '+lTabela+' possui chaves estrangeiras com a tabela: "'+fmtTabelasNOME.AsString+'"'+sLineBreak+'Deseja adicionar?') then
          begin
            AdicionarTabelaLista(fmtTabelasNOME.AsString);
            fmtTabelas.Edit;
            fmtTabelasSELECIONADO.AsInteger := 1;
            fmtTabelas.Post;
          end;
        end;
      fmtTabelasDependentes.Next;
    end;
  end;
end;

procedure TfmCadastros.CarregarTabelasDestino(ASistema: string);
var
  lArquivoAtual: string;
  I, O: Integer;
begin
  fmtTabelasDestino.Close;
  fmtTabelasDestino.Open;
  flbListaArquivos.Directory(DirTabelas);
  flbListaArquivos.Extension('.json');
  flbListaArquivos.Execute;
  for I := 0 to flbListaArquivos.GetFileList.Count -1 do
  begin
    lArquivoAtual := LerJsonFromFile(flbListaArquivos.GetFileList[I]);
    if LerJson(lArquivoAtual, 'sistema') = ASistema then
    begin
      fmtTabelasDestino.Append;
      fmtTabelasDestinoDESCRICAO.AsString := LerJson(lArquivoAtual, 'tabela');
      fmtTabelasDestinoARQUIVO.AsString := flbListaArquivos.GetFileList[I];
      //Verificar se ja existe link
      if Assigned(FSchema) then
      begin
        if FSchema.LinksCount > 0 then
        begin
          for O := 0 to FSchema.LinksCount - 1 do
          begin
            if LerJson(lArquivoAtual, 'tabela') = FSchema.GetLink(O).TabelaDestino then
              fmtTabelasDestinoORDEM.AsInteger := O + 1;
          end;
        end;
      end;
      fmtTabelasDestino.Post;
    end;
  end;
  fmtTabelasDestino.First;
end;

procedure TfmCadastros.chkSemCampoOrigemClick(Sender: TObject);
begin
  DesabilitarDataSetCamposOrigem(not chkSemCampoOrigem.Checked);
end;

procedure TfmCadastros.DesabilitarDataSetCamposOrigem(AEnabled: boolean);
begin
  if AEnabled then
  begin
    txTipoOrigem.DataSource := dsCamposOrigem;
    txTabelaEstrangeiraOrigem.DataSource := dsCamposOrigem;
    txCampoOrigem.DataSource := dsCamposOrigem;
    txTamanhoOrigem.DataSource := dsCamposOrigem;
    txChavePrimariaOrigem.DataSource := dsCamposOrigem;
    txChaveEstrangeiraOrigem.DataSource := dsCamposOrigem;
    txPermiteNuloOrigem.DataSource := dsCamposOrigem;
    txValorPadraoOrigem.DataSource := dsCamposOrigem;
  end
  else
  begin
    txTipoOrigem.DataSource := nil;
    txTabelaEstrangeiraOrigem.DataSource := nil;
    txCampoOrigem.DataSource := nil;
    txTamanhoOrigem.DataSource := nil;
    txChavePrimariaOrigem.DataSource := nil;
    txChaveEstrangeiraOrigem.DataSource := nil;
    txPermiteNuloOrigem.DataSource := nil;
    txValorPadraoOrigem.DataSource := nil;
  end;
end;

procedure TfmCadastros.dsBancosDeDadosDataChange(Sender: TObject;
  Field: TField);
begin
  if fmtBancosDeDadosSISTEMA.AsString = MV then
    btnZerarDatas.DropDownMenu := popZerarTabelas;
  if fmtBancosDeDadosSISTEMA.AsString = PDV then
    btnZerarDatas.DropDownMenu := popZerarTabelasPDV;
end;

procedure TfmCadastros.dsBancosDeDadosStateChange(Sender: TObject);
begin
  btnSalvarDB.Enabled := dsBancosDeDados.State in [dsInsert, dsEdit];
  btnCancelaDB.Enabled := dsBancosDeDados.State in [dsInsert, dsEdit];
  btnNovoDB.Enabled := dsBancosDeDados.State = dsBrowse;
  btnEditarDB.Enabled := (dsBancosDeDados.State = dsBrowse) and (not dsBancosDeDados.DataSet.IsEmpty);
  btnDeletarDB.Enabled := (dsBancosDeDados.State = dsBrowse) and (not dsBancosDeDados.DataSet.IsEmpty);
  btnTabelasDB.Enabled := (dsBancosDeDados.State = dsBrowse) and (not dsBancosDeDados.DataSet.IsEmpty);
  btnProcurarBanco.Enabled := dsBancosDeDados.State in [dsInsert, dsEdit];
  pnlEdicaoBancos.Visible := dsBancosDeDados.State in [dsInsert, dsEdit];
end;

procedure TfmCadastros.dsSchemasStateChange(Sender: TObject);
begin
  pnlEditsSchemas.Visible := TDataSource(Sender).State in [dsInsert, dsEdit];
  btnDeletaSchema.Enabled := (TDataSource(Sender).State = dsBrowse) and (not TDataSource(Sender).DataSet.IsEmpty);
  btnAlterarSchema.Enabled := (TDataSource(Sender).State = dsBrowse) and (not TDataSource(Sender).DataSet.IsEmpty);
  btnNovoSchema.Enabled := TDataSource(Sender).State = dsBrowse;
  grListaSchemas.Enabled := TDataSource(Sender).State = dsBrowse;
  grListaMigracao.Enabled := TDataSource(Sender).State = dsBrowse;
end;

procedure TfmCadastros.fmtCamposDestinoTAMANHOGetText(Sender: TField;
  var Text: string; DisplayText: Boolean);
begin
  if not (fmtCamposDestino.IsEmpty) then
    Text := IfThen(Sender.AsInteger = 0, 'Indefinido', Sender.AsString);
end;

procedure TfmCadastros.fmtCamposDestinoTIPOGetText(Sender: TField;
  var Text: string; DisplayText: Boolean);
begin
  if not (fmtCamposOrigem.IsEmpty) then
    case Sender.AsInteger of
      0: Text := 'Texto';
      1: Text := 'Inteiro';
      2: Text := 'Real';
      3: Text := 'Data';
      4: Text := 'Data/Hora';
      5: Text := 'Texto grande';
    end;
end;

procedure TfmCadastros.fmtCamposOrigemTAMANHOGetText(Sender: TField;
  var Text: string; DisplayText: Boolean);
begin
  if not (fmtCamposOrigem.IsEmpty) then
    Text := IfThen(Sender.AsInteger = 0, 'Indefinido', Sender.AsString);
end;

procedure TfmCadastros.fmtCamposOrigemTIPOGetText(Sender: TField;
  var Text: string; DisplayText: Boolean);
begin
  if not (fmtCamposOrigem.IsEmpty) then
    case Sender.AsInteger of
      0: Text := 'Texto';
      1: Text := 'Inteiro';
      2: Text := 'Real';
      3: Text := 'Data';
      4: Text := 'Data/Hora';
      5: Text := 'Texto grande';
    end;
end;

procedure TfmCadastros.fmtMigracaoAfterEdit(DataSet: TDataSet);
begin
  if Assigned(FSchema) then
  begin
    FreeAndNil(FSchema);
  end;
  FSchema := TPluginSchemas.Create;
  FSchema.LoadFromFile(fmtMigracaoDIR_ARQUIVO.AsString);
end;

procedure TfmCadastros.fmtSchemasAfterCancel(DataSet: TDataSet);
begin
  if Assigned(FSchema) then
  begin
    FreeAndNil(FSchema);
  end;
end;

procedure TfmCadastros.fmtSchemasAfterClose(DataSet: TDataSet);
begin
  if Assigned(FSchema) then
  begin
    FreeAndNil(FSchema);
  end;
end;

procedure TfmCadastros.fmtSchemasAfterEdit(DataSet: TDataSet);
begin
  if Assigned(FSchema) then
  begin
    FreeAndNil(FSchema);
  end;
  FSchema := TPluginSchemas.Create;
  FSchema.LoadFromFile(fmtSchemasDIR_ARQUIVO.AsString);
end;

procedure TfmCadastros.fmtSchemasAfterInsert(DataSet: TDataSet);
begin
  if Assigned(FSchema) then
  begin
    FreeAndNil(FSchema);
  end;
  FSchema := TPluginSchemas.Create;
end;

procedure TfmCadastros.fmtSchemasAfterPost(DataSet: TDataSet);
begin
  if Assigned(FSchema) then
  begin
    FreeAndNil(FSchema);
  end;
end;

procedure TfmCadastros.fmtTabelasOrigemSELGetText(Sender: TField;
  var Text: string; DisplayText: Boolean);
begin
  Text := '';
end;

procedure TfmCadastros.FormCreate(Sender: TObject);
begin
  pcPrincipal.ActivePage := tsBoasVindas;
  pcSchemas.ActivePage := tsSchemaSincronia;
  grTabelasOrigem.OnDrawColumnCell := HandleDrawColumnCell;
  grTabelasDestino.OnDrawColumnCell := HandleDrawColumnCell;
  grTabelasDestino.OnCellClick := HandleCellClickDestino;
  grTabelasOrigem.OnCellClick := HandleCellClickOrigem;
  grCamposOrigem.OnDrawColumnCell := HandleDrawColumnCellCampos;
  grCamposDestino.OnDrawColumnCell := HandleDrawColumnCellCampos;
  flbListaArquivos := TFileSearch.Create(DirLocal, '.json');
end;

procedure TfmCadastros.FormDestroy(Sender: TObject);
begin
  flbListaArquivos.Free;
  if Assigned(FSchema) then
  begin
    FreeAndNil(FSchema);
  end;
end;

procedure TfmCadastros.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if pcPrincipal.ActivePage = tsCadLinksCampos then
  begin
    if not (mmExpressaoLivre.Focused) then
    begin
      if Key = VK_SPACE then
        btnCriarLink.Click;

      if key = VK_DOWN then
      begin
        if ssShift in Shift then
          fmtCamposOrigem.Next;
        if ssCtrl in Shift then
          fmtCamposDestino.Next;
        if (Shift = [ssShift]) or (Shift = [ssCtrl]) or (Shift = [ssShift, ssCtrl]) then
          Key := 0;
      end
      else
      if key = VK_UP then
      begin
        if ssShift in Shift then
          fmtCamposOrigem.Prior;
        if ssCtrl in Shift then
          fmtCamposDestino.Prior;
        if (Shift = [ssShift]) or (Shift = [ssCtrl]) or (Shift = [ssShift, ssCtrl]) then
          Key := 0;
      end
      else
      if key = VK_LEFT then
      begin
        grCamposOrigem.SetFocus;
        Key := 0;
      end
      else
      if key = VK_RIGHT then
      begin
        grCamposDestino.SetFocus;
        Key := 0;
      end;
    end;
  end;
end;

procedure TfmCadastros.HandleDrawColumnCellTabelas(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
var
  bgColor, textColor: TColor;
begin
  if not (TDBGrid(Sender).DataSource.Dataset.FieldByName('ORDEM').IsNull) then
  begin
    if gdSelected in State then
    begin
      TDBGrid(Sender).Canvas.Font.Color := clRed;
      TDBGrid(Sender).Canvas.Brush.Color := clMenuHighlight;
    end
    else
    begin
      TColorUtils.GetColorScheme(TDBGrid(Sender).DataSource.Dataset.FieldByName('ORDEM').AsInteger, bgColor, textColor);
      TDBGrid(Sender).Canvas.Font.Color := textColor;
      TDBGrid(Sender).Canvas.Brush.Color:= bgColor;
    end;
    TDBGrid(Sender).DefaultDrawDataCell(Rect, TDBGrid(Sender).columns[DataCol].Field, State);
  end;
end;

procedure TfmCadastros.lbCriarLinksClick(Sender: TObject);
begin
  pcPrincipal.ActivePage := tsCadLinks;
  lbListaLinks.Items.Clear;
  CarregarTabelasOrigem(LerJson(FSchema.BaseOrigem.Salvar, 'sistema'));
  CarregarTabelasDestino(LerJson(FSchema.BaseDestino.Salvar, 'sistema'));
end;

procedure TfmCadastros.lbSelecionarArquivoDestinoClick(Sender: TObject);
begin
  pcPrincipal.ActivePage := tsSelBancosDados;
  CarregaBancosParaSelecao(1);
end;

procedure TfmCadastros.lbSelecionarArquivoOrigemClick(Sender: TObject);
begin
  pcPrincipal.ActivePage := tsSelBancosDados;
  CarregaBancosParaSelecao(0);
end;

procedure TfmCadastros.NumerarOrdemTabelasRelacionadas;
var
  lJsonSchema, lJsonLinks: string;
  lLinks: TJSONArray;
  I: Integer;
begin
  if Assigned(FSchema) then
  begin
    lJsonSchema := FSchema.Salvar;
    lJsonLinks := LerJsonArray(lJsonSchema, 'links');
    lLinks := TJSONObject.ParseJSONValue(lJsonLinks) as TJSONArray;
    for I := 0 to lLinks.Count - 1 do
    begin
      if fmtTabelasOrigem.Locate('DESCRICAO', lLinks.Items[I].GetValue<string>('tabelaorigem'), [loCaseInsensitive]) then
      begin
        fmtTabelasOrigem.Edit;
        fmtTabelasOrigemORDEM.AsInteger := I+1;
        fmtTabelasOrigemSEL.AsInteger := 0;
        fmtTabelasOrigem.Post;
      end;
      if fmtTabelasDestino.Locate('DESCRICAO', lLinks.Items[I].GetValue<string>('tabeladestino'), [loCaseInsensitive]) then
      begin
        fmtTabelasDestino.Edit;
        fmtTabelasDestinoORDEM.AsInteger := I+1;
        fmtTabelasDestinoSEL.AsInteger := 0;
        fmtTabelasDestino.Post;
      end;
    end;
  end;
end;

function TfmCadastros.TextoMemoBancos(var AMemo: TMemo; AJson: string): string;
begin
  AMemo.Lines.Clear;
  if not (AJson.IsEmpty) then
  begin
    AMemo.Lines.Add(Format('Nome: "%s"',[LerJson(AJson, 'nome')]));
    AMemo.Lines.Add(Format('Servidor: %s',[LerJson(AJson, 'servidor')]));
    AMemo.Lines.Add(Format('Porta: %s',[LerJson(AJson, 'porta')]));
    AMemo.Lines.Add(Format('Banco: "%s"',[LerJson(AJson, 'caminho')]));
    AMemo.SelStart := 0;
    if LerJson(AJson, 'tipo') = '0' then
      FNomeOrigem := LerJson(AJson, 'nome')
    else FNomeDestino := LerJson(AJson, 'nome');
    if pcSchemas.ActivePage = tsSchemaSincronia then
    begin
      if fmtSchemas.State in [dsInsert, dsEdit] then
        fmtSchemasDESCRICAO.AsString := FNomeOrigem + ' --> ' + FNomeDestino;
    end
    else
    begin
      if fmtMigracao.State in [dsInsert, dsEdit] then
        fmtMigracaoDESCRICAO.AsString := FNomeOrigem + ' --> ' + FNomeDestino;
    end;
  end else
  begin
    AMemo.Lines.Add('Selecione o arquivo ');
    AMemo.Lines.Add('do banco de Dados   ');
    AMemo.Lines.Add(' |                  ');
    AMemo.Lines.Add('\|/                 ');
    AMemo.Lines.Add(' v                  ');
  end;
end;

function TfmCadastros.TextoMemoTabelas(AJson: string): string;
var
  lTabelas: TJSONArray;
  I: Integer;
  lTexto: string;
begin
  mmTabelasSchema.Lines.Clear;
  if not (AJson.IsEmpty) then
  begin
    lTabelas := TJSONObject.ParseJSONValue(AJson) as TJSONArray;
    try
      for I := 0 to lTabelas.Count - 1 do
      begin
        lTexto := Format('%s --> %s; ', [lTabelas.Items[I].GetValue<string>('tabelaorigem'), lTabelas.Items[I].GetValue<string>('tabeladestino')]);
        mmTabelasSchema.Lines.Add(lTexto);
      end;
    finally
      lTabelas.Free;
    end;
  end else
  begin
    mmTabelasSchema.Lines.Add('Clique para criar os ');
    mmTabelasSchema.Lines.Add('links entre as tabelas');
    mmTabelasSchema.Lines.Add(' |                  ');
    mmTabelasSchema.Lines.Add('\|/                 ');
    mmTabelasSchema.Lines.Add(' v                  ');
  end;
end;

procedure TfmCadastros.UnirTabelaAOrigem(AJson: string; ANovo: boolean);
var
  lJsonTabela, lJsonCampos: string;
  lCampos: TJSONArray;
  I: Integer;
begin
  lJsonCampos := LerJsonArray(AJson, 'campos');
  lCampos := TJSONObject.ParseJSONValue(lJsonCampos) as TJSONArray;
  for I := 0 to lCampos.Count - 1 do
  begin
    if not (lCampos.Items[I].GetValue<string>('campo') = 'DATA_ALTERADO') then
    begin
      fmtCamposOrigem.Append;
      fmtCamposOrigemCAMPO.AsString := Format('%s.%s', [LerJson(AJson, 'tabela'), lCampos.Items[I].GetValue<string>('campo')]);
      fmtCamposOrigemTIPO.AsString := lCampos.Items[I].GetValue<string>('tipo');
      fmtCamposOrigemTAMANHO.AsString := lCampos.Items[I].GetValue<string>('tamanho');
      fmtCamposOrigemCHAVEPRIMARIA.AsString := lCampos.Items[I].GetValue<string>('chaveprimaria');
      fmtCamposOrigemCHAVEESTRANGEIRA.AsString := lCampos.Items[I].GetValue<string>('chaveestrangeira');
      fmtCamposOrigemCHAVEESTRANGEIRANOMETABELA.AsString := lCampos.Items[I].GetValue<string>('chaveestrangeiranometabela');
      fmtCamposOrigemPERMITENULO.AsString := lCampos.Items[I].GetValue<string>('permitenulo');
      fmtCamposOrigemVALORPADRAO.AsString := lCampos.Items[I].GetValue<string>('valorpadrao');

      if not (ANovo) then
        if FLink.LinkOrigemJaRegistrado(LerJson(AJson, 'tabela'), ExtrairCampoJoin(fmtCamposOrigemCAMPO.AsString)) then
          fmtCamposOrigemUSADO.AsInteger := 1;

      fmtCamposOrigem.Post;
    end;
  end;
  lCampos.Free;
  fmtCamposOrigem.First;
end;

procedure TfmCadastros.VENDEDORES1Click(Sender: TObject);
var
  lConexao: TJSONObject;
  ldmCon: TdmConexao;
begin
  lConexao := TJSONObject.Create
                .AddPair('nome', edNome.Text)
                .AddPair('servidor', edServidor.Text)
                .AddPair('porta', edPorta.Text)
                .AddPair('caminho',edCaminho.Text)
                .AddPair('usuario', edUsuario.Text)
                .AddPair('senha', edSenha.Text)
                .AddPair('tipo', cbTipoDB.ItemIndex.ToString)
                .AddPair('sistema', fmtBancosDeDadosSISTEMA.AsString);
  ldmCon := TdmConexao.Create(nil);
  try
    ldmCon.Conectar(lConexao.ToJSON);
    if ldmCon.Conectado then
      ldmCon.Execute('update SINCRONIZACAO_PLUGIN set '+TMenuItem(Sender).Hint+' = dateadd(year, -10, current_timestamp)', ldmCon.Conexao);
  finally
    lConexao.Free;
    ldmCon.Free;
  end;
end;

function TfmCadastros.VerificarCamposDestinosObrigatoriosNaoSelecionados: boolean;
begin
  try
    fmtCamposDestino.DisableControls;
    fmtCamposDestino.Filter := '(PERMITENULO = ''N'') and (USADO = 0) and (VALORPADRAO = '''')';
    fmtCamposDestino.Filtered := True;
    Result := fmtCamposDestino.IsEmpty;
  finally
    fmtCamposDestino.Filtered := False;
    fmtCamposDestino.EnableControls;
  end;
end;

procedure TfmCadastros.HandleDrawColumnCell(Sender: TObject; const Rect: TRect;
  DataCol: Integer; Column: TColumn; State: TGridDrawState);
var
  CheckboxRect: TRect;
  CheckboxState: Word;
  bgColor, textColor: TColor;
begin
  if not (TDBGrid(Sender).DataSource.Dataset.FieldByName('ORDEM').IsNull) then
  begin
    TColorUtils.GetColorScheme(TDBGrid(Sender).DataSource.Dataset.FieldByName('ORDEM').AsInteger, bgColor, textColor);
    TDBGrid(Sender).Canvas.Font.Color := textColor;
    TDBGrid(Sender).Canvas.Brush.Color:= bgColor;
    TDBGrid(Sender).DefaultDrawDataCell(Rect, TDBGrid(Sender).columns[DataCol].Field, State);
  end else
  if Column.FieldName = 'SEL' then
  begin
    TDBGrid(Sender).DefaultDrawColumnCell(Rect, DataCol, Column, State);

    CheckboxRect := Rect;
    InflateRect(CheckboxRect, -2, -2); // Ajustar margens internas

    // Definir o estado do checkbox com base nos dados do conjunto de dados
    if Column.Field.AsInteger = 1 then
      CheckboxState := DFCS_CHECKED
    else
      CheckboxState := DFCS_BUTTONCHECK;

    // Desenhar o checkbox
    DrawFrameControl(TDBGrid(Sender).Canvas.Handle, CheckboxRect, DFC_BUTTON, CheckboxState);
  end;
end;

procedure TfmCadastros.HandleDrawColumnCellCampos(Sender: TObject; const Rect: TRect;
  DataCol: Integer; Column: TColumn; State: TGridDrawState);
begin
  if TDBGrid(Sender).DataSource.Dataset.FieldByName('USADO').AsInteger = 1 then
  begin
    if gdSelected in State then
    begin
      TDBGrid(Sender).Canvas.Font.Color := clHighlight;
      TDBGrid(Sender).Canvas.Brush.Color:= $00FFF0DD;
    end
    else
    begin
      TDBGrid(Sender).Canvas.Font.Color := clHighlightText;
      TDBGrid(Sender).Canvas.Brush.Color:= clHighlight;
    end;
    TDBGrid(Sender).DefaultDrawDataCell(Rect, TDBGrid(Sender).columns[DataCol].Field, State);
  end;
end;

procedure TfmCadastros.Label32Click(Sender: TObject);
begin
  ShowMessage('Ao usar a expressão, o sql do campo será usado o que estiver preenchido no campo de expressão');
end;

procedure TfmCadastros.HandleCellClickOrigem(Column: TColumn);
begin
  if Column.FieldName = 'SEL' then
  begin
    HandleCellClick(fmtTabelasOrigem);
  end;
end;

procedure TfmCadastros.HandleCellClickDestino(Column: TColumn);
begin
  if Column.FieldName = 'SEL' then
  begin
    HandleCellClick(fmtTabelasDestino);
  end;
end;

procedure TfmCadastros.HandleCellClick(var AMemTable: TFDMemTable);
var
  lTabelaAtual: string;
  bkm: TBookmark;
begin
  if not AMemTable.FieldByName('ORDEM').IsNull then
    Exit;
  lTabelaAtual := AMemTable.FieldByName('DESCRICAO').AsString;

  AMemTable.UpdateCursorPos;
  bkm := AMemTable.GetBookmark;
  // Desmarcar todos os registros
  AMemTable.DisableControls;
  try
    AMemTable.First;
    while not AMemTable.Eof do
    begin
      AMemTable.Edit;
      if lTabelaAtual = AMemTable.FieldByName('DESCRICAO').AsString then
        AMemTable.FieldByName('SEL').AsInteger := IfThen(AMemTable.FieldByName('SEL').AsInteger = 0, 1, 0)
      else
        AMemTable.FieldByName('SEL').AsInteger := 0;
      AMemTable.Post;
      AMemTable.Next;
    end;
    if AMemTable.BookmarkValid(bkm) then
    begin
      AMemTable.GotoBookmark(bkm);
    end;
  finally
    AMemTable.EnableControls;
    AMemTable.FreeBookmark(bkm);
  end;
end;

end.
