object fmMontaWhere: TfmMontaWhere
  Left = 0
  Top = 0
  Caption = 'Montar condicional personalizado'
  ClientHeight = 502
  ClientWidth = 840
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -15
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 18
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 840
    Height = 447
    Align = alClient
    TabOrder = 0
    ExplicitTop = -6
    ExplicitWidth = 750
    ExplicitHeight = 416
    DesignSize = (
      840
      447)
    object Label1: TLabel
      Left = 8
      Top = 8
      Width = 151
      Height = 18
      Caption = 'Condi'#231#227'o padr'#227'o (Fixa)'
    end
    object Label2: TLabel
      Left = 8
      Top = 159
      Width = 116
      Height = 18
      Caption = 'Condi'#231#227'o adicional'
    end
    object mmWherePadrao: TMemo
      Left = 8
      Top = 32
      Width = 819
      Height = 121
      Anchors = [akLeft, akTop, akRight]
      ReadOnly = True
      TabOrder = 0
      ExplicitWidth = 729
    end
    object mmWhereAdicional: TMemo
      Left = 8
      Top = 183
      Width = 819
      Height = 252
      Anchors = [akLeft, akTop, akRight, akBottom]
      TabOrder = 1
      ExplicitWidth = 729
      ExplicitHeight = 280
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 447
    Width = 840
    Height = 55
    Align = alBottom
    TabOrder = 1
    ExplicitTop = 475
    ExplicitWidth = 750
    object btnCancelar: TButton
      AlignWithMargins = True
      Left = 731
      Top = 6
      Width = 105
      Height = 43
      Margins.Top = 5
      Margins.Bottom = 5
      Align = alRight
      Caption = 'Cancelar'
      ModalResult = 2
      TabOrder = 0
      ExplicitLeft = 472
    end
    object btnConfirmar: TButton
      AlignWithMargins = True
      Left = 620
      Top = 6
      Width = 105
      Height = 43
      Margins.Top = 5
      Margins.Bottom = 5
      Align = alRight
      Caption = 'Confirmar'
      ModalResult = 1
      TabOrder = 1
      ExplicitLeft = 504
    end
  end
end
