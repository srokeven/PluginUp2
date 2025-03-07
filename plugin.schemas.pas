unit plugin.schemas;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ComCtrls, Data.DB, cxGraphics, cxLookAndFeels, cxLookAndFeelPainters,
  Vcl.Menus, cxButtons, Vcl.StdCtrls, Vcl.DBCtrls, Vcl.Grids, Vcl.DBGrids, Vcl.ExtCtrls, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, FileSearchUnit, uUtils, System.StrUtils, System.Math, uColorUtils,
  plugin.controller.links, System.JSON, plugin.monta.where, plugin.expressoes, plugin.selecao.tabela.join;

type
  TfmSchemas = class(TForm)
    pcPrincipal: TPageControl;
    tsTabelas: TTabSheet;
    tsCampos: TTabSheet;
    Panel1: TPanel;
    Panel2: TPanel;
    btnCriarLink: TButton;
    pnlTabelaOrigem: TPanel;
    grTabelasOrigem: TDBGrid;
    pnlTabelaDestino: TPanel;
    grTabelasDestino: TDBGrid;
    pnlCamposOrigem: TPanel;
    grCamposOrigem: TDBGrid;
    btnJoinTabela: TButton;
    pnlCriarLink: TPanel;
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
    Label31: TLabel;
    Label32: TLabel;
    chkSemCampoOrigem: TCheckBox;
    mmExpressaoLivre: TMemo;
    btnAdicionarLink: TButton;
    btnGerarExpressao: TButton;
    pnlCamposDestino: TPanel;
    grCamposDestino: TDBGrid;
    pnlListaLinksCriados: TPanel;
    lbListaCamposLink: TListBox;
    Panel3: TPanel;
    btnSalvarCamposLinks: TButton;
    btnAlterarWhere: TButton;
    btnRemoverLinkCampo: TcxButton;
    btnCancelaCamposLink: TcxButton;
    dsTabelasOrigem: TDataSource;
    fmtTabelasOrigem: TFDMemTable;
    fmtTabelasOrigemSEL: TIntegerField;
    fmtTabelasOrigemORDEM: TIntegerField;
    fmtTabelasOrigemDESCRICAO: TStringField;
    fmtTabelasOrigemARQUIVO: TStringField;
    dsTabelasDestino: TDataSource;
    fmtTabelasDestino: TFDMemTable;
    fmtTabelasDestinoSEL: TIntegerField;
    fmtTabelasDestinoORDEM: TIntegerField;
    fmtTabelasDestinoDESCRICAO: TStringField;
    fmtTabelasDestinoARQUIVO: TStringField;
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
    dsCamposOrigem: TDataSource;
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
    dsCamposDestino: TDataSource;
    chkSchemaUpdate: TCheckBox;
    chkExecucaoIndividual: TCheckBox;
    btnLinkAutomatico: TButton;
    chkInsertIncremental: TCheckBox;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure fmtTabelasOrigemSELGetText(Sender: TField; var Text: string; DisplayText: Boolean);
    procedure fmtTabelasDestinoSELGetText(Sender: TField; var Text: string; DisplayText: Boolean);
    procedure btnCriarLinkClick(Sender: TObject);
    procedure btnAdicionarLinkClick(Sender: TObject);
    procedure btnGerarExpressaoClick(Sender: TObject);
    procedure btnCancelaCamposLinkClick(Sender: TObject);
    procedure btnRemoverLinkCampoClick(Sender: TObject);
    procedure btnSalvarCamposLinksClick(Sender: TObject);
    procedure btnJoinTabelaClick(Sender: TObject);
    procedure fmtCamposOrigemTIPOGetText(Sender: TField; var Text: string; DisplayText: Boolean);
    procedure fmtCamposDestinoTIPOGetText(Sender: TField; var Text: string; DisplayText: Boolean);
    procedure btnAlterarWhereClick(Sender: TObject);
    procedure btnLinkAutomaticoClick(Sender: TObject);
  private
    flbListaArquivos: TFileSearch;
    FLink: TPluginLink;
    FSistemaOrigem: string;

    procedure HandleDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure HandleCellClickOrigem(Column: TColumn);
    procedure HandleCellClickDestino(Column: TColumn);
    procedure HandleCellClick(var AMemTable: TFDMemTable);
    procedure HandleDrawColumnCellCampos(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);

    procedure AdicionarLinkCampoLista(ACampoOrigem, ACampoDestino: string);

    procedure CarregarTabelas(ASistemaOrigem: string);
    procedure CarregarTabelasOrigem(ASistema: string);
    procedure CarregarTabelasMasterVendas;
    procedure CarregarCamposTabelaOrigem(AArquivo: string; ANovo: boolean);
    procedure CarregarCamposTabelaDestino(AArquivo: string; ANovo: boolean);
    procedure CarregarSchemaLinks(AArquivo: string);
    function VerificarCamposDestinosObrigatoriosNaoSelecionados: boolean;
    procedure UnirTabelaAOrigem(AJson: string; ANovo: boolean);
  public
    class procedure Novo(ASistemaOrigem: string);
    class procedure Alterar(ASistemaOrigem, AArquivo: string);
  end;


