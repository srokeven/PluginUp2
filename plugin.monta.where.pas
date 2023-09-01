unit plugin.monta.where;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls;

type
  TfmMontaWhere = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    mmWherePadrao: TMemo;
    mmWhereAdicional: TMemo;
    Label1: TLabel;
    Label2: TLabel;
    btnCancelar: TButton;
    btnConfirmar: TButton;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fmMontaWhere: TfmMontaWhere;

implementation

{$R *.dfm}

end.
