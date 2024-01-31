unit plugin.clonar;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, Data.DB,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, Vcl.Grids, Vcl.DBGrids,
  Vcl.ComCtrls, FileSearchUnit, uUtils;

type
  TfmClonarBancoDados = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    Label1: TLabel;
    cbSistema: TComboBox;
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
    Button1: TButton;
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
    btnVoltarBancos: TButton;
    tsProcesso: TTabSheet;
    Panel3: TPanel;
    Panel4: TPanel;
    btnVoltarProcesso: TButton;
    btnProximoProcesso: TButton;
    mmLogProcesso: TMemo;
    Label12: TLabel;
    Panel5: TPanel;
    Panel6: TPanel;
    btnSelecionarLista: TButton;
    btnAtualizar: TButton;
    grBancoDados: TDBGrid;
    dsSchemas: TDataSource;
    fmtSchemas: TFDMemTable;
    fmtSchemasDESCRICAO: TStringField;
    fmtSchemasDIR_ARQUIVO: TStringField;
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btnSelecionarListaClick(Sender: TObject);
  private
    flbListaArquivos: TFileSearch;
    procedure CarregarSchemas;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fmClonarBancoDados: TfmClonarBancoDados;

implementation

{$R *.dfm}

procedure TfmClonarBancoDados.FormCreate(Sender: TObject);
begin
  flbListaArquivos := TFileSearch.Create(DirSchemasMigracao, '.json');
end;

procedure TfmClonarBancoDados.FormDestroy(Sender: TObject);
begin
  flbListaArquivos.Free;
end;

procedure TfmClonarBancoDados.FormShow(Sender: TObject);
begin
  CarregarSchemas;
end;

procedure TfmClonarBancoDados.btnSelecionarListaClick(Sender: TObject);
begin
  if fmtSchemas.isempty then
  begin
    ShowWarning('Nenhum regitro de schema');
    Exit;
  end;
end;

procedure TfmClonarBancoDados.CarregarSchemas;
var
  I: integer;
  lArquivoAtual, lJsonAtual: string;
begin
  fmtSchemas.Close;
  fmtSchemas.Open;
  flbListaArquivos.Directory(DirSchemasMigracao);
  flbListaArquivos.Extension('.json');
  flbListaArquivos.Execute;
  for I := 0 to flbListaArquivos.GetFileList.Count -1 do
  begin
    lArquivoAtual := flbListaArquivos.GetFileList[I];
    lJsonAtual := LerJsonFromFile(lArquivoAtual);
    fmtSchemas.Append;
    fmtSchemasDESCRICAO.AsString := ExtrairTextoAPartirDePosicao(ExtractFileName(flbListaArquivos.GetFileList[I]), '.', EXTRAIR_PRE_TRECHO);
    fmtSchemasDIR_ARQUIVO.AsString := lArquivoAtual;
    fmtSchemas.Post;
  end;
  fmtSchemas.First;
end;

end.
