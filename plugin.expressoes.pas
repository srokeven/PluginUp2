unit plugin.expressoes;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls;

type
  TfmMontarExperssao = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    rbOpcaoIif: TRadioButton;
    rbOpcaoCase: TRadioButton;
    btnOk: TButton;
    btnCancelar: TButton;
    mmResultado: TMemo;
    Label1: TLabel;
    lbTextoSE1: TLabel;
    edCondicao: TEdit;
    lbTextoSE2: TLabel;
    edSEVerdadeiro: TEdit;
    lbTextoSE3: TLabel;
    edSEFalso: TEdit;
    btnGerarIF: TButton;
    lbTextoCASO1: TLabel;
    edCasoWhen: TEdit;
    lbTextoCASO2: TLabel;
    edCasoThen: TEdit;
    btnAdicionarCASE: TButton;
    btnLimparCase: TButton;
    rbConverter: TRadioButton;
    rbValorPadrao: TRadioButton;
    edValorPadrao: TEdit;
    btnGerarValorPadrao: TButton;
    btnGerarSQLConversao: TButton;
    rbSelectFromTable: TRadioButton;
    edTabelaEstrangeira: TEdit;
    Label2: TLabel;
    edCampoEstrangeiro: TEdit;
    Label3: TLabel;
    btnGerarSelectFromTable: TButton;
    procedure rbOpcaoIifClick(Sender: TObject);
    procedure btnGerarIFClick(Sender: TObject);
    procedure btnAdicionarCASEClick(Sender: TObject);
    procedure btnLimparCaseClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnGerarSQLConversaoClick(Sender: TObject);
    procedure btnGerarValorPadraoClick(Sender: TObject);
    procedure btnGerarSelectFromTableClick(Sender: TObject);
  private
    FCampoOrigem, FCampoDestino, FTipoCampoOrigem, FTipoCampoDestino, FTamanhoDestino: string;
    FCase: string;
    procedure TratarTextos(ACampoOrigem, ACampoDestino, ATipoCampoOrigem, ATipoCampoDestino, ATamanhoDestino: string);
  public
    class function GetExpression(ACampoOrigem, ACampoDestino, ATipoCampoOrigem, ATipoCampoDestino, ATamanhoDestino: string): string;
  end;

var
  fmMontarExperssao: TfmMontarExperssao;

implementation

uses
  System.StrUtils;

{$R *.dfm}

{ TfmMontarExperssao }

procedure TfmMontarExperssao.btnAdicionarCASEClick(Sender: TObject);
begin
  FCase := IfThen(FCase.IsEmpty, '', FCase+sLineBreak) + Format('when %s then %s', [QuotedStr(edCasoWhen.Text), QuotedStr(edCasoThen.Text)]);
  mmResultado.Lines.Clear;
  mmResultado.Lines.Add('case '+FCampoOrigem);
  mmResultado.Lines.Add(FCase);
  mmResultado.Lines.Add('end as '+FCampoDestino);
end;

procedure TfmMontarExperssao.btnGerarIFClick(Sender: TObject);
begin
  mmResultado.Lines.Text := Format('iif(%s = ''%s'', ''%s'', ''%s'') as %s', [FCampoOrigem,
                                                                              edCondicao.Text,
                                                                              edSEVerdadeiro.Text,
                                                                              edSEFalso.Text,
                                                                              FCampoDestino])
end;

procedure TfmMontarExperssao.btnGerarSelectFromTableClick(Sender: TObject);
begin
  mmResultado.Lines.Text := '/*#'+FCampoOrigem+'-'+edTabelaEstrangeira.Text+'-'+edCampoEstrangeiro.Text+'#*/'+' '+FCampoOrigem+' as '+FCampoDestino;
end;

procedure TfmMontarExperssao.btnGerarSQLConversaoClick(Sender: TObject);
begin
  case FTipoCampoDestino.ToInteger of
    0: mmResultado.Lines.Text := 'cast('+FCampoOrigem+' as varchar('+FTamanhoDestino+')) as '+FCampoDestino;
    1: mmResultado.Lines.Text := 'cast('+FCampoOrigem+' as integer) as '+FCampoDestino;
    2: mmResultado.Lines.Text := 'cast('+FCampoOrigem+' as numeric(15,7)) as '+FCampoDestino;
    3: mmResultado.Lines.Text := 'cast('+FCampoOrigem+' as date) as '+FCampoDestino;
    4: mmResultado.Lines.Text := 'cast('+FCampoOrigem+' as timestamp) as '+FCampoDestino;
    5: mmResultado.Lines.Text := 'cast('+FCampoOrigem+' as blob sub_type 1 segment size 1024) as '+FCampoDestino;
  end;
end;

