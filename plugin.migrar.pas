unit plugin.migrar;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms,
  Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, Data.DB, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Comp.DataSet, FireDAC.Comp.Client,
  Vcl.Grids, Vcl.DBGrids, Vcl.ComCtrls, FileSearchUnit, uUtils, System.StrUtils, plugin.schemas, cxGraphics,
  cxLookAndFeels, cxLookAndFeelPainters, Vcl.Menus, cxButtons, System.JSON, plugin.controller.links,
  plugin.datamodule, System.IOUtils;

type
  TfmMigrarBancoDados = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    GroupBox1: TGroupBox;
    btnTestarBancoDados: TButton;
    Label7: TLabel;
    Label6: TLabel;
    Label5: TLabel;
    Label4: TLabel;
    Label3: TLabel;
    GroupBox2: TGroupBox;
    Label2: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    btnTestarConexaoDadosDestino: TButton;
    edServidorOrigem: TEdit;
    edPortaOrigem: TEdit;
    edCaminhoOrigem: TEdit;
    edUsuarioOrigem: TEdit;
    edSenhaOrigem: TEdit;
    edServidorDestino: TEdit;
    edPortaDestino: TEdit;
    edCaminhoDestino: TEdit;
    edUsuarioDestino: TEdit;
    edSenhaDestino: TEdit;
    pcPrincipal: TPageControl;
    tsBancos: TTabSheet;
    tsLista: TTabSheet;
    btnProximoBancos: TButton;
    tsProcesso: TTabSheet;
    Panel3: TPanel;
    Panel4: TPanel;
    btnVoltarProcesso: TButton;
    btnIniciarProcesso: TButton;
    mmLogProcesso: TMemo;
    Label12: TLabel;
    Panel5: TPanel;
    Panel6: TPanel;
    btnProximaLista: TButton;
    btnVoltarLista: TButton;
    grBancoDados: TDBGrid;
    dsSchemas: TDataSource;
    fmtSchemas: TFDMemTable;
    fmtSchemasDESCRICAO: TStringField;
    fmtSchemasDIR_ARQUIVO: TStringField;
    Label1: TLabel;
    cbSistema: TComboBox;
    Label13: TLabel;
    lbSistemaDestino: TLabel;
    fmtSchemasSEL: TIntegerField;
    Shape1: TShape;
    btnIncluirSchema: TButton;
    btnAlterarSchema: TButton;
    btnExcluirSchema: TButton;
    fmtSchemasORDEM: TIntegerField;
    Panel7: TPanel;
    btnMoveUp: TcxButton;
    btnMoveDown: TcxButton;
    tsPreferencias: TTabSheet;
    Panel8: TPanel;
    btnVoltarPreferencias: TButton;
    btnProximoPreferencias: TButton;
    chkContinuarSequencia: TCheckBox;
    Memo1: TMemo;
    Shape2: TShape;
    btnPrepararBancoOrigem: TButton;
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btnProximaListaClick(Sender: TObject);
    procedure btnProximoBancosClick(Sender: TObject);
    procedure grBancoDadosDrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn;
      State: TGridDrawState);
    procedure grBancoDadosCellClick(Column: TColumn);
    procedure btnIncluirSchemaClick(Sender: TObject);
    procedure btnVoltarListaClick(Sender: TObject);
    procedure btnAlterarSchemaClick(Sender: TObject);
    procedure btnMoveUpClick(Sender: TObject);
    procedure btnMoveDownClick(Sender: TObject);
    procedure btnExcluirSchemaClick(Sender: TObject);
    procedure btnVoltarPreferenciasClick(Sender: TObject);
    procedure btnProximoPreferenciasClick(Sender: TObject);
    procedure btnVoltarProcessoClick(Sender: TObject);
    procedure btnIniciarProcessoClick(Sender: TObject);
    procedure btnTestarBancoDadosClick(Sender: TObject);
    procedure btnTestarConexaoDadosDestinoClick(Sender: TObject);
    procedure btnPrepararBancoOrigemClick(Sender: TObject);
    procedure grBancoDadosTitleClick(Column: TColumn);
  private
    flbListaArquivos: TFileSearch;
    function ConexaoOrigemToJson: string;
    function ConexaoDestinoToJson: string;
    procedure CarregarSchemas;
    procedure SalvarConfiguracoesOrdem;
    procedure MoveRecord(FromIndex, ToIndex: Integer);
    procedure Log(ATexto: string);
  public
    { Public declarations }
  end;

