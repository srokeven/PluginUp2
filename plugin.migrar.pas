unit plugin.migrar;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms,
  Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, Data.DB, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Comp.DataSet, FireDAC.Comp.Client,
  Vcl.Grids, Vcl.DBGrids, Vcl.ComCtrls, FileSearchUnit, uUtils, System.StrUtils, plugin.schemas, cxGraphics,
  cxLookAndFeels, cxLookAndFeelPainters, Vcl.Menus, cxButtons, System.JSON, plugin.controller.links,
  plugin.datamodule, System.IOUtils, Vcl.Themes, Vcl.Buttons, ACBrValidador;

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
    Shape2: TShape;
    btnPrepararBancoOrigem: TButton;
    btnPrepararBancoDestino: TButton;
    tsSQLs: TTabSheet;
    mmSQLSequencia: TMemo;
    cbTema: TComboBox;
    lbProcessamento: TLabel;
    SpeedButton1: TSpeedButton;
    fodArquivo: TFileOpenDialog;
    SpeedButton2: TSpeedButton;
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
    procedure btnProximoPreferenciasClick(Sender: TObject);
    procedure btnIniciarProcessoClick(Sender: TObject);
    procedure btnTestarBancoDadosClick(Sender: TObject);
    procedure btnTestarConexaoDadosDestinoClick(Sender: TObject);
    procedure btnPrepararBancoOrigemClick(Sender: TObject);
    procedure grBancoDadosTitleClick(Column: TColumn);
    procedure btnPrepararBancoDestinoClick(Sender: TObject);
    procedure cbTemaSelect(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure SpeedButton2Click(Sender: TObject);
    procedure btnVoltarProcessoClick(Sender: TObject);
  private
    flbListaArquivos: TFileSearch;
    procedure VerificarOrigem;
    procedure ExecutarSQLDestino(ASQL: string);
    function ConexaoOrigemToJson: string;
    function ConexaoDestinoToJson: string;
    procedure CarregarSchemas;
    procedure SalvarConfiguracoesOrdem;
    procedure MoveRecord(FromIndex, ToIndex: Integer);
    procedure Log(ATexto: string; AAlteraUltimaLinha: boolean = false);
    function TextProgressBar(APosicao, AMax: integer): string;
    procedure PreencherDadosEmpresa;
    procedure RecalcularSequenciaTabelas;
    procedure CriarMovimentacao;
    function MovimentaEstoqueCFe: boolean;
    function MovimentaEstoqueNFCe: boolean;
    function MovimentaEstoqueNFe: boolean;
    function MovimentaEstoqueEntrada: boolean;
    function DesfazMovimentaEstoqueCFe: boolean;
    function DesfazMovimentaEstoqueEntrada: boolean;
    function DesfazMovimentaEstoqueNFCe: boolean;
    function DesfazMovimentaEstoqueNFe: boolean;
    procedure InconsistenciaEstoque;
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
  MOV_SAIDA_STR = '0';
  MOV_ENTRADA_STR = '1';
  TP_MOVIMENTO_ESTOQUE_CFE = 1;
  TP_MOVIMENTO_ESTOQUE_CFE_CANCELAMENTO = 10;
  TP_MOVIMENTO_ESTOQUE_NFCE = 2;
  TP_MOVIMENTO_ESTOQUE_NFCE_CANCELAMENTO = 20;
  TP_MOVIMENTO_ESTOQUE_NFE_SAIDA = 3;
  TP_MOVIMENTO_ESTOQUE_NFE_SAIDA_CANCELAMENTO = 30;
  TP_MOVIMENTO_ESTOQUE_NFE_ENTRADA = 4;
  TP_MOVIMENTO_ESTOQUE_NFE_ENTRADA_CANCELAMENTO = 40;
  TP_MOVIMENTO_ESTOQUE_ENTRADA = 5;
  TP_MOVIMENTO_ESTOQUE_ENTRADA_CANCELAMENTO = 50;
  TP_MOVIMENTO_ESTOQUE_AJUSTE = 6;
  TP_MOVIMENTO_ESTOQUE_AJUSTE_CANCELAMENTO = 60;

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

procedure TfmMigrarBancoDados.InconsistenciaEstoque;
var
  lConexaoDestino: TdmConexao;
  lProdutosInconsistentes: string;
  lJson: TJSONArray;
  I: Integer;
begin
  lConexaoDestino := TdmConexao.Create(nil);
  try
    lConexaoDestino.ConectarDestino(ConexaoDestinoToJson);
    if (lConexaoDestino.DestinoConectado) then
    begin
      Log('Verificando inconsistencia de estoque');
      Log('Consultando');
      lProdutosInconsistentes :=
        lConexaoDestino.Select('select * '+
                               'from (select PRO.ID, '+
                                            'PRO.DESCRICAO, '+
                                            'E.QUANTIDADE_FISCO_INICIAL, '+
                                            'E.QUANTIDADE_FISCO, '+
                                            '(select coalesce(sum(MF.QUANTIDADE), 0) '+
                                            'from MOVIMENTO_FISCAL MF '+
                                             'where MF.PRODUTO_ID = PRO.ID and '+
                                                   'MF.MOVIMENTO_FINAL = 1 and '+
                                                   'MF.ENTRADA_SAIDA_ESTOQUE = 0) TOTAL_SAIDAS, '+
                                            '(select coalesce(sum(MF.QUANTIDADE), 0) '+
                                             'from MOVIMENTO_FISCAL MF '+
                                             'where MF.PRODUTO_ID = PRO.ID and '+
                                                   'MF.MOVIMENTO_FINAL = 1 and '+
                                                   'MF.ENTRADA_SAIDA_ESTOQUE = 1) TOTAL_ENTRADAS '+
                                     'from PRODUTOS PRO '+
                                     'join ESTOQUE E on E.PRODUTO_ID = PRO.ID) '+
                               'where QUANTIDADE_FISCO_INICIAL + TOTAL_ENTRADAS - TOTAL_SAIDAS <> QUANTIDADE_FISCO', lConexaoDestino.ConexaoDestino);
      lJson := TJSONValue.ParseJSONValue(lProdutosInconsistentes) as TJSONArray;
      for I := 0 to lJson.Count - 1 do
      begin
        Log(TextProgressBar(I + 1, lJson.Count), True);
        if lJson.Items[I].GetValue<double>('QUANTIDADE_FISCO_INICIAL', 0) +
           lJson.Items[I].GetValue<double>('TOTAL_ENTRADAS', 0) -
           lJson.Items[I].GetValue<double>('TOTAL_SAIDAS', 0) > lJson.Items[I].GetValue<double>('QUANTIDADE_FISCO', 0) then //Saida
          lConexaoDestino.Execute('insert into MOVIMENTO_FISCAL (PRODUTO_ID, '+
                                                                'QUANTIDADE, '+
                                                                'QUANTIDADE_ANTERIOR, '+
                                                                'DATAMOVIMENTO, '+
                                                                'DATACADASTRO, '+
                                                                'HISTORICO, ' +
                                                                'MOVIMENTO_FINAL, '+
                                                                'MOVIMENTO_ID, '+
                                                                'ENTRADA_SAIDA_ESTOQUE, '+
                                                                'TIPO_MOVIMENTO_FIXO_ID) ' +
                                  'values ('+lJson.Items[I].GetValue<string>('ID', '')+', '+
                                          FloatToSQLFloat((lJson.Items[I].GetValue<double>('QUANTIDADE_FISCO_INICIAL', 0) + lJson.Items[I].GetValue<double>('TOTAL_ENTRADAS', 0) - lJson.Items[I].GetValue<double>('TOTAL_SAIDAS', 0)) - lJson.Items[I].GetValue<double>('QUANTIDADE_FISCO', 0))+', '+
                                          FloatToSQLFloat(lJson.Items[I].GetValue<double>('QUANTIDADE_FISCO', 0))+', '+
                                          'current_timestamp, '+
                                          'current_timestamp, '+
                                          '''AJUSTE DE ESTOQUE INICIAL (SAÍDA)'', ' +
                                          '1, '+
                                          'null, '+
                                          MOV_SAIDA_STR+', '+
                                          TP_MOVIMENTO_ESTOQUE_AJUSTE.ToString+'); ', lConexaoDestino.ConexaoDestino);
        if lJson.Items[I].GetValue<double>('QUANTIDADE_FISCO_INICIAL', 0) +
           lJson.Items[I].GetValue<double>('TOTAL_ENTRADAS', 0) -
           lJson.Items[I].GetValue<double>('TOTAL_SAIDAS', 0) < lJson.Items[I].GetValue<double>('QUANTIDADE_FISCO', 0) then //Entrada
          lConexaoDestino.Execute('insert into MOVIMENTO_FISCAL (PRODUTO_ID, '+
                                                                'QUANTIDADE, '+
                                                                'QUANTIDADE_ANTERIOR, '+
                                                                'DATAMOVIMENTO, '+
                                                                'DATACADASTRO, '+
                                                                'HISTORICO, ' +
                                                                'MOVIMENTO_FINAL, '+
                                                                'MOVIMENTO_ID, '+
                                                                'ENTRADA_SAIDA_ESTOQUE, '+
                                                                'TIPO_MOVIMENTO_FIXO_ID) ' +
                                  'values ('+lJson.Items[I].GetValue<string>('ID', '')+', '+
                                          FloatToSQLFloat(lJson.Items[I].GetValue<double>('QUANTIDADE_FISCO', 0) - (lJson.Items[I].GetValue<double>('QUANTIDADE_FISCO_INICIAL', 0) + lJson.Items[I].GetValue<double>('TOTAL_ENTRADAS', 0) - lJson.Items[I].GetValue<double>('TOTAL_SAIDAS', 0)))+', '+
                                          FloatToSQLFloat(lJson.Items[I].GetValue<double>('QUANTIDADE_FISCO', 0))+', '+
                                          'current_timestamp, '+
                                          'current_timestamp, '+
                                          '''AJUSTE DE ESTOQUE INICIAL (ENTRADA)'', ' +
                                          '1, '+
                                          'null, '+
                                          MOV_ENTRADA_STR+', '+
                                          TP_MOVIMENTO_ESTOQUE_AJUSTE.ToString+'); ', lConexaoDestino.ConexaoDestino);
      end;
      Log('Fim da verificação');
    end;
  finally
    lConexaoDestino.Free;
  end;
end;

procedure TfmMigrarBancoDados.Log(ATexto: string; AAlteraUltimaLinha: boolean = false);
begin
  if mmLogProcesso.Lines[mmLogProcesso.Lines.Count - 1] = ATexto then
  begin
    Application.ProcessMessages;
    Exit;
  end;
  if AAlteraUltimaLinha then
    mmLogProcesso.Lines[mmLogProcesso.Lines.Count - 1] := ATexto
  else
  begin
    if mmLogProcesso.Lines[mmLogProcesso.Lines.Count - 1][1] = '[' then
      mmLogProcesso.Lines[mmLogProcesso.Lines.Count - 1] := FormatDateTime('dd/mm/yy hh:nn:ss:zzz |', now)+' --> '+ATexto
    else
      mmLogProcesso.Lines.Add(FormatDateTime('dd/mm/yy hh:nn:ss:zzz |', now)+' --> '+ATexto);
  end;
  Application.ProcessMessages;
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

procedure TfmMigrarBancoDados.PreencherDadosEmpresa;
var
  lConexaoDestino, lConexaoOrigem: TdmConexao;
  lDadosEmpresa: string;
  lJson: TJSONArray;
begin
  lConexaoDestino := TdmConexao.Create(nil);
  lConexaoOrigem := TdmConexao.Create(nil);
  try
    lConexaoOrigem.ConectarOrigem(ConexaoOrigemToJson);
    lConexaoDestino.ConectarDestino(ConexaoDestinoToJson);
    if (lConexaoOrigem.OrigemConectado) and (lConexaoDestino.DestinoConectado) then
    begin
      mmLogProcesso.Lines.Add(' ');
      mmLogProcesso.Lines.Add('####################################################################################################');
      Log('Preenchendo dados da empresa nas configurações');
      lDadosEmpresa := lConexaoOrigem.Select('select E.*, ' +
                                                    'C.DESCRICAO CIDADE_EMPRESA, ' +
                                                    'C.ID_CIDADES_UF, ' +
                                                    'CC.DESCRICAO CIDADE_CONTADOR, ' +
                                                    'CC.ID_CIDADES_UF UF_CONTADOR '+
                                             'from TB_EMPRESA E ' +
                                             'left join CIDADES C on C.ID_CIDADES_IBGE = E.CIDADE ' +
                                             'left join CIDADES CC on CC.ID_CIDADES_IBGE = E.CONT_CIDADE', lConexaoOrigem.ConexaoOrigem);
      lJson := TJSONValue.ParseJSONValue(lDadosEmpresa) as TJSONArray;
      lConexaoDestino.Execute('update or insert into CONFIGURACOES (GRUPO, CODIGO, VALOR) ' +
                              'values (0, ''BAIRRO_EMPRESA'', '+QuotedStr(lJson.Items[0].GetValue<string>('BAIRRO', ''))+') ' +
                              'matching (CODIGO)', lConexaoDestino.ConexaoDestino);

      lConexaoDestino.Execute('update or insert into CONFIGURACOES (GRUPO, CODIGO, VALOR) ' +
                              'values (0, ''CIDADE_EMPRESA'', '+QuotedStr(lJson.Items[0].GetValue<string>('CIDADE_EMPRESA', ''))+') ' +
                              'matching (CODIGO)', lConexaoDestino.ConexaoDestino);

      lConexaoDestino.Execute('update or insert into CONFIGURACOES (GRUPO, CODIGO, VALOR) ' +
                              'values (0, ''CNPJ_EMPRESA'', '+QuotedStr(lJson.Items[0].GetValue<string>('CNPJ', ''))+') ' +
                              'matching (CODIGO)', lConexaoDestino.ConexaoDestino);

      lConexaoDestino.Execute('update or insert into CONFIGURACOES (GRUPO, CODIGO, VALOR) ' +
                              'values (0, ''EMAIL_EMPRESA'', '+QuotedStr(lJson.Items[0].GetValue<string>('EMAIL', ''))+') ' +
                              'matching (CODIGO)', lConexaoDestino.ConexaoDestino);

      lConexaoDestino.Execute('update or insert into CONFIGURACOES (GRUPO, CODIGO, VALOR) ' +
                              'values (0, ''ENDERECO_EMPRESA'', '+QuotedStr(lJson.Items[0].GetValue<string>('ENDERECO', ''))+') ' +
                              'matching (CODIGO)', lConexaoDestino.ConexaoDestino);

      lConexaoDestino.Execute('update or insert into CONFIGURACOES (GRUPO, CODIGO, VALOR) ' +
                              'values (0, ''IE_EMPRESA'', '+QuotedStr(lJson.Items[0].GetValue<string>('IE', ''))+') ' +
                              'matching (CODIGO)', lConexaoDestino.ConexaoDestino);

      lConexaoDestino.Execute('update or insert into CONFIGURACOES (GRUPO, CODIGO, VALOR) ' +
                              'values (0, ''NOMEEMPRESARELATORIO'', '+QuotedStr(lJson.Items[0].GetValue<string>('RAZAO_SOCIAL', ''))+') ' +
                              'matching (CODIGO)', lConexaoDestino.ConexaoDestino);

      lConexaoDestino.Execute('update or insert into CONFIGURACOES (GRUPO, CODIGO, VALOR) ' +
                              'values (0, ''NOMEFANTASIAEMPRESARELATORIO'', '+QuotedStr(lJson.Items[0].GetValue<string>('NOME_FANTASIA', ''))+') ' +
                              'matching (CODIGO)', lConexaoDestino.ConexaoDestino);

      lConexaoDestino.Execute('update or insert into CONFIGURACOES (GRUPO, CODIGO, VALOR) ' +
                              'values (0, ''CEP_EMPRESA'', '+QuotedStr(lJson.Items[0].GetValue<string>('CEP', ''))+') ' +
                              'matching (CODIGO)', lConexaoDestino.ConexaoDestino);

      lConexaoDestino.Execute('update or insert into CONFIGURACOES (GRUPO, CODIGO, VALOR) ' +
                              'values (0, ''CNAEEMPRESA'', '+QuotedStr(lJson.Items[0].GetValue<string>('CNAE', ''))+') ' +
                              'matching (CODIGO)', lConexaoDestino.ConexaoDestino);

      lConexaoDestino.Execute('update or insert into CONFIGURACOES (GRUPO, CODIGO, VALOR) ' +
                              'values (0, ''CODIGO_CIDADE_EMPRESA'', '+QuotedStr(lJson.Items[0].GetValue<string>('CIDADE', ''))+') ' +
                              'matching (CODIGO)', lConexaoDestino.ConexaoDestino);

      lConexaoDestino.Execute('update or insert into CONFIGURACOES (GRUPO, CODIGO, VALOR) ' +
                              'values (0, ''COMPLEMENTO_EMPRESA'', '+QuotedStr(lJson.Items[0].GetValue<string>('COMPLEMENTO', '0'))+') ' +
                              'matching (CODIGO)', lConexaoDestino.ConexaoDestino);

      lConexaoDestino.Execute('update or insert into CONFIGURACOES (GRUPO, CODIGO, VALOR) ' +
                              'values (1, ''CONTADORBAIRRO'', '+QuotedStr(lJson.Items[0].GetValue<string>('CONT_BAIRRO', ''))+') ' +
                              'matching (CODIGO)', lConexaoDestino.ConexaoDestino);

      lConexaoDestino.Execute('update or insert into CONFIGURACOES (GRUPO, CODIGO, VALOR) ' +
                              'values (1, ''CONTADORCEP'', '+QuotedStr(lJson.Items[0].GetValue<string>('CONT_CEP', ''))+') ' +
                              'matching (CODIGO)', lConexaoDestino.ConexaoDestino);

      lConexaoDestino.Execute('update or insert into CONFIGURACOES (GRUPO, CODIGO, VALOR) ' +
                              'values (1, ''CONTADORCIDADE'', '+QuotedStr(lJson.Items[0].GetValue<string>('CIDADE_CONTADOR', ''))+') ' +
                              'matching (CODIGO)', lConexaoDestino.ConexaoDestino);

      lConexaoDestino.Execute('update or insert into CONFIGURACOES (GRUPO, CODIGO, VALOR) ' +
                              'values (1, ''CONTADORCODESTABELECIMENTO'', '+QuotedStr(lJson.Items[0].GetValue<string>('COD_EST_FORTES', ''))+') ' +
                              'matching (CODIGO)', lConexaoDestino.ConexaoDestino);

      lConexaoDestino.Execute('update or insert into CONFIGURACOES (GRUPO, CODIGO, VALOR) ' +
                              'values (1, ''CONTADORCODFORTES'', '+QuotedStr(lJson.Items[0].GetValue<string>('COD_FORTES', ''))+') ' +
                              'matching (CODIGO)', lConexaoDestino.ConexaoDestino);

      lConexaoDestino.Execute('update or insert into CONFIGURACOES (GRUPO, CODIGO, VALOR) ' +
                              'values (1, ''CONTADORCODIBGE'', '+QuotedStr(lJson.Items[0].GetValue<string>('CONT_CIDADE', ''))+') ' +
                              'matching (CODIGO)', lConexaoDestino.ConexaoDestino);

      lConexaoDestino.Execute('update or insert into CONFIGURACOES (GRUPO, CODIGO, VALOR) ' +
                              'values (1, ''CONTADORCOMPLEMENTO'', '+QuotedStr(lJson.Items[0].GetValue<string>('CONT_COMPLEMENTO', ''))+') ' +
                              'matching (CODIGO)', lConexaoDestino.ConexaoDestino);

      lConexaoDestino.Execute('update or insert into CONFIGURACOES (GRUPO, CODIGO, VALOR) ' +
                              'values (1, ''CONTADORCPF'', '+QuotedStr(lJson.Items[0].GetValue<string>('CONT_CPF', ''))+') ' +
                              'matching (CODIGO)', lConexaoDestino.ConexaoDestino);

      lConexaoDestino.Execute('update or insert into CONFIGURACOES (GRUPO, CODIGO, VALOR) ' +
                              'values (1, ''CONTADORCRC'', '+QuotedStr(lJson.Items[0].GetValue<string>('CONT_CRC', ''))+') ' +
                              'matching (CODIGO)', lConexaoDestino.ConexaoDestino);

      lConexaoDestino.Execute('update or insert into CONFIGURACOES (GRUPO, CODIGO, VALOR) ' +
                              'values (1, ''CONTADOREMAIL'', '+QuotedStr(lJson.Items[0].GetValue<string>('CONT_EMAIL', ''))+') ' +
                              'matching (CODIGO)', lConexaoDestino.ConexaoDestino);

      lConexaoDestino.Execute('update or insert into CONFIGURACOES (GRUPO, CODIGO, VALOR) ' +
                              'values (1, ''CONTADORENDERECO'', '+QuotedStr(lJson.Items[0].GetValue<string>('CONT_ENDERECO', ''))+') ' +
                              'matching (CODIGO)', lConexaoDestino.ConexaoDestino);

      lConexaoDestino.Execute('update or insert into CONFIGURACOES (GRUPO, CODIGO, VALOR) ' +
                              'values (1, ''CONTADORID'', '+QuotedStr(lJson.Items[0].GetValue<string>('ID_COMPANY', ''))+') ' +
                              'matching (CODIGO)', lConexaoDestino.ConexaoDestino);

      lConexaoDestino.Execute('update or insert into CONFIGURACOES (GRUPO, CODIGO, VALOR) ' +
                              'values (1, ''CONTADORNUMERO'', '+QuotedStr(lJson.Items[0].GetValue<string>('CONT_NUMERO', ''))+') ' +
                              'matching (CODIGO)', lConexaoDestino.ConexaoDestino);

      lConexaoDestino.Execute('update or insert into CONFIGURACOES (GRUPO, CODIGO, VALOR) ' +
                              'values (1, ''CONTADORRAZAOSOCIAL'', '+QuotedStr(lJson.Items[0].GetValue<string>('CONT_RAZAO_SOCIAL', ''))+') ' +
                              'matching (CODIGO)', lConexaoDestino.ConexaoDestino);

      lConexaoDestino.Execute('update or insert into CONFIGURACOES (GRUPO, CODIGO, VALOR) ' +
                              'values (1, ''CONTADORTELEFONE'', '+QuotedStr(lJson.Items[0].GetValue<string>('CONT_FONE', ''))+') ' +
                              'matching (CODIGO)', lConexaoDestino.ConexaoDestino);

      lConexaoDestino.Execute('update or insert into CONFIGURACOES (GRUPO, CODIGO, VALOR) ' +
                              'values (1, ''CONTADORUF'', '+QuotedStr(lJson.Items[0].GetValue<string>('UF_CONTADOR', ''))+') ' +
                              'matching (CODIGO)', lConexaoDestino.ConexaoDestino);

      lConexaoDestino.Execute('update or insert into CONFIGURACOES (GRUPO, CODIGO, VALOR) ' +
                              'values (0, ''FONEEMPRESARELATORIO'', '+QuotedStr(lJson.Items[0].GetValue<string>('FONE', ''))+') ' +
                              'matching (CODIGO)', lConexaoDestino.ConexaoDestino);

      lConexaoDestino.Execute('update or insert into CONFIGURACOES (GRUPO, CODIGO, VALOR) ' +
                              'values (0, ''NUMERO_EMPRESA'', '+QuotedStr(lJson.Items[0].GetValue<string>('NUMERO', ''))+') ' +
                              'matching (CODIGO)', lConexaoDestino.ConexaoDestino);

      lConexaoDestino.Execute('update or insert into CONFIGURACOES (GRUPO, CODIGO, VALOR) ' +
                              'values (0, ''REGIMETRIBUTARIOEMPRESA'', '+QuotedStr(IntToStr(lJson.Items[0].GetValue<integer>('CRT', 1) - 1))+') ' +
                              'matching (CODIGO)', lConexaoDestino.ConexaoDestino);

      lConexaoDestino.Execute('update or insert into CONFIGURACOES (GRUPO, CODIGO, VALOR) ' +
                              'values (0, ''UF_EMPRESA'', '+QuotedStr(lJson.Items[0].GetValue<string>('ID_CIDADES_UF', ''))+') ' +
                              'matching (CODIGO)', lConexaoDestino.ConexaoDestino);
      Log('Concluido configurações');
    end;
  finally
    lConexaoDestino.Free;
    lConexaoOrigem.Free;
  end;
end;

procedure TfmMigrarBancoDados.RecalcularSequenciaTabelas;
var
  lConexaoDestino: TdmConexao;
begin
  lConexaoDestino := TdmConexao.Create(nil);
  try
    lConexaoDestino.ConectarDestino(ConexaoDestinoToJson);
    if (lConexaoDestino.DestinoConectado) then
    begin
      Log('Recalculando sequencias');
      //O SQL para recalcular as sequencias esta num memo numa tabsheet do pagecontrol principal
      lConexaoDestino.Execute(mmSQLSequencia.Lines.Text, lConexaoDestino.ConexaoDestino);
      Log('Concluido recalculando');
    end;
  finally
    lConexaoDestino.Free;
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
  GravarArrayJsonToFile(lJsonOrdem.ToJson, IncludeTrailingPathDelimiter(DirSchemasMigracaoTabelasConfiguracao)+IfThen(cbSistema.ItemIndex = ORIGEM_MASTERVENDAS, 'mv_', 'pdv_')+'ordem.json');
  lJsonOrdem.Free;
end;

procedure TfmMigrarBancoDados.SpeedButton1Click(Sender: TObject);
begin
  fodArquivo.DefaultFolder := ExtractFileDir(ParamStr(0));
  if fodArquivo.Execute then
    edCaminhoOrigem.Text := fodArquivo.FileName;
end;

procedure TfmMigrarBancoDados.SpeedButton2Click(Sender: TObject);
begin
  fodArquivo.DefaultFolder := ExtractFileDir(ParamStr(0));
  if fodArquivo.Execute then
    edCaminhoDestino.Text := fodArquivo.FileName;
end;

function TfmMigrarBancoDados.TextProgressBar(APosicao, AMax: integer): string;
const
  Animacao: array[0..3] of Char = ('-', '\', '|', '/');
var
  Progresso, Percentual: Integer;
  Barra, Indicador, LayoutFinal: string;
  IndexAnimacao: Integer;
begin
  if AMax <= 0 then
    raise Exception.Create('O valor de AMax deve ser maior que zero.');
  // Calcula a porcentagem do progresso
  Percentual := Round((APosicao / AMax) * 100);
  // Limita o valor do percentual entre 0 e 100
  if Percentual < 0 then Percentual := 0;
  if Percentual > 100 then Percentual := 100;
  // Determina o caractere de animação baseado na posição (cíclico)
  IndexAnimacao := (APosicao - 1) mod 4;
  if IndexAnimacao = -1 then
    IndexAnimacao := 0;
  Indicador := Animacao[IndexAnimacao];
  // Cria a barra de progresso usando '#' para progresso e '.' para o restante
  Progresso := Percentual; // Progresso é igual ao percentual para 100 caracteres
  Barra := StringOfChar('#', Progresso) + StringOfChar('.', 100 - Progresso);
  // Formata o layout final com o indicador, barra e percentual
  LayoutFinal := Format('[ %s %3d%% ]', [Barra, Percentual]);
  // Retorna o layout final
  Result := LayoutFinal;
  lbProcessamento.Caption := Format('[ %s ]', [Indicador]);;
end;

procedure TfmMigrarBancoDados.VerificarOrigem;
var
  lConexaoOrigem: TdmConexao;
begin
  if cbSistema.ItemIndex = ORIGEM_UP2PDV then
  begin
    lConexaoOrigem := TdmConexao.Create(nil);
    try
      lConexaoOrigem.ConectarOrigem(ConexaoOrigemToJson);
      if (lConexaoOrigem.OrigemConectado) then
      begin
        Log('Verificando campos');
        if lConexaoOrigem.Select('select RDB$FIELD_NAME CAMPO from RDB$RELATION_FIELDS where RDB$RELATION_NAME = ''TB_NFE'' and RDB$FIELD_NAME = ''ID''', lConexaoOrigem.ConexaoOrigem) = '[]' then
          btnPrepararBancoOrigemClick(btnPrepararBancoOrigem);
      end;
    finally
      lConexaoOrigem.Free;
    end;
  end;
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

procedure TfmMigrarBancoDados.btnVoltarProcessoClick(Sender: TObject);
begin
  pcPrincipal.ActivePage := tsLista;
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
  lCaminhoArquivo, lJsonLink, lSqlLink, lCampoChave: string;
  LJSONArray: TJSONArray;
  I: Integer;
begin
  if ShowQuestion('Deseja iniciar o processo de migração?') then
  begin
    mmLogProcesso.Lines.Add(' ');
    mmLogProcesso.Lines.Add('####################################################################################################');
    Log('Processo iniciado');
    VerificarOrigem;
    fmtSchemas.First;
    while not (fmtSchemas.eof) do
    begin
      if fmtSchemasSEL.AsInteger = 1 then
      begin
        Log('Carregando arquivo: '+fmtSchemasDESCRICAO.AsString);
        FLink := TPluginLink.Novo(LerJsonFromFile(fmtSchemasDIR_ARQUIVO.AsString));
        if FLink.SchemaExecucaoGrupo then
        begin
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
              if lConexaoDestino.ExecutarDestino(IfThen(FLink.SchemaInsert, FLink.GetInsertAll(FLink.SchemaExecucaoIncremental), FLink.GetUpdate),
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
                Log('Não foi possivel inserir os dados no destino: '+lConexaoDestino.ErroExecute+' <-- ATENÇÃO');
            end;
          finally
            lConexaoDestino.Free;
          end;
        end
        else
        begin
          Log('Consultando dados de: '+fmtSchemasDESCRICAO.AsString);
          lConexaoOrigem := TdmConexao.Create(nil);
          lConexaoDestino := TdmConexao.Create(nil);
          try
            lConexaoOrigem.ConectarOrigem(ConexaoOrigemToJson);
            lConexaoDestino.ConectarDestino(ConexaoDestinoToJson);
            if (lConexaoOrigem.OrigemConectado) and (lConexaoDestino.DestinoConectado) then
            begin
              LJSONArray := lConexaoOrigem.Consultar(FLink.GetSelectAll,
                                                     FLink.TabelaOrigem,
                                                     cbSistema.Text,
                                                     FLink.TabelaDestino,
                                                     lbSistemaDestino.Caption);
              try
                if lConexaoOrigem.QuantidadeUltimaConsulta > 0 then
                begin
                  Log('Registros consultados: '+lConexaoOrigem.QuantidadeUltimaConsulta.ToString);
                  if SameText(FLink.TabelaDestino, 'CLIENTES') then
                  begin
                  lJsonLink := FLink.Salvar;
                    for I := 0 to LJSONArray.Count - 1 do
                    begin
                      Log(TextProgressBar(I + 1, LJSONArray.Count), True);
                      lCampoChave := '';
                      //Valida se tem cpf ou cnpj valido
                      if LJSONArray.Items[I].GetValue<integer>('TIPOCLIENTE', 0) = 0 then //Pessoa fisica
                        if ACBrValidador.ValidarCPF(NumbersOnly(LJSONArray.Items[I].GetValue<string>('CPF', '0'))).IsEmpty then //Se não retornar nada então está correto
                          lCampoChave := 'CPF';

                      if LJSONArray.Items[I].GetValue<integer>('TIPOCLIENTE', 0) = 1 then //Pessoa juridica
                        if ACBrValidador.ValidarCNPJ(NumbersOnly(LJSONArray.Items[I].GetValue<string>('CNPJ', '0'))).IsEmpty then
                          lCampoChave := 'CNPJ';

                      if lCampoChave.IsEmpty then
                        lCampoChave := 'DESCRICAO';

                      lSqlLink := IfThen(FLink.SchemaInsert, FLink.GetInsertPessoa(lCampoChave, FLink.SchemaExecucaoIncremental), FLink.GetUpdate);

                      if not (lConexaoDestino.Executar(lSqlLink,
                                                       lJsonLink,
                                                       FLink.TabelaOrigem,
                                                       cbSistema.Text,
                                                       FLink.TabelaDestino,
                                                       lbSistemaDestino.Caption,
                                                       LJSONArray.Items[I].ToJSON)) then
                      begin
                        Log('Não foi possivel inserir o dado no destino: '+lConexaoDestino.ErroExecute+'; Objeto:'+LJSONArray.Items[I].ToJSON+' <-- ATENÇÃO');
                        Log('Continua');
                      end;
                    end;
                  end
                  else
                  if SameText(FLink.TabelaDestino, 'FORNECEDORES') then
                  begin
                    lJsonLink := FLink.Salvar;
                    for I := 0 to LJSONArray.Count - 1 do
                    begin
                      Log(TextProgressBar(I + 1, LJSONArray.Count), True);
                      lCampoChave := '';
                      //Valida se tem cpf ou cnpj valido
                      if ACBrValidador.ValidarCPF(NumbersOnly(LJSONArray.Items[I].GetValue<string>('CPF', '0'))).IsEmpty then //Se não retornar nada então está correto
                        lCampoChave := 'CPF'
                      else
                      if ACBrValidador.ValidarCNPJ(NumbersOnly(LJSONArray.Items[I].GetValue<string>('CNPJ', '0'))).IsEmpty then
                        lCampoChave := 'CNPJ';

                      if lCampoChave.IsEmpty then
                        lCampoChave := 'RAZAOSOCIAL';

                      lSqlLink := IfThen(FLink.SchemaInsert, FLink.GetInsertPessoa(lCampoChave, FLink.SchemaExecucaoIncremental), FLink.GetUpdate);

                      if not (lConexaoDestino.Executar(lSqlLink,
                                                       lJsonLink,
                                                       FLink.TabelaOrigem,
                                                       cbSistema.Text,
                                                       FLink.TabelaDestino,
                                                       lbSistemaDestino.Caption,
                                                       LJSONArray.Items[I].ToJSON)) then
                      begin
                        Log('Não foi possivel inserir o dado no destino: '+lConexaoDestino.ErroExecute+'; Objeto:'+LJSONArray.Items[I].ToJSON+' <-- ATENÇÃO');
                        Log('Continua');
                      end;
                    end;
                  end
                  else
                  if SameText(FLink.TabelaDestino, 'PRODUTOS') then
                  begin
                    lJsonLink := FLink.Salvar;
                    for I := 0 to LJSONArray.Count - 1 do
                    begin
                      Log(TextProgressBar(I + 1, LJSONArray.Count), True);
                      lCampoChave := FLink.ListaCamposChaves;
                      lSqlLink := IfThen(FLink.SchemaInsert, FLink.GetInsertProduto(lCampoChave, FLink.SchemaExecucaoIncremental), FLink.GetUpdate);
                      if not (lConexaoDestino.Executar(lSqlLink,
                                                       lJsonLink,
                                                       FLink.TabelaOrigem,
                                                       cbSistema.Text,
                                                       FLink.TabelaDestino,
                                                       lbSistemaDestino.Caption,
                                                       LJSONArray.Items[I].ToJSON)) then
                      begin
                        Log('Não foi possivel inserir o dado no destino: '+lConexaoDestino.ErroExecute+'; Objeto:'+LJSONArray.Items[I].ToJSON+' <-- ATENÇÃO');
                        Log('Continua');
                      end;
                    end;
                  end
                  else
                  begin
                    lJsonLink := FLink.Salvar;
                    lSqlLink := IfThen(FLink.SchemaInsert, FLink.GetInsertAll(FLink.SchemaExecucaoIncremental), FLink.GetUpdate);
                    for I := 0 to LJSONArray.Count - 1 do
                    begin
                      Log(TextProgressBar(I + 1, LJSONArray.Count), True);
                      if not (lConexaoDestino.Executar(lSqlLink,
                                                       lJsonLink,
                                                       FLink.TabelaOrigem,
                                                       cbSistema.Text,
                                                       FLink.TabelaDestino,
                                                       lbSistemaDestino.Caption,
                                                       LJSONArray.Items[I].ToJSON)) then
                      begin
                        Log('Não foi possivel inserir o dado no destino: '+lConexaoDestino.ErroExecute+'; Objeto:'+LJSONArray.Items[I].ToJSON+' <-- ATENÇÃO');
                        Log('Continua');
                      end;
                    end;
                  end;
                end
                else
                begin
                  Log('Nenhum registro retornado na consulta'+' <-- AVISO');
                end;
              finally
                LJSONArray.Free;
              end;
            end;
          finally
            lConexaoOrigem.Free;
            lConexaoDestino.Free;
          end;
        end;
        Log('Concluido: '+fmtSchemasDESCRICAO.AsString);
      end;
      fmtSchemas.Next;
    end;
    btnPrepararBancoDestinoClick(btnPrepararBancoDestino);
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

procedure TfmMigrarBancoDados.btnPrepararBancoDestinoClick(Sender: TObject);
begin
  if ShowQuestion('Deseja preparar os dados no banco de destino?'+sLineBreak+
                  ''+sLineBreak+
                  'Ajustes de sequencias'+sLineBreak+
                  'Dados da empresa') then
  begin
    PreencherDadosEmpresa;
    RecalcularSequenciaTabelas;
    CriarMovimentacao;
  end;
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

        //Criando VIEW para totalizadores da nfe
        lConexaoOrigem.Execute(
          'create view VW_NOTA_FISCAL ( '+
              'ID_NFE, '+
              'TOT_PRODUTOS, '+
              'ICMS_VBASE, '+
              'ICMS_IMPOSTO, '+
              'ICMSST_VBASE, '+
              'ICMSST_IMPOSTO, '+
              'TOT_SEGURO, '+
              'TOT_DESCONTO, '+
              'TOT_FRETE, '+
              'TOT_PESO, '+
              'TOT_DESPESAS, '+
              'TOT_FCP, '+
              'TOT_FCPST, '+
              'TOT_FCPSTRET, '+
              'TOT_IPI, '+
              'TOT_PIS, '+
              'TOT_COFINS, '+
              'TOT_II, '+
              'NORMAL_ICMS_MONO_TRIB_VICMS, '+
              'NORMAL_ICMS_MONO_TRIB_VBASE, '+
              'TOT_APROX_TRIBUTOS, '+
              'TOT_VALOR_ICMS_UF_DEST, '+
              'TOT_NOTA) as '+
          'select ID_NFE, '+
                 'sum(TMP.TOT_PRODUTOS) as TOT_PRODUTOS, '+
                 'sum(TMP.ICMS_VBASE) as ICMS_VBASE, '+
                 'sum(TMP.ICMS_IMPOSTO) as ICMS_IMPOSTO, '+
                 'sum(TMP.ICMSST_VBASE) as ICMSST_VBASE, '+
                 'sum(TMP.ICMSST_IMPOSTO) as ICMSST_IMPOSTO, '+
                 'sum(TMP.TOT_SEGURO) as TOT_SEGURO, '+
                 'sum(TMP.TOT_DESCONTO) as TOT_DESCONTO, '+
                 'sum(TMP.TOT_FRETE) as TOT_FRETE, '+
                 'sum(TMP.TOT_PESO_KG) as TOT_PESO, '+
                 'sum(TMP.TOT_DESPESAS) as TOT_DESPESAS, '+
                 'sum(TMP.TOT_FCP) as TOT_FCP, '+
                 'sum(TMP.TOT_FCPST) as TOT_FCPST, '+
                 'sum(TMP.TOT_FCPSTRET) as TOT_FCPSTRET, '+
                 'sum(TMP.TOT_IPI) as TOT_IPI, '+
                 'sum(TMP.TOT_PIS) as TOT_PIS, '+
                 'sum(TMP.TOT_COFINS) as TOT_COFINS, '+
                 'sum(TMP.TOT_VALOR_II) as TOT_II, '+
                 'sum(TMP.NORMAL_ICMS_MONO_TRIB_VICMS) as NORMAL_ICMS_MONO_TRIB_VICMS, '+
                 'sum(TMP.NORMAL_ICMS_MONO_TRIB_VBASE) as NORMAL_ICMS_MONO_TRIB_VBASE, '+
                 'sum(TMP.TOT_APROX_TRIBUTOS) as TOT_APROX_TRIBUTOS, '+
                 'sum(TMP.TOT_VALOR_ICMS_UF_DEST) as TOT_VALOR_ICMS_UF_DEST, '+
                 'trunc(sum(TMP.TOT_PRODUTOS) + sum(TMP.TOT_FRETE) + sum(TMP.TOT_SEGURO) + sum(TMP.ICMSST_IMPOSTO) + sum(TMP.TOT_DESPESAS) + sum(TMP.TOT_IPI) - sum(TOT_DESCONTO), 2) as TOT_NOTA '+
          'from (select NFE_ITEM.ID_NFE, '+
                       'round(sum(TOTAL), 2) as TOT_PRODUTOS, '+ //PARA IMFORMAÇÕES DO REGIME NORMAL
                       'sum(coalesce(NFE_ITEM.SIMPLES_ICMS_VBASE, 0.00)) as ICMS_VBASE, '+
                       'sum(coalesce(NFE_ITEM.SIMPLES_ICMS_VICMS, 0.00)) as ICMS_IMPOSTO, '+
                       'sum(coalesce(NFE_ITEM.SIMPLES_ST_VBASE, 0.00)) as ICMSST_VBASE, '+
                       'sum(coalesce(NFE_ITEM.SIMPLES_ST_VST, 0.00)) as ICMSST_IMPOSTO, '+
                       'sum(coalesce(TOT_SEGURO, 0.00)) as TOT_SEGURO, '+
                       'sum(coalesce(TOT_DESCONTO, 0.00)) as TOT_DESCONTO, '+
                       'sum(coalesce(TOT_FRETE, 0.00)) as TOT_FRETE, '+
                       'sum(coalesce(TOT_PESO_KG, 0.00)) as TOT_PESO_KG, '+
                       'sum(coalesce(OUT_DESPESAS, 0.00)) as TOT_DESPESAS, '+
                       'sum(coalesce(NFE_ITEM.FCP_IMPOSTO, 0.00)) as TOT_FCP, '+
                       'sum(coalesce(NFE_ITEM.FCP_ST_VIMPOSTO, 0.00)) as TOT_FCPST, '+
                       'sum(coalesce(NFE_ITEM.FCP_ST_VIMPOSTO_RET, 0.00)) as TOT_FCPSTRET, '+
                       'sum(round(coalesce(NFE_ITEM.IPI_VIMPOSTO, 0.00), 2)) as TOT_IPI, '+
                       'sum(round(coalesce(NFE_ITEM.PIS_VIMPOSTO, 0.00), 2)) as TOT_PIS, '+
                       'sum(round(coalesce(NFE_ITEM.COFINS_VIMPOSTO, 0.00), 2)) as TOT_COFINS, '+
                       'sum(coalesce(TOT_APROX_TRIBUTOS, 0.00)) as TOT_APROX_TRIBUTOS, '+
                       'sum(round(coalesce(NFE_ITEM.ICMSINTER_ICM_VIMPOSTO_UFDEST, 0), 2)) as TOT_VALOR_ICMS_UF_DEST, '+
                       'sum(coalesce(NFE_ITEM.II_VALOR, 0)) as TOT_VALOR_II, '+
                       'sum(coalesce(NFE_ITEM.NORMAL_ICMS_MONO_TRIB_VICMS, 0)) as NORMAL_ICMS_MONO_TRIB_VICMS, '+
                       'sum(coalesce(NFE_ITEM.QT_TRIB, 0)) as NORMAL_ICMS_MONO_TRIB_VBASE '+ // O VALOR BASE E AQUANTIDADE TRIBUTADA DO PRODUTO
                'from NFE_ITEM '+
                'group by 1 '+
                'union all '+
                'select NFE_ITEM.ID_NFE, '+
                       '0.00 as TOT_PRODUTOS, '+ // PARA IMFORMAÇÕES DO SIMPLES NACIONAL
                       'sum(coalesce(NFE_ITEM.NORMAL_ICMS_VBASE, 0.00)) as ICMS_VBASE, '+
                       'sum(coalesce(NFE_ITEM.NORMAL_ICMS_VICMS, 0.00)) as ICMS_IMPOSTO, '+
                       'sum(coalesce(NFE_ITEM.NORMAL_ICMSST_VBASE, 0.00)) as ICMSST_VBASE, '+
                       'sum(coalesce(NFE_ITEM.NORMAL_ICMSST_VICMS, 0.00)) as ICMSST_IMPOSTO, '+
                       '0.00 as TOT_SEGURO, '+
                       '0.00 as TOT_DESCONTO, '+
                       '0.00 as TOT_FRETE, '+
                       '0.00 as TOT_PESO_KG, '+
                       '0.00 as TOT_DESPESAS, '+
                       '0.00 as TOT_FCP, '+
                       '0.00 as TOT_FCPST, '+
                       '0.00 as TOT_FCPSTRET, '+
                       '0.00 as TOT_IPI, '+
                       '0.00 as TOT_PIS, '+
                       '0.00 as TOT_COFINS, '+
                       '0.00 as TOT_APROX_TRIBUTOS, '+
                       '0.00 as TOT_VALOR_ICMS_UF_DEST, '+
                       '0.00 as TOT_VALOR_II, '+
                       '0.00 as NORMAL_ICMS_MONO_TRIB_VICMS, '+
                       '0.00 as NORMAL_ICMS_MONO_TRIB_VBASE '+  // O VALOR BASE E AQUANTIDADE TRIBUTADA DO PRODUTO
                'from NFE_ITEM '+
                'group by 1) TMP '+
          'group by 1; ', lConexaoOrigem.ConexaoOrigem);
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
  pcPrincipal.ActivePage := tsProcesso;
end;

procedure TfmMigrarBancoDados.CarregarSchemas;
var
  I, lOrdem, lOrdemAuxiliar: integer;
  lArquivoAtual, lJsonAtual, lArquivoOrdem, lJsonOrdemString: string;
  lJsonOrdem: TJSONArray;
  O: Integer;
begin
  lArquivoOrdem := IncludeTrailingPathDelimiter(DirSchemasMigracaoTabelasConfiguracao)+IfThen(cbSistema.ItemIndex = ORIGEM_MASTERVENDAS, 'mv_', 'pdv_')+'ordem.json';
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

procedure TfmMigrarBancoDados.cbTemaSelect(Sender: TObject);
begin
  TStyleManager.SetStyle(cbTema.Text);
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

procedure TfmMigrarBancoDados.CriarMovimentacao;
begin
  Log('Criar movimentação de estoque');
  Log(TextProgressBar(0, 4), True);
  MovimentaEstoqueCFe;
  Log(TextProgressBar(1, 4), True);
  MovimentaEstoqueNFCe;
  Log(TextProgressBar(2, 4), True);
  MovimentaEstoqueNFe;
  Log(TextProgressBar(3, 4), True);
  MovimentaEstoqueEntrada;
  Log(TextProgressBar(4, 4), True);
  Log('Movimentação de estoque inicial gerada');
  InconsistenciaEstoque;
end;

procedure TfmMigrarBancoDados.ExecutarSQLDestino(ASQL: string);
var
  lConexaoDestino: TdmConexao;
begin
  lConexaoDestino := TdmConexao.Create(nil);
  try
    lConexaoDestino.ConectarDestino(ConexaoDestinoToJson);
    if (lConexaoDestino.DestinoConectado) then
    begin
      lConexaoDestino.Execute(ASQL, lConexaoDestino.ConexaoDestino);
    end;
  finally
    lConexaoDestino.Free;
  end;
end;

function TfmMigrarBancoDados.DesfazMovimentaEstoqueCFe: boolean;
var
  lSQL: string;
begin
  lSQL :=
    'execute block as ' +
    'declare variable VAR_MOVIMENTO_ID int; ' +
    'declare variable VAR_MOVIMENTO_PRODUTO_ID int; ' +
    'declare variable VAR_MOVIMENTO_QUANTIDADE numeric(10,4); ' +
    'begin ' +
      'for select ID, ' +
                 'PRODUTO_ID, ' +
                 'QUANTIDADE ' +
         'from MOVIMENTO_FISCAL ' +
         'where MOVIMENTO_FINAL = 1 ' +
         'into :VAR_MOVIMENTO_ID, :VAR_MOVIMENTO_PRODUTO_ID, :VAR_MOVIMENTO_QUANTIDADE ' +
      'do begin ' +
        'update MOVIMENTO_FISCAL ' +
        'set MOVIMENTO_FINAL = 0, ' +
            'HISTORICO = HISTORICO || '' - REGISTRO CANCELADO'' '+
        'where ID = :VAR_MOVIMENTO_ID; ' +
      'end ' +
   'end ';
  ExecutarSQLDestino(lSQL);
  Result := True;
end;

function TfmMigrarBancoDados.MovimentaEstoqueCFe: boolean;
var
  lSQL: string;
begin
  lSQL :=
    'execute block as ' +
    'declare variable VAR_ID int; ' +
    'declare variable VAR_CFE_ID int; ' +
    'declare variable VAR_CFE_PRODUTO_ID int; ' +
    'declare variable VAR_CFE_QUANTIDADE numeric(10,4); ' +
    'declare variable VAR_QUANTIDADE_ATUAL numeric(10,4); ' +
    'begin ' +
      'for select C.ID, ' +
                 'C.PRODUTO_ID, ' +
                 'C.CFE_ID, ' +
                 'C.QUANTIDADE, ' +
                 'E.QUANTIDADE_FISCO ' +
         'from CFE_PRODUTOS C ' +
         'join CFE on CFE.ID = C.CFE_ID '+
         'left join ESTOQUE E on E.PRODUTO_ID = C.PRODUTO_ID ' +
         'where CFE.STATUS = 1 ' +
         'into :VAR_ID, :VAR_CFE_PRODUTO_ID, :VAR_CFE_ID, :VAR_CFE_QUANTIDADE, :VAR_QUANTIDADE_ATUAL ' +
     'do begin ' +
        'insert into MOVIMENTO_FISCAL (PRODUTO_ID, QUANTIDADE, QUANTIDADE_ANTERIOR, DATAMOVIMENTO, DATACADASTRO, HISTORICO, ' +
                                      'MOVIMENTO_FINAL, MOVIMENTO_ID, ENTRADA_SAIDA_ESTOQUE, TIPO_MOVIMENTO_FIXO_ID, CFE_ID) ' +
        'values (:VAR_CFE_PRODUTO_ID, :VAR_CFE_QUANTIDADE, :VAR_QUANTIDADE_ATUAL, current_timestamp, current_timestamp, ''EMISSÃO DE CUPOM FISCAL'', ' +
                '1, :VAR_ID, '+MOV_SAIDA_STR+', '+TP_MOVIMENTO_ESTOQUE_CFE.ToString+', :VAR_CFE_ID); ' +
     'end ' +
   'end ';
  //DesfazMovimentaEstoqueCFe;
  ExecutarSQLDestino(lSQL);
  Result := True;
  Log('Movimentação fiscal do CF-e');
end;

function TfmMigrarBancoDados.DesfazMovimentaEstoqueNFCe: boolean;
var
  lSQL: string;
begin
  lSQL :=
    'execute block as ' +
    'declare variable VAR_MOVIMENTO_ID int; ' +
    'declare variable VAR_MOVIMENTO_PRODUTO_ID int; ' +
    'declare variable VAR_MOVIMENTO_QUANTIDADE numeric(10,4); ' +
    'begin ' +
      'for select ID, ' +
                 'PRODUTO_ID, ' +
                 'QUANTIDADE ' +
         'from MOVIMENTO_FISCAL ' +
         'where MOVIMENTO_FINAL = 1 ' +
         'into :VAR_MOVIMENTO_ID, :VAR_MOVIMENTO_PRODUTO_ID, :VAR_MOVIMENTO_QUANTIDADE ' +
      'do begin ' +
        'update MOVIMENTO_FISCAL ' +
        'set MOVIMENTO_FINAL = 0, ' +
            'HISTORICO = HISTORICO || '' - REGISTRO CANCELADO'' '+
        'where ID = :VAR_MOVIMENTO_ID; ' +
      'end ' +
   'end ';
  ExecutarSQLDestino(lSQL);
  Result := True;
end;

function TfmMigrarBancoDados.MovimentaEstoqueNFCe: boolean;
var
  lSQL: string;
begin
  lSQL :=
    'execute block as ' +
    'declare variable VAR_ID int; ' +
    'declare variable VAR_NFCE_ID int; ' +
    'declare variable VAR_NFCE_PRODUTO_ID int; ' +
    'declare variable VAR_NFCE_QUANTIDADE numeric(10,4); ' +
    'declare variable VAR_QUANTIDADE_ATUAL numeric(10,4); ' +
    'begin ' +
      'for select C.ID, ' +
                 'C.PRODUTO_ID, ' +
                 'C.NFCE_ID, ' +
                 'C.QUANTIDADE, ' +
                 'E.QUANTIDADE_FISCO ' +
         'from NFCE_PRODUTOS C ' +
         'join NFCE on NFCE.ID = C.NFCE_ID '+
         'left join ESTOQUE E on E.PRODUTO_ID = C.PRODUTO_ID ' +
         'where NFCE.STATUS = 1 ' +
         'into :VAR_ID, :VAR_NFCE_PRODUTO_ID, :VAR_NFCE_ID, :VAR_NFCE_QUANTIDADE, :VAR_QUANTIDADE_ATUAL ' +
     'do begin ' +
        'insert into MOVIMENTO_FISCAL (PRODUTO_ID, QUANTIDADE, QUANTIDADE_ANTERIOR, DATAMOVIMENTO, DATACADASTRO, HISTORICO, ' +
                                      'MOVIMENTO_FINAL, MOVIMENTO_ID, ENTRADA_SAIDA_ESTOQUE, TIPO_MOVIMENTO_FIXO_ID, NFCE_ID) ' +
        'values (:VAR_NFCE_PRODUTO_ID, :VAR_NFCE_QUANTIDADE, :VAR_QUANTIDADE_ATUAL, current_timestamp, current_timestamp, ''EMISSÃO DE CUPOM FISCAL'', ' +
                '1, :VAR_ID, '+MOV_SAIDA_STR+', '+TP_MOVIMENTO_ESTOQUE_NFCE.ToString+', :VAR_NFCE_ID); ' +
     'end ' +
   'end ';
  //DesfazMovimentaEstoqueNFCe;
  ExecutarSQLDestino(lSQL);
  Result := True;
  Log('Movimentação fiscal do NFC-e');
end;

function TfmMigrarBancoDados.DesfazMovimentaEstoqueNFe: boolean;
var
  lSQL: string;
begin
  lSQL := 'execute block '+
          'as '+
          'declare variable VAR_MOVIMENTO_ID int; '+
          'declare variable VAR_MOVIMENTO_PRODUTO_ID int; '+
          'declare variable VAR_MOVIMENTO_QUANTIDADE numeric(10,4); '+
          'declare variable VAR_ENTRADA_SAIDA_ESTOQUE int; '+
          'begin '+
            'for select ID, '+
                       'PRODUTO_ID, '+
                       'QUANTIDADE, '+
                       'ENTRADA_SAIDA_ESTOQUE '+
                'from MOVIMENTO_FISCAL '+
                'where MOVIMENTO_FINAL = 1 '+
                'into :VAR_MOVIMENTO_ID, :VAR_MOVIMENTO_PRODUTO_ID, :VAR_MOVIMENTO_QUANTIDADE, :VAR_ENTRADA_SAIDA_ESTOQUE '+
            'do '+
            'begin '+
              'update MOVIMENTO_FISCAL '+
              'set MOVIMENTO_FINAL = 0, '+
                  'HISTORICO = HISTORICO || '' - REGISTRO DESFEITO'' '+
              'where ID = :VAR_MOVIMENTO_ID; '+
            'end '+
          'end ';
  ExecutarSQLDestino(lSQL);
  Result := True;
end;

function TfmMigrarBancoDados.MovimentaEstoqueNFe: boolean;
var
  lSQL: string;
begin
  lSQL := 'execute block '+
          'as '+
          'declare variable VAR_ID int;       '+
          'declare variable VAR_NFE_PRODUTO_ID int;    '+
          'declare variable VAR_NFE_PRODUTO_CFOP varchar(5);    '+
          'declare variable VAR_CFOP_TIPO_MOVIMENTO char(1); '+
          'declare variable VAR_NFE_ID int; '+
          'declare variable VAR_NFE_QUANTIDADE numeric(10,4); '+
          'declare variable VAR_QUANTIDADE_ATUAL numeric(10,4); '+
          'begin '+
            'for select P.ID, '+
                       'P.PRODUTO_ID, '+
                       'P.CFOP, '+
                       'P.NFE_ID, '+
                       'P.QUANTIDADE, '+
                       'E.QUANTIDADE_FISCO '+
                'from NFE_PRODUTOS P '+
                'join NFE on NFE.ID = P.NFE_ID '+
                'left join ESTOQUE E on E.PRODUTO_ID = P.PRODUTO_ID '+
                'where NFE.STATUS = 1 '+
                'into :VAR_ID, :VAR_NFE_PRODUTO_ID, :VAR_NFE_PRODUTO_CFOP, :VAR_NFE_ID, :VAR_NFE_QUANTIDADE, :VAR_QUANTIDADE_ATUAL '+
            'do '+
            'begin '+
              'select substring(OPERACAO from 1 for 1) from CFOP where CODIGO = :VAR_NFE_PRODUTO_CFOP into :VAR_CFOP_TIPO_MOVIMENTO; '+
              'if (VAR_CFOP_TIPO_MOVIMENTO = ''S'') then '+
              'begin '+
                  'insert into MOVIMENTO_FISCAL (PRODUTO_ID, QUANTIDADE, QUANTIDADE_ANTERIOR, DATAMOVIMENTO, DATACADASTRO, HISTORICO, '+
                                                'MOVIMENTO_FINAL, MOVIMENTO_ID, ENTRADA_SAIDA_ESTOQUE, TIPO_MOVIMENTO_FIXO_ID, NFE_ID) '+
                  'values (:VAR_NFE_PRODUTO_ID, :VAR_NFE_QUANTIDADE, :VAR_QUANTIDADE_ATUAL, current_timestamp, current_timestamp, ''EMISSÃO DE NFE'', '+
                          '1, :VAR_ID, '+MOV_SAIDA_STR+', '+TP_MOVIMENTO_ESTOQUE_NFE_SAIDA.ToString+', :VAR_NFE_ID); '+
              'end '+
              'if (VAR_CFOP_TIPO_MOVIMENTO = ''E'') then '+
              'begin '+
                  'insert into MOVIMENTO_FISCAL (PRODUTO_ID, QUANTIDADE, QUANTIDADE_ANTERIOR, DATAMOVIMENTO, DATACADASTRO, HISTORICO, '+
                                                'MOVIMENTO_FINAL, MOVIMENTO_ID, ENTRADA_SAIDA_ESTOQUE, TIPO_MOVIMENTO_FIXO_ID, NFE_ID) '+
                  'values (:VAR_NFE_PRODUTO_ID, :VAR_NFE_QUANTIDADE, :VAR_QUANTIDADE_ATUAL, current_timestamp, current_timestamp, ''EMISSÃO DE NFE'', '+
                          '1, :VAR_ID, '+MOV_ENTRADA_STR+', '+TP_MOVIMENTO_ESTOQUE_NFE_ENTRADA.ToString+', :VAR_NFE_ID); '+
              'end '+
            'end '+
          'end ';
  //DesfazMovimentaEstoqueNFe;
  ExecutarSQLDestino(lSQL);
  Result := True;
  Log('Movimentação fiscal de NF-e');
end;

function TfmMigrarBancoDados.DesfazMovimentaEstoqueEntrada: boolean;
var
  lSQL: string;
begin
  lSQL :=
    'execute block as ' +
    'declare variable VAR_MOVIMENTO_ID int; ' +
    'declare variable VAR_MOVIMENTO_PRODUTO_ID int; ' +
    'declare variable VAR_MOVIMENTO_QUANTIDADE numeric(10,4); ' +
    'begin ' +
      'for select ID, ' +
                 'PRODUTO_ID, ' +
                 'QUANTIDADE ' +
         'from MOVIMENTO_FISCAL ' +
         'where MOVIMENTO_FINAL = 1 ' +
         'into :VAR_MOVIMENTO_ID, :VAR_MOVIMENTO_PRODUTO_ID, :VAR_MOVIMENTO_QUANTIDADE ' +
      'do begin ' +
        'update MOVIMENTO_FISCAL ' +
        'set MOVIMENTO_FINAL = 0, ' +
            'HISTORICO = HISTORICO || '' - REGISTRO CANCELADO ('' || ENTRADA_NOTA_ID || '')'', '+
            'ENTRADA_NOTA_ID = null '+
        'where ID = :VAR_MOVIMENTO_ID; ' +
      'end ' +
   'end ';
  ExecutarSQLDestino(lSQL);
  Result := True;
end;

function TfmMigrarBancoDados.MovimentaEstoqueEntrada: boolean;
var
  lSQL: string;
begin
  lSQL :=
    'execute block as ' +
    'declare variable VAR_ID int; ' +
    'declare variable VAR_ENTRADA_ID int; ' +
    'declare variable VAR_ENTRADA_PRODUTO_ID int; ' +
    'declare variable VAR_ENTRADA_QUANTIDADE numeric(10,4); ' +
    'declare variable VAR_QUANTIDADE_ATUAL numeric(10,4); ' +
    'begin ' +
      'for select P.ID, ' +
                 'P.PRODUTO_ID, ' +
                 'P.NOTA_ENTRADA_ID, ' +
                 'P.QUANTIDADE_ENTRA, ' +
                 'E.QUANTIDADE_FISCO ' +
         'from PRODUTOS_ENTRADAS P ' +
         'left join ESTOQUE E on E.PRODUTO_ID = P.PRODUTO_ID ' +
         'into :VAR_ID, :VAR_ENTRADA_PRODUTO_ID, :VAR_ENTRADA_ID, :VAR_ENTRADA_QUANTIDADE, :VAR_QUANTIDADE_ATUAL ' +
     'do begin ' +
        'insert into MOVIMENTO_FISCAL (PRODUTO_ID, QUANTIDADE, QUANTIDADE_ANTERIOR, DATAMOVIMENTO, DATACADASTRO, HISTORICO, ' +
                                      'MOVIMENTO_FINAL, MOVIMENTO_ID, ENTRADA_SAIDA_ESTOQUE, TIPO_MOVIMENTO_FIXO_ID, ENTRADA_NOTA_ID) ' +
        'values (:VAR_ENTRADA_PRODUTO_ID, :VAR_ENTRADA_QUANTIDADE, :VAR_QUANTIDADE_ATUAL, current_timestamp, current_timestamp, ''ENTRADA DE NOTA FISCAL'', ' +
                '1, :VAR_ID, '+MOV_ENTRADA_STR+', '+TP_MOVIMENTO_ESTOQUE_ENTRADA.ToString+', :VAR_ENTRADA_ID); ' +
     'end ' +
   'end ';
  //DesfazMovimentaEstoqueEntrada;
  ExecutarSQLDestino(lSQL);
  Result := True;
  Log('Movimentação fiscal de Entrada de Nota');
end;

end.
