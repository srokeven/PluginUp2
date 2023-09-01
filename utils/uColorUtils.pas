unit uColorUtils;

interface

uses
  System.SysUtils, Vcl.Graphics, Vcl.Themes, Vcl.StdCtrls, Vcl.Controls;

type
  TColorUtils = class
  private
  public
    class procedure GetColorScheme(ANumber: Integer; out bgColor, textColor: TColor);
    class procedure AlterarCorTextoBotao(Button: TButton; Cor: TColor); static;
  end;

implementation

{ TColorUtils }

class procedure TColorUtils.GetColorScheme(ANumber: Integer; out bgColor, textColor: TColor);
const
  BackgroundColors: array[1..12] of TColor = (
    $FF5733, $FF8A33, $FFC433, $FFEC33, $E9FF33, $B8FF33,
    $8CFF33, $33FF38, $33FF70, $33FFA3, $33FFE1, $33CCFF
  );
  TextColors: array[1..12] of TColor = (
    clWhite, clWhite, clBlack, clBlack, clBlack, clBlack,
    clBlack, clBlack, clBlack, clBlack, clBlack, clBlack
  );
begin
  if (ANumber >= 1) and (ANumber <= 12) then
  begin
    bgColor := BackgroundColors[ANumber];
    textColor := TextColors[ANumber];
  end
  else
  begin
    bgColor := clWhite;
    textColor := clBlack;
  end;
end;

class procedure TColorUtils.AlterarCorTextoBotao(Button: TButton; Cor: TColor);
begin
  if TStyleManager.IsCustomStyleActive then
  begin
    Button.Font.Color := Cor;
    Button.Invalidate; // Forçar a atualização da aparência do botão
  end;
end;

end.