procedure TfmMontarExperssao.btnGerarValorPadraoClick(Sender: TObject);
begin
  case FTipoCampoDestino.ToInteger of
    0: mmResultado.Lines.Text := QuotedStr(edValorPadrao.Text)+' as '+FCampoDestino;
    1: mmResultado.Lines.Text := edValorPadrao.Text+' as '+FCampoDestino;
    2: mmResultado.Lines.Text := ReplaceStr(edValorPadrao.Text, ',', '.')+' as '+FCampoDestino;
    3: mmResultado.Lines.Text := edValorPadrao.Text+' as '+FCampoDestino;
    4: mmResultado.Lines.Text := edValorPadrao.Text+' as '+FCampoDestino;
    5: mmResultado.Lines.Text := QuotedStr(edValorPadrao.Text)+' as '+FCampoDestino;
  end;
end;

procedure TfmMontarExperssao.btnLimparCaseClick(Sender: TObject);
begin
  FCase := '';
  mmResultado.Lines.Clear;
end;

procedure TfmMontarExperssao.FormShow(Sender: TObject);
begin
  rbOpcaoIif.Checked := True;
end;

class function TfmMontarExperssao.GetExpression(ACampoOrigem,
  ACampoDestino, ATipoCampoOrigem, ATipoCampoDestino, ATamanhoDestino: string): string;
begin
  Application.CreateForm(TfmMontarExperssao, fmMontarExperssao);
  try
    fmMontarExperssao.TratarTextos(ACampoOrigem, ACampoDestino, ATipoCampoOrigem, ATipoCampoDestino, ATamanhoDestino);
    if fmMontarExperssao.ShowModal = mrOk then
      Result := fmMontarExperssao.mmResultado.Lines.Text;
  finally
    FreeAndNil(fmMontarExperssao);
  end;
end;

procedure TfmMontarExperssao.rbOpcaoIifClick(Sender: TObject);
begin
  edCondicao.Enabled := rbOpcaoIif.Checked;
  edSEVerdadeiro.Enabled := rbOpcaoIif.Checked;
  edSEFalso.Enabled := rbOpcaoIif.Checked;
  btnGerarIF.Enabled := rbOpcaoIif.Checked;
  edCasoWhen.Enabled := rbOpcaoCase.Checked;
  edCasoThen.Enabled := rbOpcaoCase.Checked;
  btnAdicionarCASE.Enabled := rbOpcaoCase.Checked;
  btnLimparCase.Enabled := rbOpcaoCase.Checked;
  edValorPadrao.Enabled := rbValorPadrao.Checked;
  btnGerarValorPadrao.Enabled := rbValorPadrao.Checked;
  btnGerarSQLConversao.Enabled := rbConverter.Checked;
  edTabelaEstrangeira.Enabled := rbSelectFromTable.Checked;
  edCampoEstrangeiro.Enabled := rbSelectFromTable.Checked;
  btnGerarSelectFromTable.Enabled := rbSelectFromTable.Checked;
end;

procedure TfmMontarExperssao.TratarTextos(ACampoOrigem, ACampoDestino, ATipoCampoOrigem, ATipoCampoDestino, ATamanhoDestino: string);
var
  lTipoStrOrigem, lTipoStrDestino: string;
begin
  case ATipoCampoOrigem.ToInteger of
    0: lTipoStrOrigem := 'Texto';
    1: lTipoStrOrigem := 'Inteiro';
    2: lTipoStrOrigem := 'Real';
    3: lTipoStrOrigem := 'Data';
    4: lTipoStrOrigem := 'Data/Hora';
    5: lTipoStrOrigem := 'Texto grande';
  end;
  case ATipoCampoDestino.ToInteger of
    0: lTipoStrDestino := 'Texto';
    1: lTipoStrDestino := 'Inteiro';
    2: lTipoStrDestino := 'Real';
    3: lTipoStrDestino := 'Data';
    4: lTipoStrDestino := 'Data/Hora';
    5: lTipoStrDestino := 'Texto grande';
  end;
  FCampoOrigem := ACampoOrigem;
  FCampoDestino := ACampoDestino;
  FTipoCampoOrigem := ATipoCampoOrigem;
  FTipoCampoDestino := ATipoCampoDestino;
  FTamanhoDestino := ATamanhoDestino;
  lbTextoSE1.Caption := Format('Se o valor do campo %s for igual a...', [FCampoOrigem]);
  lbTextoSE2.Caption := Format('Então o campo %s receberá o valor...', [FCampoDestino]);
  lbTextoSE3.Caption := Format('Se não, então o campo %s receberá o valor...', [FCampoDestino]);
  lbTextoCASO1.Caption := Format('Caso o valor do campo %s for igual a...', [FCampoOrigem]);
  lbTextoCASO2.Caption := Format('Então o campo %s receberá o valor...', [FCampoDestino]);
  rbConverter.Caption := Format('Converter campo %s para %s', [lTipoStrOrigem, lTipoStrDestino]);
  rbValorPadrao.Caption := Format('Informar valor padrão para o campo %s', [ACampoDestino]);
end;

end.
