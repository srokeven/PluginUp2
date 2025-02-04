unit plugin.main;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, plugin.controller.databases,
  plugin.controller.tables, uUtils, Vcl.StdCtrls, plugin.controller.links,
  plugin.controller.schemas, plugin.cadastros, plugin.servico.manutencao,
  cxGraphics, cxLookAndFeels, cxLookAndFeelPainters, Vcl.Menus, cxButtons,
  plugin.migrar;

type
  TfmrMainPlugin = class(TForm)
    btnServicos: TcxButton;
    btnConfiguracoes: TcxButton;
    btnMigracao: TcxButton;
    procedure FormCreate(Sender: TObject);
    procedure btnServicosClick(Sender: TObject);
    procedure btnConfiguracoesClick(Sender: TObject);
    procedure btnMigracaoClick(Sender: TObject);
  private
  public
  end;

var
  fmrMainPlugin: TfmrMainPlugin;

implementation

{$R *.dfm}

procedure TfmrMainPlugin.btnConfiguracoesClick(Sender: TObject);
begin
  fmCadastros := TfmCadastros.Create(Self);
  try
    fmCadastros.ShowModal;
  finally
    fmCadastros.Free;
  end;
end;

procedure TfmrMainPlugin.btnMigracaoClick(Sender: TObject);
begin
  fmMigrarBancoDados := TfmMigrarBancoDados.Create(Self);
  try
    fmMigrarBancoDados.ShowModal;
  finally
    fmMigrarBancoDados.Free;
  end;
end;

procedure TfmrMainPlugin.btnServicosClick(Sender: TObject);
begin
  fmServicos := TfmServicos.Create(Self);
  try
    fmServicos.ShowModal;
  finally
    fmServicos.Free;
  end;
end;

procedure TfmrMainPlugin.FormCreate(Sender: TObject);
begin
  CriarPastasPadronizadas;
end;

end.