var
  fmMigrarBancoDados: TfmMigrarBancoDados;

implementation

{$R *.dfm}

const
  ORIGEM_MASTERVENDAS = 0;
  ORIGEM_UP2PDV = 1;

procedure TfmMigrarBancoDados.FormCreate(Sender: TObject);
begin
  flbListaArquivos := TFileSearch.Create(DirSchemasMigracao, '.json');
  edServidorOrigem.Text := LerIni('ORIGEM_MIGRACAO', 'SERVIDOR', '', IncludeTrailingPathDelimiter(ExtractFilePath(ParamStr(0)))+'configuracao.ini');
  edPortaOrigem.Text := LerIni('ORIGEM_MIGRACAO', 'PORTA', '', IncludeTrailingPathDelimiter(ExtractFilePath(ParamStr(0)))+'configuracao.ini');
  edCaminhoOrigem.Text := LerIni('ORIGEM_MIGRACAO', 'CAMINHO', '', IncludeTrailingPathDelimiter(ExtractFilePath(ParamStr(0)))+'configuracao.ini');
  edUsuarioOrigem.Text := LerIni('ORIGEM_MIGRACAO', 'USUARIO', '', IncludeTrailingPathDelimiter(ExtractFilePath(ParamStr(0)))+'configuracao.ini');
  edSenhaOrigem.Text := LerIni('ORIGEM_MIGRACAO', 'SENHA', '', IncludeTrailingPathDelimiter(ExtractFilePath(ParamStr(0)))+'configuracao.ini');
  edServidorDestino.Text := LerIni('DESTINO_MIGRACAO', 'SERVIDOR', '', IncludeTrailingPathDelimiter(ExtractFilePath(ParamStr(0)))+'configuracao.ini');
  edPortaDestino.Text := LerIni('DESTINO_MIGRACAO', 'PORTA', '', IncludeTrailingPathDelimiter(ExtractFilePath(ParamStr(0)))+'configuracao.ini');
  edCaminhoDestino.Text := LerIni('DESTINO_MIGRACAO', 'CAMINHO', '', IncludeTrailingPathDelimiter(ExtractFilePath(ParamStr(0)))+'configuracao.ini');
  edUsuarioDestino.Text := LerIni('DESTINO_MIGRACAO', 'USUARIO', '', IncludeTrailingPathDelimiter(ExtractFilePath(ParamStr(0)))+'configuracao.ini');
  edSenhaDestino.Text := LerIni('DESTINO_MIGRACAO', 'SENHA', '', IncludeTrailingPathDelimiter(ExtractFilePath(ParamStr(0)))+'configuracao.ini');
end;

procedure TfmMigrarBancoDados.FormDestroy(Sender: TObject);
begin
  flbListaArquivos.Free;
end;

procedure TfmMigrarBancoDados.FormShow(Sender: TObject);
begin
  pcPrincipal.ActivePage := tsBancos;
end;

procedure TfmMigrarBancoDados.grBancoDadosCellClick(Column: TColumn);
var
  ColumnChecked: integer;
