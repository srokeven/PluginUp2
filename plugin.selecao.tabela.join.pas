unit plugin.selecao.tabela.join;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, Data.DB, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, FileSearchUnit, uUtils, Vcl.StdCtrls, Vcl.Grids,
  Vcl.DBGrids, System.JSON, System.StrUtils;

type
  TfmSelecionarTabelaJoin = class(TForm)
    pnlGridTabelas: TPanel;
    pnlBackground: TPanel;
    fmtTabelasOrigem: TFDMemTable;
    fmtTabelasOrigemSEL: TIntegerField;
    fmtTabelasOrigemORDEM: TIntegerField;
    fmtTabelasOrigemDESCRICAO: TStringField;
    fmtTabelasOrigemARQUIVO: TStringField;
    dsTabelasOrigem: TDataSource;
    grTabelasOrigem: TDBGrid;
    Label1: TLabel;
    mmCondicao: TMemo;
    btnConfirmar: TButton;
    btnCancelar: TButton;
    chkJoinObrigatorio: TCheckBox;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure dsTabelasOrigemDataChange(Sender: TObject; Field: TField);
    procedure FormShow(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure btnConfirmarClick(Sender: TObject);
  private
    flbListaArquivos: TFileSearch;
    FSistemaAtual, FChavePrimariaAtual, FTabelaAtual, FChavePrimariaJoin: string;
    procedure CarregarTabelasOrigem(ATabelaAtual, ASistema: string);
    function GetChavePrimaria(AArquivoJson: string): string;
  public
    function GetTipoJoin: string;
    procedure SetDadosAtual(ASistema, AChavePrimaria, ATabela: string);
  end;

var
  fmSelecionarTabelaJoin: TfmSelecionarTabelaJoin;

implementation

{$R *.dfm}

{ TfmSelecionarTabelaJoin }

procedure TfmSelecionarTabelaJoin.btnCancelarClick(Sender: TObject);
begin
  ModalResult := mrCancel;
end;

procedure TfmSelecionarTabelaJoin.btnConfirmarClick(Sender: TObject);
begin
  ModalResult := mrOk;
end;

procedure TfmSelecionarTabelaJoin.CarregarTabelasOrigem(ATabelaAtual,
  ASistema: string);
var
  lArquivoAtual: string;
  I, O: Integer;
begin
  fmtTabelasOrigem.Close;
  fmtTabelasOrigem.Open;
  flbListaArquivos.Extension('.json');
  flbListaArquivos.Execute;
  for I := 0 to flbListaArquivos.GetFileList.Count -1 do
  begin
    lArquivoAtual := LerJsonFromFile(flbListaArquivos.GetFileList[I]);
    if (LerJson(lArquivoAtual, 'sistema') = ASistema) and (LerJson(lArquivoAtual, 'tabela') <> ATabelaAtual) then
    begin
      fmtTabelasOrigem.Append;
      fmtTabelasOrigemDESCRICAO.AsString := LerJson(lArquivoAtual, 'tabela');
      fmtTabelasOrigemARQUIVO.AsString := flbListaArquivos.GetFileList[I];
      fmtTabelasOrigem.Post;
    end;
  end;
  fmtTabelasOrigem.First;
end;

procedure TfmSelecionarTabelaJoin.dsTabelasOrigemDataChange(Sender: TObject;
  Field: TField);
begin
  mmCondicao.Lines.Text := Format(' %s.%s = %s.%s ', [dsTabelasOrigem.DataSet.FieldByName('DESCRICAO').AsString,
                                                      GetChavePrimaria(dsTabelasOrigem.DataSet.FieldByName('ARQUIVO').AsString),
                                                      FTabelaAtual,
                                                      FChavePrimariaAtual]);
end;

procedure TfmSelecionarTabelaJoin.FormCreate(Sender: TObject);
begin
  flbListaArquivos := TFileSearch.Create(DirTabelas, '.json');
end;

procedure TfmSelecionarTabelaJoin.FormDestroy(Sender: TObject);
begin
  flbListaArquivos.Free;
end;

procedure TfmSelecionarTabelaJoin.FormShow(Sender: TObject);
begin
  CarregarTabelasOrigem(FTabelaAtual, FSistemaAtual);
end;

function TfmSelecionarTabelaJoin.GetChavePrimaria(AArquivoJson: string): string;
var
  lJsonTabela, lJsonCampos: string;
  lCampos: TJSONArray;
  I: Integer;
begin
  lJsonTabela := LerJsonFromFile(AArquivoJson);
  lJsonCampos := LerJsonArray(lJsonTabela, 'campos');
  lCampos := TJSONObject.ParseJSONValue(lJsonCampos) as TJSONArray;
  for I := 0 to lCampos.Count - 1 do
  begin
    if not (lCampos.Items[I].GetValue<string>('campo') = 'DATA_ALTERADO') then
    begin
      if lCampos.Items[I].GetValue<string>('chaveprimaria') = 'S' then
      begin
        Result := lCampos.Items[I].GetValue<string>('campo');
        Break;
      end;
    end;
  end;
  lCampos.Free;
end;

function TfmSelecionarTabelaJoin.GetTipoJoin: string;
begin
  Result := IfThen(chkJoinObrigatorio.Checked, 'inner', 'left');
end;

procedure TfmSelecionarTabelaJoin.SetDadosAtual(ASistema, AChavePrimaria,
  ATabela: string);
begin
  FSistemaAtual := ASistema;
  FChavePrimariaAtual := AChavePrimaria;
  FTabelaAtual := ATabela;
end;

end.