implementation

{$R *.dfm}

{ TfmSchemas }

procedure TfmSchemas.AdicionarLinkCampoLista(ACampoOrigem, ACampoDestino: string);
begin
  lbListaCamposLink.Items.Add(ACampoOrigem+' --> '+ACampoDestino);
end;

procedure TfmSchemas.btnCancelaCamposLinkClick(Sender: TObject);
begin
  ModalResult := mrCancel;
end;

procedure TfmSchemas.btnCriarLinkClick(Sender: TObject);
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

  FLink := TPluginLink.Novo;
  FLink.TabelaOrigem := fmtTabelasOrigemDESCRICAO.AsString;
  FLink.TabelaDestino := fmtTabelasDestinoDESCRICAO.AsString;
  CarregarCamposTabelaOrigem(fmtTabelasOrigemARQUIVO.AsString, True);
  CarregarCamposTabelaDestino(fmtTabelasDestinoARQUIVO.AsString, True);
  pcPrincipal.ActivePage := tsCampos;
end;

procedure TfmSchemas.btnGerarExpressaoClick(Sender: TObject);
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

procedure TfmSchemas.btnJoinTabelaClick(Sender: TObject);
begin
  if (not (fmtCamposOrigemCHAVEESTRANGEIRA.AsString = 'S')) and (not (fmtCamposOrigemCHAVEPRIMARIA.AsString = 'S')) then
    if not ShowQuestion('O campo "'+fmtCamposOrigemCAMPO.AsString+'" não é uma chave Primaria/Estrangeira. Deseja criar união de tabelas mesmo assim?') then
      Exit;
  fmSelecionarTabelaJoin := TfmSelecionarTabelaJoin.Create(Self);
  try
    fmSelecionarTabelaJoin.SetDadosAtual(FSistemaOrigem, fmtCamposOrigemCAMPO.AsString, FLink.TabelaOrigem);
    if fmSelecionarTabelaJoin.ShowModal = mrOk then
    begin
      UnirTabelaAOrigem(LerJsonFromFile(fmSelecionarTabelaJoin.fmtTabelasOrigemARQUIVO.AsString), True);
      FLink.AddTabelaJoin(fmSelecionarTabelaJoin.fmtTabelasOrigemDESCRICAO.AsString, fmSelecionarTabelaJoin.GetTipoJoin, fmSelecionarTabelaJoin.mmCondicao.Lines.Text);
    end;
  finally
    fmSelecionarTabelaJoin.Free;
  end;
end;