begin
  if AnsiUpperCase(Column.FieldName) = 'SEL' then
  begin
    if grBancoDados.DataSource.DataSet.FieldByName('SEL').AsInteger = 1 then
      ColumnChecked := 0
    else
      ColumnChecked := 1;

    if not (grBancoDados.DataSource.DataSet.IsEmpty) then
    begin
      grBancoDados.DataSource.DataSet.Edit;
      grBancoDados.DataSource.DataSet.FieldByName('SEL').AsInteger := ColumnChecked;
      grBancoDados.DataSource.DataSet.Post;
    end;
  end;
end;

procedure TfmMigrarBancoDados.grBancoDadosDrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer;
  Column: TColumn; State: TGridDrawState);
var
  nMarcar : Word;
  oRtangulo : TRect;
begin
  if gdSelected in State then
  begin
    grBancoDados.Canvas.Font.Color := clWhite; //Fundo
    grBancoDados.Canvas.Brush.Color := clMenuHighlight; //Fonte
  end
  else
  begin
    if odd(grBancoDados.DataSource.DataSet.RecNo) then
    begin
      grBancoDados.Canvas.Font.Color := clBlack;
      grBancoDados.Canvas.Brush.Color:= clBtnFace; //$00FFECC4;
    end
    else
    begin
      grBancoDados.Canvas.Font.Color := clBlack;
      grBancoDados.Canvas.Brush.Color:= clWhite;//$00FFFEF4;
    end;
  end;
  grBancoDados.DefaultDrawDataCell(Rect, grBancoDados.columns[DataCol].Field, State);
  if AnsiUpperCase(Column.FieldName)= 'SEL' then
  begin
    grBancoDados.Canvas.FillRect(Rect);
    if Column.Field.AsInteger = 1 then
      nMarcar := DFCS_CHECKED
    else nMarcar := DFCS_BUTTONCHECK;
    oRtangulo:= Rect;
    InflateRect(oRtangulo,-2,-2);
    DrawFrameControl(grBancoDados.Canvas.Handle, oRtangulo, DFC_BUTTON, nMarcar);
  end;
end;

procedure TfmMigrarBancoDados.grBancoDadosTitleClick(Column: TColumn);
var
  I, SelectAll: integer;
  columTitle: string;
begin
  if Column.FieldName = 'SEL' then
  begin
    try
      grBancoDados.DataSource.DataSet.DisableControls;
      grBancoDados.DataSource.DataSet.First;
      while not (grBancoDados.DataSource.DataSet.Eof) do
      begin
        grBancoDados.DataSource.DataSet.Edit;
        grBancoDados.DataSource.DataSet.FieldByName('SEL').AsInteger := 1;
        grBancoDados.DataSource.DataSet.Post;
        grBancoDados.DataSource.DataSet.Next;
      end;
    finally;
      grBancoDados.DataSource.DataSet.EnableControls;
    end;
  end;
end;

procedure TfmMigrarBancoDados.Log(ATexto: string);
begin
  mmLogProcesso.Lines.Add(FormatDateTime('[dd/mm/yy hh:nn:ss:zzz]', now)+' --> '+ATexto);
end;

procedure TfmMigrarBancoDados.MoveRecord(FromIndex, ToIndex: Integer);
var
  ATabelaInicial, AProximaTabela: string;
begin
  fmtSchemas.IndexFieldNames := '';
  fmtSchemas.DisableControls;
  try
    fmtSchemas.First;
    while not (fmtSchemas.eof) do
    begin
      if fmtSchemasORDEM.AsInteger = FromIndex then
        ATabelaInicial := fmtSchemasDESCRICAO.AsString;
      if fmtSchemasORDEM.AsInteger = ToIndex then
        AProximaTabela := fmtSchemasDESCRICAO.AsString;
      fmtSchemas.Next;
    end;
    fmtSchemas.First;
    while not (fmtSchemas.eof) do
    begin
      if ATabelaInicial = fmtSchemasDESCRICAO.AsString then
      begin
        fmtSchemas.Edit;
        fmtSchemasORDEM.AsInteger := ToIndex;
        fmtSchemas.Post;
      end;
      if AProximaTabela = fmtSchemasDESCRICAO.AsString then
      begin
        fmtSchemas.Edit;
        fmtSchemasORDEM.AsInteger := FromIndex;
        fmtSchemas.Post;
      end;
      fmtSchemas.Next;
    end;
    fmtSchemas.IndexFieldNames := 'ORDEM';
    fmtSchemas.Refresh;
    fmtSchemas.First;
    while not (fmtSchemas.eof) do
    begin
      if ATabelaInicial = fmtSchemasDESCRICAO.AsString then
        Break;
      fmtSchemas.Next;
    end;
  finally
    fmtSchemas.EnableControls;
  end;
