object fmSelecionarTabelaJoin: TfmSelecionarTabelaJoin
  Left = 0
  Top = 0
  Caption = 'Selecionar Tabela de uni'#227'o'
  ClientHeight = 511
  ClientWidth = 951
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object pnlGridTabelas: TPanel
    Left = 0
    Top = 0
    Width = 385
    Height = 511
    Align = alLeft
    TabOrder = 0
    object grTabelasOrigem: TDBGrid
      AlignWithMargins = True
      Left = 4
      Top = 4
      Width = 377
      Height = 503
      Align = alClient
      DataSource = dsTabelasOrigem
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = []
      Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgTitleClick, dgTitleHotTrack]
      ParentFont = False
      TabOrder = 0
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -13
      TitleFont.Name = 'Tahoma'
      TitleFont.Style = []
    end
  end
  object pnlBackground: TPanel
    Left = 385
    Top = 0
    Width = 566
    Height = 511
    Align = alClient
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -15
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 1
    DesignSize = (
      566
      511)
    object Label1: TLabel
      Left = 16
      Top = 24
      Width = 208
      Height = 18
      Caption = 'Condi'#231#227'o de uni'#227'o entre tabelas'
    end
    object mmCondicao: TMemo
      Left = 16
      Top = 48
      Width = 529
      Height = 105
      Anchors = [akLeft, akTop, akRight]
      TabOrder = 0
    end
    object btnConfirmar: TButton
      Left = 16
      Top = 168
      Width = 98
      Height = 25
      Caption = 'Confirmar'
      TabOrder = 1
      OnClick = btnConfirmarClick
    end
    object btnCancelar: TButton
      Left = 136
      Top = 168
      Width = 98
      Height = 25
      Caption = 'Cancelar'
      TabOrder = 2
      OnClick = btnCancelarClick
    end
    object chkJoinObrigatorio: TCheckBox
      Left = 320
      Top = 25
      Width = 217
      Height = 17
      Caption = 'Uni'#227'o entre tabelas obrigatoria'
      TabOrder = 3
    end
  end
  object fmtTabelasOrigem: TFDMemTable
    FieldDefs = <>
    IndexDefs = <>
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired, uvAutoCommitUpdates]
    UpdateOptions.CheckRequired = False
    UpdateOptions.AutoCommitUpdates = True
    StoreDefs = True
    Left = 40
    Top = 128
    object fmtTabelasOrigemSEL: TIntegerField
      Alignment = taCenter
      DefaultExpression = '0'
      DisplayLabel = '[  ]'
      DisplayWidth = 3
      FieldName = 'SEL'
      Visible = False
    end
    object fmtTabelasOrigemORDEM: TIntegerField
      DisplayLabel = '###'
      DisplayWidth = 3
      FieldName = 'ORDEM'
      Visible = False
    end
    object fmtTabelasOrigemDESCRICAO: TStringField
      DisplayLabel = 'Tabela origem'
      FieldName = 'DESCRICAO'
      Size = 50
    end
    object fmtTabelasOrigemARQUIVO: TStringField
      FieldName = 'ARQUIVO'
      Visible = False
      Size = 500
    end
  end
  object dsTabelasOrigem: TDataSource
    AutoEdit = False
    DataSet = fmtTabelasOrigem
    OnDataChange = dsTabelasOrigemDataChange
    Left = 64
    Top = 224
  end
end