procedure TfmSchemas.btnLinkAutomaticoClick(Sender: TObject);
begin
  if ShowQuestion('Deseja criar link automatico para os campos iguais?') then
  begin
    if lbListaCamposLink.Count > 0 then
      raise Exception.Create('Limpe os campos anteriores antes de continuar');
    fmtCamposOrigem.First;
    while not (fmtCamposOrigem.Eof) do
    begin
      if fmtCamposDestino.Locate('CAMPO', fmtCamposOrigemCAMPO.AsString, [loCaseInsensitive]) then
        btnAdicionarLinkClick(btnAdicionarLink);
      fmtCamposOrigem.Next;
    end;
  end;
end;

procedure TfmSchemas.btnRemoverLinkCampoClick(Sender: TObject);
var
  lCampoOrigem, lCampoDestino, lTabelaOrigem: string;
begin
  if lbListaCamposLink.ItemIndex < 0 then
  begin
    raise Exception.Create('Nenhum item selecionado');
  end;
  lTabelaOrigem := FLink.TabelaOrigem;
  lCampoOrigem := ExtrairTextoAPartirDePosicao(lbListaCamposLink.Items[lbListaCamposLink.ItemIndex], ' --> ', EXTRAIR_PRE_TRECHO);
  if lCampoOrigem = '.' then
    lCampoOrigem := EmptyStr;
  if lCampoOrigem.IsEmpty then
    lTabelaOrigem := EmptyStr;
  lCampoDestino := ExtrairTextoAPartirDePosicao(lbListaCamposLink.Items[lbListaCamposLink.ItemIndex], ' --> ', EXTRAIR_POS_TRECHO);
  if FLink.RemoverLinkFields(
       lTabelaOrigem,
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

function TfmSchemas.VerificarCamposDestinosObrigatoriosNaoSelecionados: boolean;
begin
  try
    fmtCamposDestino.DisableControls;
    fmtCamposDestino.Filter := '(PERMITENULO = ''N'') and (USADO = 0) and (VALORPADRAO = '''')';
    fmtCamposDestino.Filtered := True;
    Result := fmtCamposDestino.IsEmpty;
    if not (Result) then
      if ShowQuestion('Existem campos obrigatorios na tabela de destino que não foram informados. Deseja continuar mesmo assim?') then
        Result := True;
  finally
    fmtCamposDestino.Filtered := False;
    fmtCamposDestino.EnableControls;
  end;
end;

procedure TfmSchemas.btnSalvarCamposLinksClick(Sender: TObject);
begin
  if VerificarCamposDestinosObrigatoriosNaoSelecionados then
  begin
    if chkSchemaUpdate.Checked then
      FLink.SetSchemaUpdate
    else
      FLink.SetSchemaInsert;
    if chkExecucaoIndividual.Checked then
      FLink.SetExecucaoIndividual
    else
      FLink.SetExecucaoEmGrupo;
    if chkInsertIncremental.Checked then
      FLink.SetExecucaoIncremental
    else
      FLink.SetExecucaoPadrao;

    if FLink.SalvarArquivo(DirSchemasMigracao, IfThen(FLink.NomeArquivo.IsEmpty, FSistemaOrigem+'_'+FLink.TabelaDestino, FLink.NomeArquivo)) then
      ModalResult := mrOk;
  end;
end;

procedure TfmSchemas.btnAdicionarLinkClick(Sender: TObject);
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

procedure TfmSchemas.btnAlterarWhereClick(Sender: TObject);
begin
  fmMontaWhere := TfmMontaWhere.Create(Self);
  try
    fmMontaWhere.mmWhereAdicional.Lines.Text := FLink.WhereAdicional;
    fmMontaWhere.mmWherePadrao.Lines.Text := FLink.WhereSelect;
    if fmMontaWhere.ShowModal = mrOk then
    begin
      FLink.WhereAdicional := fmMontaWhere.mmWhereAdicional.Lines.Text;
      FLink.WhereSelect := fmMontaWhere.mmWherePadrao.Lines.Text;
    end;
  finally
    fmMontaWhere.Free;
  end;
end;

procedure TfmSchemas.CarregarCamposTabelaDestino(AArquivo: string; ANovo: boolean);
var
  lJsonTabela, lJsonCampos: string;
  lCampos: TJSONArray;
  I: Integer;
begin
  lJsonTabela := LerJsonFromFile(AArquivo);
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

procedure TfmSchemas.CarregarCamposTabelaOrigem(AArquivo: string; ANovo: boolean);
var
  lJsonTabela, lJsonCampos: string;
  lCampos: TJSONArray;
  I: Integer;
begin
  fmtCamposOrigem.Close;
  fmtCamposOrigem.Open;
  lJsonTabela := LerJsonFromFile(AArquivo);
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
        if FLink.WhereSelect.IsEmpty then
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

procedure TfmSchemas.UnirTabelaAOrigem(AJson: string; ANovo: boolean);
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

procedure TfmSchemas.CarregarSchemaLinks(AArquivo: string);
begin
  lbListaCamposLink.Items.Clear;
  FLink := TPluginLink.Novo(LerJsonFromFile(AArquivo));
  FLink.NomeArquivo := ExtractName(AArquivo);
  CarregarCamposTabelaOrigem(IncludeTrailingPathDelimiter(DirSchemasMigracaoTabelasOrigem(FSistemaOrigem))+FLink.TabelaOrigem+'.json', False);
  CarregarCamposTabelaDestino(IncludeTrailingPathDelimiter(DirSchemasMigracaoTabelasOrigem(MV))+FLink.TabelaDestino+'.json', False);
  chkSchemaUpdate.Checked := not (FLink.SchemaInsert);
  chkExecucaoIndividual.Checked := not (FLink.SchemaExecucaoGrupo);
  chkInsertIncremental.Checked := FLink.SchemaExecucaoIncremental;
  pcPrincipal.ActivePage := tsCampos;
end;

procedure TfmSchemas.CarregarTabelas(ASistemaOrigem: string);
begin
  pcPrincipal.ActivePage := tsTabelas;
end;

procedure TfmSchemas.CarregarTabelasMasterVendas;
var
  lArquivoAtual: string;
  I: Integer;
begin
  fmtTabelasDestino.Close;
  fmtTabelasDestino.Open;
  flbListaArquivos.Directory(DirSchemasMigracaoTabelasOrigem('mv'));
  flbListaArquivos.Extension('.json');
  flbListaArquivos.Execute;
  for I := 0 to flbListaArquivos.GetFileList.Count -1 do
  begin
    lArquivoAtual := LerJsonFromFile(flbListaArquivos.GetFileList[I]);
    fmtTabelasDestino.Append;
    fmtTabelasDestinoDESCRICAO.AsString := LerJson(lArquivoAtual, 'tabela');
    fmtTabelasDestinoARQUIVO.AsString := flbListaArquivos.GetFileList[I];
    fmtTabelasDestinoORDEM.Clear;
    fmtTabelasDestino.Post;
  end;
  fmtTabelasDestino.First;
end;

procedure TfmSchemas.CarregarTabelasOrigem(ASistema: string);
var
  lArquivoAtual: string;
  I: Integer;
begin
  FSistemaOrigem := ASistema;
  fmtTabelasOrigem.Close;
  fmtTabelasOrigem.Open;
  flbListaArquivos.Directory(DirSchemasMigracaoTabelasOrigem(ASistema));
  flbListaArquivos.Extension('.json');
  flbListaArquivos.Execute;
  for I := 0 to flbListaArquivos.GetFileList.Count -1 do
  begin
    lArquivoAtual := LerJsonFromFile(flbListaArquivos.GetFileList[I]);
    fmtTabelasOrigem.Append;
    fmtTabelasOrigemDESCRICAO.AsString := LerJson(lArquivoAtual, 'tabela');
    fmtTabelasOrigemARQUIVO.AsString := flbListaArquivos.GetFileList[I];
    fmtTabelasOrigemORDEM.Clear;
    fmtTabelasOrigem.Post;
  end;
  fmtTabelasOrigem.First;
end;

procedure TfmSchemas.fmtCamposDestinoTIPOGetText(Sender: TField; var Text: string; DisplayText: Boolean);
begin
  if not (fmtCamposDestino.IsEmpty) then
    case Sender.AsInteger of
      0: Text := 'Texto';
      1: Text := 'Inteiro';
      2: Text := 'Real';
      3: Text := 'Data';
      4: Text := 'Data/Hora';
      5: Text := 'Texto grande';
    end;
end;

procedure TfmSchemas.fmtCamposOrigemTIPOGetText(Sender: TField; var Text: string; DisplayText: Boolean);
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

procedure TfmSchemas.fmtTabelasDestinoSELGetText(Sender: TField; var Text: string; DisplayText: Boolean);
begin
  Text := '';
end;

procedure TfmSchemas.fmtTabelasOrigemSELGetText(Sender: TField; var Text: string; DisplayText: Boolean);
begin
  Text := '';
end;

procedure TfmSchemas.FormCreate(Sender: TObject);
begin
  flbListaArquivos := TFileSearch.Create(DirSchemasMigracao, '');
  grTabelasOrigem.OnDrawColumnCell := HandleDrawColumnCell;
  grTabelasOrigem.OnCellClick := HandleCellClickOrigem;
  grTabelasDestino.OnDrawColumnCell := HandleDrawColumnCell;
  grTabelasDestino.OnCellClick := HandleCellClickDestino;
  grCamposOrigem.OnDrawColumnCell := HandleDrawColumnCellCampos;
  grCamposDestino.OnDrawColumnCell := HandleDrawColumnCellCampos;
end;

procedure TfmSchemas.FormDestroy(Sender: TObject);
begin
  flbListaArquivos.Free;
end;

procedure TfmSchemas.HandleCellClick(var AMemTable: TFDMemTable);
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

procedure TfmSchemas.HandleCellClickDestino(Column: TColumn);
begin
  if Column.FieldName = 'SEL' then
  begin
    HandleCellClick(fmtTabelasDestino);
  end;
end;

procedure TfmSchemas.HandleCellClickOrigem(Column: TColumn);
begin
  if Column.FieldName = 'SEL' then
  begin
    HandleCellClick(fmtTabelasOrigem);
  end;
end;

procedure TfmSchemas.HandleDrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn;
  State: TGridDrawState);
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

procedure TfmSchemas.HandleDrawColumnCellCampos(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn;
  State: TGridDrawState);
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

class procedure TfmSchemas.Novo(ASistemaOrigem: string);
var
  fmSchemas: TfmSchemas;
begin
  Application.CreateForm(TfmSchemas, fmSchemas);
  try
    fmSchemas.CarregarTabelas(ASistemaOrigem);
    fmSchemas.CarregarTabelasOrigem(ASistemaOrigem);
    fmSchemas.CarregarTabelasMasterVendas;
    fmSchemas.ShowModal;
  finally
    FreeAndNil(fmSchemas);
  end;
end;

class procedure TfmSchemas.Alterar(ASistemaOrigem, AArquivo: string);
var
  fmSchemas: TfmSchemas;
begin
  Application.CreateForm(TfmSchemas, fmSchemas);
  try
    fmSchemas.CarregarTabelas(ASistemaOrigem);
    fmSchemas.CarregarTabelasOrigem(ASistemaOrigem);
    fmSchemas.CarregarTabelasMasterVendas;
    fmSchemas.CarregarSchemaLinks(AArquivo);
    fmSchemas.ShowModal;
  finally
    FreeAndNil(fmSchemas);
  end;
end;

end.