end;

procedure TfmMigrarBancoDados.SalvarConfiguracoesOrdem;
var
  lJsonOrdem: TJSONArray;
begin
  lJsonOrdem := TJSONArray.Create;
  if not (fmtSchemas.IsEmpty) then
  begin
    fmtSchemas.First;
    while not (fmtSchemas.eof) do
    begin
      lJsonOrdem.Add(TJSONObject.Create.AddPair('tabela', ExtractFileName(fmtSchemasDIR_ARQUIVO.AsString)).AddPair('ordem', TJSONNumber.Create(fmtSchemasORDEM.AsInteger)));
      fmtSchemas.Next;
    end;
  end;
  GravarArrayJsonToFile(lJsonOrdem.ToJson, IncludeTrailingPathDelimiter(DirSchemasMigracaoTabelasConfiguracao)+'ordem.json');
  lJsonOrdem.Free;
end;

procedure TfmMigrarBancoDados.btnProximoBancosClick(Sender: TObject);
begin
  GravarIni('ORIGEM_MIGRACAO', 'SERVIDOR', edServidorOrigem.Text, IncludeTrailingPathDelimiter(ExtractFilePath(ParamStr(0)))+'configuracao.ini');
  GravarIni('ORIGEM_MIGRACAO', 'PORTA', edPortaOrigem.Text, IncludeTrailingPathDelimiter(ExtractFilePath(ParamStr(0)))+'configuracao.ini');
  GravarIni('ORIGEM_MIGRACAO', 'CAMINHO', edCaminhoOrigem.Text, IncludeTrailingPathDelimiter(ExtractFilePath(ParamStr(0)))+'configuracao.ini');
  GravarIni('ORIGEM_MIGRACAO', 'USUARIO', edUsuarioOrigem.Text, IncludeTrailingPathDelimiter(ExtractFilePath(ParamStr(0)))+'configuracao.ini');
  GravarIni('ORIGEM_MIGRACAO', 'SENHA', edSenhaOrigem.Text, IncludeTrailingPathDelimiter(ExtractFilePath(ParamStr(0)))+'configuracao.ini');
  GravarIni('DESTINO_MIGRACAO', 'SERVIDOR', edServidorDestino.Text, IncludeTrailingPathDelimiter(ExtractFilePath(ParamStr(0)))+'configuracao.ini');
  GravarIni('DESTINO_MIGRACAO', 'PORTA', edPortaDestino.Text, IncludeTrailingPathDelimiter(ExtractFilePath(ParamStr(0)))+'configuracao.ini');
  GravarIni('DESTINO_MIGRACAO', 'CAMINHO', edCaminhoDestino.Text, IncludeTrailingPathDelimiter(ExtractFilePath(ParamStr(0)))+'configuracao.ini');
  GravarIni('DESTINO_MIGRACAO', 'USUARIO', edUsuarioDestino.Text, IncludeTrailingPathDelimiter(ExtractFilePath(ParamStr(0)))+'configuracao.ini');
  GravarIni('DESTINO_MIGRACAO', 'SENHA', edSenhaDestino.Text, IncludeTrailingPathDelimiter(ExtractFilePath(ParamStr(0)))+'configuracao.ini');

  btnPrepararBancoOrigem.Enabled := cbSistema.ItemIndex = 1;
  pcPrincipal.ActivePage := tsLista;
  CarregarSchemas;
