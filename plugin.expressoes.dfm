object fmMontarExperssao: TfmMontarExperssao
  Left = 0
  Top = 0
  BorderIcons = []
  Caption = 'Montar Express'#227'o'
  ClientHeight = 545
  ClientWidth = 886
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  Position = poScreenCenter
  OnShow = FormShow
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 886
    Height = 504
    Align = alClient
    TabOrder = 0
    ExplicitWidth = 880
    ExplicitHeight = 495
    DesignSize = (
      886
      504)
    object Label1: TLabel
      Left = 24
      Top = 284
      Width = 48
      Height = 13
      Caption = 'Resultado'
    end
    object lbTextoSE1: TLabel
      Left = 24
      Top = 39
      Width = 175
      Height = 13
      Caption = 'Se o valor do campo %s for igual a..'
    end
    object lbTextoSE2: TLabel
      Left = 24
      Top = 85
      Width = 184
      Height = 13
      Caption = 'Ent'#227'o o campo %s receber'#225' o valor...'
    end
    object lbTextoSE3: TLabel
      Left = 24
      Top = 131
      Width = 224
      Height = 13
      Caption = 'Se n'#227'o, ent'#227'o o campo %s receber'#225' o valor...'
    end
    object lbTextoCASO1: TLabel
      Left = 450
      Top = 39
      Width = 191
      Height = 13
      Caption = 'Caso o valor do campo %s for igual a...'
    end
    object lbTextoCASO2: TLabel
      Left = 450
      Top = 85
      Width = 184
      Height = 13
      Caption = 'Ent'#227'o o campo %s receber'#225' o valor...'
    end
    object Label2: TLabel
      Left = 450
      Top = 235
      Width = 90
      Height = 13
      Caption = 'Tabela estrangeira'
    end
    object Label3: TLabel
      Left = 551
      Top = 235
      Width = 33
      Height = 13
      Caption = 'Campo'
    end
    object rbOpcaoIif: TRadioButton
      Left = 24
      Top = 16
      Width = 113
      Height = 17
      Caption = 'Condi'#231#227'o "SE"'
      TabOrder = 0
      OnClick = rbOpcaoIifClick
    end
    object rbOpcaoCase: TRadioButton
      Left = 450
      Top = 16
      Width = 113
      Height = 17
      Caption = 'Condi'#231#227'o "CASO"'
      TabOrder = 1
      OnClick = rbOpcaoIifClick
    end
    object mmResultado: TMemo
      Left = 24
      Top = 303
      Width = 827
      Height = 181
      Anchors = [akLeft, akTop, akRight, akBottom]
      TabOrder = 2
      ExplicitWidth = 821
      ExplicitHeight = 172
    end
    object edCondicao: TEdit
      Left = 24
      Top = 58
      Width = 121
      Height = 21
      TabOrder = 3
    end
    object edSEVerdadeiro: TEdit
      Left = 24
      Top = 104
      Width = 121
      Height = 21
      TabOrder = 4
    end
    object edSEFalso: TEdit
      Left = 24
      Top = 150
      Width = 121
      Height = 21
      TabOrder = 5
    end
    object btnGerarIF: TButton
      Left = 24
      Top = 177
      Width = 75
      Height = 25
      Caption = 'Gerar'
      TabOrder = 6
      OnClick = btnGerarIFClick
    end
    object edCasoWhen: TEdit
      Left = 450
      Top = 58
      Width = 121
      Height = 21
      TabOrder = 7
    end
    object edCasoThen: TEdit
      Left = 450
      Top = 104
      Width = 121
      Height = 21
      TabOrder = 8
    end
    object btnAdicionarCASE: TButton
      Left = 450
      Top = 131
      Width = 75
      Height = 25
      Caption = 'Adicionar'
      TabOrder = 9
      OnClick = btnAdicionarCASEClick
    end
    object btnLimparCase: TButton
      Left = 531
      Top = 131
      Width = 75
      Height = 25
      Caption = 'Limpar'
      TabOrder = 10
      OnClick = btnLimparCaseClick
    end
    object rbConverter: TRadioButton
      Left = 24
      Top = 208
      Width = 420
      Height = 17
      Caption = 'Converter campo %s para %s'
      TabOrder = 11
      OnClick = rbOpcaoIifClick
    end
    object rbValorPadrao: TRadioButton
      Left = 450
      Top = 162
      Width = 407
      Height = 17
      Caption = 'Informar valor padr'#227'o para o campo %s'
      TabOrder = 12
      OnClick = rbOpcaoIifClick
    end
    object edValorPadrao: TEdit
      Left = 450
      Top = 185
      Width = 135
      Height = 21
      TabOrder = 13
    end
    object btnGerarValorPadrao: TButton
      Left = 591
      Top = 184
      Width = 75
      Height = 25
      Caption = 'Gerar'
      TabOrder = 14
      OnClick = btnGerarValorPadraoClick
    end
    object btnGerarSQLConversao: TButton
      Left = 24
      Top = 230
      Width = 75
      Height = 25
      Caption = 'Gerar'
      TabOrder = 15
      OnClick = btnGerarSQLConversaoClick
    end
    object rbSelectFromTable: TRadioButton
      Left = 450
      Top = 212
      Width = 407
      Height = 17
      Caption = 'Selecionar campo de outra tabela (Migra'#231#227'o)'
      TabOrder = 16
      OnClick = rbOpcaoIifClick
    end
    object edTabelaEstrangeira: TEdit
      Left = 450
      Top = 258
      Width = 90
      Height = 21
      TabOrder = 17
    end
    object edCampoEstrangeiro: TEdit
      Left = 551
      Top = 258
      Width = 90
      Height = 21
      TabOrder = 18
    end
    object btnGerarSelectFromTable: TButton
      Left = 647
      Top = 256
      Width = 75
      Height = 25
      Caption = 'Gerar'
      TabOrder = 19
      OnClick = btnGerarSelectFromTableClick
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 504
    Width = 886
    Height = 41
    Align = alBottom
    TabOrder = 1
    ExplicitTop = 495
    ExplicitWidth = 880
    DesignSize = (
      886
      41)
    object btnOk: TButton
      Left = 712
      Top = 6
      Width = 75
      Height = 25
      Anchors = [akTop, akRight]
      Caption = 'Confirmar'
      ModalResult = 1
      TabOrder = 0
      ExplicitLeft = 706
    end
    object btnCancelar: TButton
      Left = 793
      Top = 6
      Width = 75
      Height = 25
      Anchors = [akTop, akRight]
      Caption = 'Cancelar'
      ModalResult = 2
      TabOrder = 1
      ExplicitLeft = 787
    end
  end
end