end;

procedure TfmMigrarBancoDados.btnProximoPreferenciasClick(Sender: TObject);
begin
  pcPrincipal.ActivePage := tsProcesso;
end;

procedure TfmMigrarBancoDados.btnTestarBancoDadosClick(Sender: TObject);
var
  lConexaoOrigem: TdmConexao;
begin
  lConexaoOrigem := TdmConexao.Create(nil);
  try
    lConexaoOrigem.ConectarOrigem(ConexaoOrigemToJson);
    if lConexaoOrigem.OrigemConectado then
      ShowMessage('Conectado')
    else
      ShowWarning('Não foi possivel conectar. Verifique o log');
  finally
    lConexaoOrigem.Free;
  end;
end;

procedure TfmMigrarBancoDados.btnTestarConexaoDadosDestinoClick(Sender: TObject);
var
  lConexaoDestino: TdmConexao;
begin
  lConexaoDestino := TdmConexao.Create(nil);
  try
    lConexaoDestino.ConectarDestino(ConexaoDestinoToJson);
    if lConexaoDestino.DestinoConectado then
      ShowMessage('Conectado')
    else
      ShowWarning('Não foi possivel conectar. Verifique o log');
  finally
    lConexaoDestino.Free;
  end;
end;

procedure TfmMigrarBancoDados.btnVoltarListaClick(Sender: TObject);
begin
  pcPrincipal.ActivePage := tsBancos;
end;

procedure TfmMigrarBancoDados.btnVoltarPreferenciasClick(Sender: TObject);
begin
  pcPrincipal.ActivePage := tsLista;
end;

procedure TfmMigrarBancoDados.btnVoltarProcessoClick(Sender: TObject);
begin
  pcPrincipal.ActivePage := tsPreferencias;
end;

procedure TfmMigrarBancoDados.btnAlterarSchemaClick(Sender: TObject);
begin
  TfmSchemas.Alterar(IfThen(cbSistema.ItemIndex = ORIGEM_MASTERVENDAS, MV, PDV), fmtSchemasDIR_ARQUIVO.AsString);
  CarregarSchemas;
end;

procedure TfmMigrarBancoDados.btnExcluirSchemaClick(Sender: TObject);
begin
  if ShowQuestion('Deseja excluir o(s) registro(s) de schema selecionado(s)?') then
  begin
    fmtSchemas.First;
    while not (fmtSchemas.eof) do
    begin
      if fmtSchemasSEL.AsInteger = 1 then
        DeleteFile(fmtSchemasDIR_ARQUIVO.AsString);
      fmtSchemas.Next;
    end;
    CarregarSchemas;
  end;
end;

procedure TfmMigrarBancoDados.btnIncluirSchemaClick(Sender: TObject);
begin
  TfmSchemas.Novo(IfThen(cbSistema.ItemIndex = ORIGEM_MASTERVENDAS, MV, PDV));
  CarregarSchemas;
end;

procedure TfmMigrarBancoDados.btnIniciarProcessoClick(Sender: TObject);
var
  FLink: TPluginLink;
  lConexaoOrigem, lConexaoDestino: TdmConexao;
  lCaminhoArquivo: string;
begin
  if ShowQuestion('Deseja iniciar o processo de migração?') then
  begin
    mmLogProcesso.Lines.Add(' ');
    mmLogProcesso.Lines.Add('##############################################################');
    Log('Processo iniciado');
    fmtSchemas.First;
    while not (fmtSchemas.eof) do
    begin
      if fmtSchemasSEL.AsInteger = 1 then
      begin
        Log('Carregando arquivo: '+fmtSchemasDESCRICAO.AsString);
        FLink := TPluginLink.Novo(LerJsonFromFile(fmtSchemasDIR_ARQUIVO.AsString));
        Log('Consultando dados de: '+fmtSchemasDESCRICAO.AsString);
        lConexaoOrigem := TdmConexao.Create(nil);
        try
          lConexaoOrigem.ConectarOrigem(ConexaoOrigemToJson);
          if lConexaoOrigem.OrigemConectado then
          begin
            if lConexaoOrigem.ConsultarESalvar(FLink.GetSelectAll,
                                               FLink.TabelaOrigem,
                                               cbSistema.Text,
                                               FLink.TabelaDestino,
                                               lbSistemaDestino.Caption,
                                               lCaminhoArquivo) then
            begin
              Log('Registros consultados: '+lConexaoOrigem.QuantidadeUltimaConsulta.ToString);
            end
            else
              Log('Nenhum registro retornado na consulta'+' <-- AVISO');
          end;
        finally
          lConexaoOrigem.Free;
        end;
        Log('Inserindo dados de: '+fmtSchemasDESCRICAO.AsString);
        lConexaoDestino := TdmConexao.Create(nil);
        try
          lConexaoDestino.ConectarDestino(ConexaoDestinoToJson);
          if lConexaoDestino.DestinoConectado then
          begin
            if lConexaoDestino.ExecutarDestino(IfThen(FLink.SchemaInsert, FLink.GetInsertAll(chkContinuarSequencia.Checked), FLink.GetUpdate),
                                               FLink.Salvar,
                                               FLink.TabelaOrigem,
                                               cbSistema.Text,
                                               FLink.TabelaDestino,
                                               lbSistemaDestino.Caption) then
            begin
              if FileExists(lCaminhoArquivo) then
                TFile.Move(lCaminhoArquivo, IncludeTrailingPathDelimiter(DirConsultasHistorico)+ExtractFileName(lCaminhoArquivo)+'_'+FormatDateTime('ddmmyyhhnnss',Now))
              else
                Log('Nenhum registro para migrar'+' <-- AVISO');
            end
            else
              Log('Não foi possivel inserir os dados no destino'+' <-- ATENÇÃO');
          end;
        finally
          lConexaoDestino.Free;
        end;
        Log('Concluido: '+fmtSchemasDESCRICAO.AsString);
      end;
      fmtSchemas.Next;
    end;
    //Dados da empresa
    //Movimentação de estoque
    Log('Fim do processo');
  end;
end;

procedure TfmMigrarBancoDados.btnMoveDownClick(Sender: TObject);
begin
  if fmtSchemas.RecNo < fmtSchemas.RecordCount then
    MoveRecord(fmtSchemasORDEM.AsInteger, fmtSchemasORDEM.AsInteger + 1);
end;

procedure TfmMigrarBancoDados.btnMoveUpClick(Sender: TObject);
begin
  if fmtSchemas.RecNo > 1 then
    MoveRecord(fmtSchemasORDEM.AsInteger, fmtSchemasORDEM.AsInteger - 1);
end;

procedure TfmMigrarBancoDados.btnPrepararBancoOrigemClick(Sender: TObject);
var
  lConexaoOrigem: TdmConexao;
begin
  if ShowQuestion('Deseja criar os campos necessários para migração do Up2PDV?') then
  begin
    lConexaoOrigem := TdmConexao.Create(nil);
    try
      lConexaoOrigem.ConectarOrigem(ConexaoOrigemToJson);
      if lConexaoOrigem.OrigemConectado then
      begin
        mmLogProcesso.Lines.Add(' ');
        mmLogProcesso.Lines.Add('##############################################################');
        Log('Iniciando processo de atualização de tabelas');
        Log('Criando campos');
        lConexaoOrigem.Execute('ALTER TABLE TB_NFE ADD ID INTEGER;', lConexaoOrigem.ConexaoOrigem);
        lConexaoOrigem.Execute('ALTER TABLE TB_NFE_ITEM ADD TB_NFE_ID INTEGER;', lConexaoOrigem.ConexaoOrigem);
        lConexaoOrigem.Execute('ALTER TABLE TB_NFE_PAGAMENTO ADD TB_NFE_ID INTEGER;', lConexaoOrigem.ConexaoOrigem);
        Log('Criando indices');
        lConexaoOrigem.Execute('CREATE INDEX TB_NFE_IDX2 ON TB_NFE (SERIE,NUMERO);', lConexaoOrigem.ConexaoOrigem);
        lConexaoOrigem.Execute('CREATE INDEX TB_NFE_IDX3 ON TB_NFE (ID);', lConexaoOrigem.ConexaoOrigem);
        lConexaoOrigem.Execute('CREATE INDEX TB_NFE_ITEM_IDX1 ON TB_NFE_ITEM (TB_NFE_ID);', lConexaoOrigem.ConexaoOrigem);
        Log('Ajustando dados: Cupons');
        //Criando campo de ID nos cupons
        lConexaoOrigem.Execute(
          'execute block '+
          'as '+
          'declare variable SERIE integer; '+
          'declare variable NUMERO integer; '+
          'declare variable SEQUENCIA integer; '+
          'begin '+
            'SEQUENCIA = 0; '+
            'for select SERIE, '+
                       'NUMERO '+
                'from TB_NFE '+
                'order by SERIE, NUMERO '+
                'into :SERIE, :NUMERO '+
            'do '+
            'begin '+
              'SEQUENCIA = SEQUENCIA + 1; '+
              'update TB_NFE '+
              'set ID = :SEQUENCIA '+
              'where SERIE = :SERIE and '+
                    'NUMERO = :NUMERO; '+
            'end '+
          'end ', lConexaoOrigem.ConexaoOrigem);

        //Populando campo de ID nos produtos
        lConexaoOrigem.Execute(
          'merge into TB_NFE_ITEM NP '+
          'using (select ID, '+
                        'SERIE, '+
                        'NUMERO '+
                 'from TB_NFE) N '+
          'on NP.SERIE = N.SERIE and '+
             'NP.NUMERO = N.NUMERO '+
          'when matched then '+
              'update set NP.TB_NFE_ID = N.ID ', lConexaoOrigem.ConexaoOrigem);

        //Populando campo de ID nos pagamentos
        lConexaoOrigem.Execute(
          'merge into TB_NFE_PAGAMENTO NP '+
          'using (select ID, '+
                        'SERIE, '+
                        'NUMERO '+
                 'from TB_NFE) N '+
          'on NP.SERIE = N.SERIE and '+
             'NP.NUMERO = N.NUMERO '+
          'when matched then '+
              'update set NP.TB_NFE_ID = N.ID ', lConexaoOrigem.ConexaoOrigem);
        Log('Concluido ajustes');
      end;
    finally
      lConexaoOrigem.Free;
    end;
  end;
end;

procedure TfmMigrarBancoDados.btnProximaListaClick(Sender: TObject);
begin
  if fmtSchemas.IsEmpty then
  begin
    ShowWarning('Nenhum regitro de schema');
    Exit;
  end;
  SalvarConfiguracoesOrdem;
  pcPrincipal.ActivePage := tsPreferencias;
end;

procedure TfmMigrarBancoDados.CarregarSchemas;
var
  I, lOrdem, lOrdemAuxiliar: integer;
  lArquivoAtual, lJsonAtual, lArquivoOrdem, lJsonOrdemString: string;
  lJsonOrdem: TJSONArray;
  O: Integer;
begin
  lArquivoOrdem := IncludeTrailingPathDelimiter(DirSchemasMigracaoTabelasConfiguracao)+'ordem.json';
  if FileExists(lArquivoOrdem) then
  begin
    lJsonOrdemString := LerArrayJsonFromFile(lArquivoOrdem);
    lJsonOrdem := TJSONObject.ParseJSONValue(lJsonOrdemString) as TJSONArray;
  end
  else
    lJsonOrdem := TJSONArray.Create;
  lOrdem := 0;
  fmtSchemas.Close;
  fmtSchemas.Open;
  flbListaArquivos.Directory(DirSchemasMigracao);
  flbListaArquivos.Extension('.json');
  flbListaArquivos.Execute;
  for I := 0 to flbListaArquivos.GetFileList.Count -1 do
  begin
    lArquivoAtual := flbListaArquivos.GetFileList[I];
    lOrdemAuxiliar := 0;
    for O := 0 to lJsonOrdem.Count - 1 do
    begin
      if lJsonOrdem.Items[O].GetValue<string>('tabela', '') = ExtractFileName(lArquivoAtual) then
      begin
        if lJsonOrdem.Items[O].GetValue<integer>('ordem', 0) = 0 then
          Inc(lOrdemAuxiliar)
        else
          lOrdemAuxiliar := lJsonOrdem.Items[O].GetValue<integer>('ordem', 0);
      end;
    end;
    if (lOrdemAuxiliar = 0) or (lOrdem = lOrdemAuxiliar) then
      Inc(lOrdem)
    else
      lOrdem := lOrdemAuxiliar;
    if cbSistema.ItemIndex = ORIGEM_MASTERVENDAS then
    begin
      if not (ContainsText(lArquivoAtual, 'MV_')) then
        Continue;
      lJsonAtual := LerJsonFromFile(lArquivoAtual);
      fmtSchemas.Append;
      fmtSchemasDESCRICAO.AsString := ExtrairTextoAPartirDePosicao(ExtrairTextoAPartirDePosicao(ExtractFileName(flbListaArquivos.GetFileList[I]), '_', EXTRAIR_POS_TRECHO), '.', EXTRAIR_PRE_TRECHO);
      fmtSchemasDIR_ARQUIVO.AsString := lArquivoAtual;
      fmtSchemasORDEM.AsInteger := lOrdem;
      fmtSchemas.Post;
    end
    else if cbSistema.ItemIndex = ORIGEM_UP2PDV then
    begin
      if not (ContainsText(lArquivoAtual, 'PDV_')) then
        Continue;
      lJsonAtual := LerJsonFromFile(lArquivoAtual);
      fmtSchemas.Append;
      fmtSchemasDESCRICAO.AsString := ExtrairTextoAPartirDePosicao(ExtrairTextoAPartirDePosicao(ExtractFileName(flbListaArquivos.GetFileList[I]), '_', EXTRAIR_POS_TRECHO), '.', EXTRAIR_PRE_TRECHO);
      fmtSchemasDIR_ARQUIVO.AsString := lArquivoAtual;
      fmtSchemasORDEM.AsInteger := lOrdem;
      fmtSchemas.Post;
    end;
  end;
  fmtSchemas.First;
  lJsonOrdem.Free;
end;

function TfmMigrarBancoDados.ConexaoDestinoToJson: string;
var
  lJson: TJSONObject;
begin
  lJson := TJSONObject.Create
    .AddPair('servidor', edServidorDestino.Text)
    .AddPair('porta', edPortaDestino.Text)
    .AddPair('caminho', edCaminhoDestino.Text)
    .AddPair('usuario', edUsuarioDestino.Text)
    .AddPair('senha', edSenhaDestino.Text);
  Result := lJson.ToJson;
  lJson.Free;
end;

function TfmMigrarBancoDados.ConexaoOrigemToJson: string;
var
  lJson: TJSONObject;
begin
  lJson := TJSONObject.Create
    .AddPair('servidor', edServidorOrigem.Text)
    .AddPair('porta', edPortaOrigem.Text)
    .AddPair('caminho', edCaminhoOrigem.Text)
    .AddPair('usuario', edUsuarioOrigem.Text)
    .AddPair('senha', edSenhaOrigem.Text);
  Result := lJson.ToJson;
  lJson.Free;
end;

end.
