object fmSchemas: TfmSchemas
  Left = 0
  Top = 0
  Caption = 'Schema de tabelas'
  ClientHeight = 639
  ClientWidth = 1049
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  WindowState = wsMaximized
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 16
  object pcPrincipal: TPageControl
    Left = 0
    Top = 0
    Width = 1049
    Height = 639
    ActivePage = tsCampos
    Align = alClient
    TabOrder = 0
    object tsTabelas: TTabSheet
      Caption = 'tsTabelas'
      TabVisible = False
      object Panel1: TPanel
        Left = 0
        Top = 0
        Width = 1041
        Height = 575
        Align = alClient
        TabOrder = 0
        object pnlTabelaOrigem: TPanel
          AlignWithMargins = True
          Left = 4
          Top = 4
          Width = 517
          Height = 567
          Align = alLeft
          BevelKind = bkFlat
          BevelOuter = bvNone
          Caption = 'Origem'
          Color = clTeal
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clHighlightText
          Font.Height = -13
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentBackground = False
          ParentFont = False
          TabOrder = 0
          object grTabelasOrigem: TDBGrid
            AlignWithMargins = True
            Left = 3
            Top = 3
            Width = 507
            Height = 557
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
        object pnlTabelaDestino: TPanel
          AlignWithMargins = True
          Left = 527
          Top = 4
          Width = 510
          Height = 567
          Align = alClient
          BevelKind = bkFlat
          BevelOuter = bvNone
          Caption = 'Destino'
          Color = clSkyBlue
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clHighlightText
          Font.Height = -13
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentBackground = False
          ParentFont = False
          TabOrder = 1
          object grTabelasDestino: TDBGrid
            AlignWithMargins = True
            Left = 3
            Top = 3
            Width = 500
            Height = 557
            Align = alClient
            Color = clSkyBlue
            DataSource = dsTabelasDestino
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
      end
      object Panel2: TPanel
        Left = 0
        Top = 575
        Width = 1041
        Height = 54
        Align = alBottom
        TabOrder = 1
        object btnCriarLink: TButton
          AlignWithMargins = True
          Left = 4
          Top = 4
          Width = 128
          Height = 46
          Align = alLeft
          Caption = 'Criar link'
          TabOrder = 0
          OnClick = btnCriarLinkClick
        end
      end
    end
    object tsCampos: TTabSheet
      Caption = 'tsCampos'
      ImageIndex = 1
      TabVisible = False
      object pnlCamposOrigem: TPanel
        Left = 0
        Top = 0
        Width = 265
        Height = 629
        Align = alLeft
        BevelKind = bkFlat
        BevelOuter = bvNone
        Color = clTeal
        ParentBackground = False
        TabOrder = 0
        object grCamposOrigem: TDBGrid
          AlignWithMargins = True
          Left = 3
          Top = 31
          Width = 255
          Height = 591
          Align = alClient
          Color = clTeal
          DataSource = dsCamposOrigem
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
        object btnJoinTabela: TButton
          AlignWithMargins = True
          Left = 3
          Top = 3
          Width = 255
          Height = 25
          Margins.Bottom = 0
          Align = alTop
          Caption = 'Unir tabela '#224' tabela de origem'
          TabOrder = 1
          OnClick = btnJoinTabelaClick
        end
      end
      object pnlCriarLink: TPanel
        Left = 265
        Top = 0
        Width = 212
        Height = 629
        Align = alLeft
        ParentBackground = False
        TabOrder = 1
        DesignSize = (
          212
          629)
        object Label13: TLabel
          Left = 16
          Top = 76
          Width = 30
          Height = 16
          Caption = 'Tipo:'
        end
        object Label14: TLabel
          Left = 16
          Top = 93
          Width = 59
          Height = 16
          Caption = 'Tamanho:'
        end
        object Label15: TLabel
          Left = 16
          Top = 111
          Width = 92
          Height = 16
          Caption = 'Chave primaria:'
        end
        object Label16: TLabel
          Left = 16
          Top = 128
          Width = 109
          Height = 16
          Caption = 'Chave estrangeira:'
        end
        object Label17: TLabel
          Left = 16
          Top = 146
          Width = 113
          Height = 16
          Caption = 'Tabela estrangeira:'
        end
        object Label18: TLabel
          Left = 16
          Top = 180
          Width = 82
          Height = 16
          Caption = 'Permite vazio:'
        end
        object Label19: TLabel
          Left = 16
          Top = 198
          Width = 79
          Height = 16
          Caption = 'Valor padr'#227'o:'
        end
        object Label20: TLabel
          Left = 8
          Top = 25
          Width = 55
          Height = 18
          Caption = 'Origem'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clTeal
          Font.Height = -15
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object txTipoOrigem: TDBText
          Left = 52
          Top = 76
          Width = 157
          Height = 17
          DataField = 'TIPO'
          DataSource = dsCamposOrigem
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object txTabelaEstrangeiraOrigem: TDBText
          Left = 8
          Top = 162
          Width = 201
          Height = 17
          DataField = 'CHAVEESTRANGEIRANOMETABELA'
          DataSource = dsCamposOrigem
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object txCampoOrigem: TDBText
          Left = 8
          Top = 57
          Width = 201
          Height = 16
          DataField = 'CAMPO'
          DataSource = dsCamposOrigem
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object Label21: TLabel
          Left = 16
          Top = 43
          Width = 45
          Height = 16
          Caption = 'Campo:'
        end
        object Label22: TLabel
          Left = 8
          Top = 239
          Width = 57
          Height = 18
          Caption = 'Destino'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clHighlight
          Font.Height = -15
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object txTamanhoOrigem: TDBText
          Left = 81
          Top = 93
          Width = 128
          Height = 17
          DataField = 'TAMANHO'
          DataSource = dsCamposOrigem
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object txChavePrimariaOrigem: TDBText
          Left = 114
          Top = 111
          Width = 95
          Height = 17
          DataField = 'CHAVEPRIMARIA'
          DataSource = dsCamposOrigem
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object txChaveEstrangeiraOrigem: TDBText
          Left = 131
          Top = 129
          Width = 78
          Height = 17
          DataField = 'CHAVEESTRANGEIRA'
          DataSource = dsCamposOrigem
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object txPermiteNuloOrigem: TDBText
          Left = 104
          Top = 180
          Width = 105
          Height = 17
          DataField = 'PERMITENULO'
          DataSource = dsCamposOrigem
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object txValorPadraoOrigem: TDBText
          Left = 16
          Top = 216
          Width = 193
          Height = 17
          DataField = 'VALORPADRAO'
          DataSource = dsCamposOrigem
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object txValorPadraoDestino: TDBText
          Left = 16
          Top = 427
          Width = 193
          Height = 17
          DataField = 'VALORPADRAO'
          DataSource = dsCamposDestino
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object Label23: TLabel
          Left = 16
          Top = 409
          Width = 79
          Height = 16
          Caption = 'Valor padr'#227'o:'
        end
        object Label24: TLabel
          Left = 16
          Top = 391
          Width = 82
          Height = 16
          Caption = 'Permite vazio:'
        end
        object txPermiteNuloDestino: TDBText
          Left = 104
          Top = 391
          Width = 105
          Height = 17
          DataField = 'PERMITENULO'
          DataSource = dsCamposDestino
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object txTabelaEstrangeira: TDBText
          Left = 8
          Top = 373
          Width = 201
          Height = 17
          DataField = 'CHAVEESTRANGEIRANOMETABELA'
          DataSource = dsCamposDestino
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object Label25: TLabel
          Left = 16
          Top = 357
          Width = 113
          Height = 16
          Caption = 'Tabela estrangeira:'
        end
        object txChaveEstrangeiraDestino: TDBText
          Left = 131
          Top = 340
          Width = 78
          Height = 17
          DataField = 'CHAVEESTRANGEIRA'
          DataSource = dsCamposDestino
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object Label26: TLabel
          Left = 16
          Top = 339
          Width = 109
          Height = 16
          Caption = 'Chave estrangeira:'
        end
        object txChavePrimariaDestino: TDBText
          Left = 114
          Top = 322
          Width = 95
          Height = 17
          DataField = 'CHAVEPRIMARIA'
          DataSource = dsCamposDestino
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object Label27: TLabel
          Left = 16
          Top = 322
          Width = 92
          Height = 16
          Caption = 'Chave primaria:'
        end
        object txTamanhoDestino: TDBText
          Left = 81
          Top = 304
          Width = 128
          Height = 17
          DataField = 'TAMANHO'
          DataSource = dsCamposDestino
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object Label28: TLabel
          Left = 16
          Top = 304
          Width = 59
          Height = 16
          Caption = 'Tamanho:'
        end
        object txTipoDestino: TDBText
          Left = 52
          Top = 287
          Width = 157
          Height = 17
          DataField = 'TIPO'
          DataSource = dsCamposDestino
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object Label29: TLabel
          Left = 16
          Top = 287
          Width = 30
          Height = 16
          Caption = 'Tipo:'
        end
        object txCampoDestino: TDBText
          Left = 8
          Top = 270
          Width = 201
          Height = 16
          DataField = 'CAMPO'
          DataSource = dsCamposDestino
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object Label30: TLabel
          Left = 16
          Top = 254
          Width = 45
          Height = 16
          Caption = 'Campo:'
        end
        object Label31: TLabel
          Left = 8
          Top = 450
          Width = 86
          Height = 16
          Caption = 'Express'#227'o livre'
        end
        object Label32: TLabel
          Left = 100
          Top = 450
          Width = 19
          Height = 16
          Cursor = crHelp
          Caption = '(?)'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object chkSemCampoOrigem: TCheckBox
          Left = 8
          Top = 5
          Width = 153
          Height = 17
          Caption = 'Sem campo de origem'
          TabOrder = 0
        end
        object mmExpressaoLivre: TMemo
          Left = 8
          Top = 472
          Width = 193
          Height = 118
          Anchors = [akLeft, akTop, akBottom]
          TabOrder = 1
        end
        object btnAdicionarLink: TButton
          Left = 7
          Top = 596
          Width = 194
          Height = 27
          Anchors = [akLeft, akBottom]
          Caption = 'Criar link'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clGreen
          Font.Height = -13
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 2
          StyleElements = []
          OnClick = btnAdicionarLinkClick
        end
        object btnGerarExpressao: TButton
          Left = 125
          Top = 445
          Width = 76
          Height = 27
          Caption = 'Gerar'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clGreen
          Font.Height = -13
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 3
          StyleElements = []
          OnClick = btnGerarExpressaoClick
        end
      end
      object pnlCamposDestino: TPanel
        Left = 477
        Top = 0
        Width = 265
        Height = 629
        Align = alLeft
        BevelKind = bkFlat
        BevelOuter = bvNone
        Color = clSkyBlue
        ParentBackground = False
        TabOrder = 2
        object grCamposDestino: TDBGrid
          AlignWithMargins = True
          Left = 3
          Top = 3
          Width = 255
          Height = 619
          Align = alClient
          DataSource = dsCamposDestino
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
      object pnlListaLinksCriados: TPanel
        Left = 742
        Top = 0
        Width = 299
        Height = 629
        Align = alClient
        BevelKind = bkFlat
        BevelOuter = bvNone
        ParentBackground = False
        TabOrder = 3
        object lbListaCamposLink: TListBox
          AlignWithMargins = True
          Left = 3
          Top = 3
          Width = 289
          Height = 554
          Align = alClient
          TabOrder = 0
        end
        object Panel3: TPanel
          Left = 0
          Top = 560
          Width = 295
          Height = 65
          Align = alBottom
          BevelOuter = bvNone
          TabOrder = 1
          object btnSalvarCamposLinks: TButton
            AlignWithMargins = True
            Left = 3
            Top = 29
            Width = 75
            Height = 33
            Align = alLeft
            Caption = 'Salvar'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -13
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
            TabOrder = 0
            OnClick = btnSalvarCamposLinksClick
          end
          object btnAlterarWhere: TButton
            AlignWithMargins = True
            Left = 165
            Top = 29
            Width = 75
            Height = 33
            Align = alLeft
            Caption = '"Where"'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -13
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
            TabOrder = 1
            OnClick = btnAlterarWhereClick
          end
          object btnRemoverLinkCampo: TcxButton
            AlignWithMargins = True
            Left = 217
            Top = 29
            Width = 75
            Height = 33
            Align = alRight
            Caption = 'Remover'
            Colors.Default = clRed
            Colors.DefaultText = clRed
            Colors.Normal = clRed
            Colors.NormalText = clRed
            Colors.Hot = clRed
            Colors.HotText = clRed
            Colors.Pressed = clRed
            Colors.PressedText = clRed
            TabOrder = 2
            OnClick = btnRemoverLinkCampoClick
          end
          object btnCancelaCamposLink: TcxButton
            AlignWithMargins = True
            Left = 84
            Top = 29
            Width = 75
            Height = 33
            Align = alLeft
            Caption = 'Cancelar'
            Colors.Default = clRed
            Colors.DefaultText = clRed
            Colors.Normal = clRed
            Colors.NormalText = clRed
            Colors.Hot = clRed
            Colors.HotText = clRed
            Colors.Pressed = clRed
            Colors.PressedText = clRed
            TabOrder = 3
            OnClick = btnCancelaCamposLinkClick
          end
          object chkSchemaUpdate: TCheckBox
            AlignWithMargins = True
            Left = 3
            Top = 3
            Width = 289
            Height = 20
            Align = alTop
            Caption = 'Schema de atualiza'#231#227'o'
            Constraints.MaxHeight = 20
            TabOrder = 4
          end
        end
      end
    end
  end
  object dsTabelasOrigem: TDataSource
    AutoEdit = False
    DataSet = fmtTabelasOrigem
    Left = 160
    Top = 328
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
    Left = 62
    Top = 329
    object fmtTabelasOrigemSEL: TIntegerField
      Alignment = taCenter
      DefaultExpression = '0'
      DisplayLabel = '[  ]'
      DisplayWidth = 3
      FieldName = 'SEL'
      OnGetText = fmtTabelasOrigemSELGetText
    end
    object fmtTabelasOrigemORDEM: TIntegerField
      DisplayLabel = '###'
      DisplayWidth = 3
      FieldName = 'ORDEM'
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
  object dsTabelasDestino: TDataSource
    AutoEdit = False
    DataSet = fmtTabelasDestino
    Left = 672
    Top = 328
  end
  object fmtTabelasDestino: TFDMemTable
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
    Left = 576
    Top = 328
    object fmtTabelasDestinoSEL: TIntegerField
      Alignment = taCenter
      DefaultExpression = '0'
      DisplayLabel = '[  ]'
      DisplayWidth = 3
      FieldName = 'SEL'
      OnGetText = fmtTabelasDestinoSELGetText
    end
    object fmtTabelasDestinoORDEM: TIntegerField
      DisplayLabel = '###'
      DisplayWidth = 3
      FieldName = 'ORDEM'
    end
    object fmtTabelasDestinoDESCRICAO: TStringField
      DisplayLabel = 'Tabela Destino'
      FieldName = 'DESCRICAO'
      Size = 50
    end
    object fmtTabelasDestinoARQUIVO: TStringField
      FieldName = 'ARQUIVO'
      Visible = False
      Size = 500
    end
  end
  object fmtCamposOrigem: TFDMemTable
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
    Left = 104
    Top = 174
    object fmtCamposOrigemCAMPO: TStringField
      DisplayLabel = 'Campo Origem'
      FieldName = 'CAMPO'
      Size = 50
    end
    object fmtCamposOrigemTIPO: TIntegerField
      FieldName = 'TIPO'
      Visible = False
      OnGetText = fmtCamposOrigemTIPOGetText
    end
    object fmtCamposOrigemTAMANHO: TIntegerField
      FieldName = 'TAMANHO'
      Visible = False
    end
    object fmtCamposOrigemCHAVEPRIMARIA: TStringField
      FieldName = 'CHAVEPRIMARIA'
      Visible = False
      Size = 1
    end
    object fmtCamposOrigemCHAVEESTRANGEIRA: TStringField
      FieldName = 'CHAVEESTRANGEIRA'
      Visible = False
      Size = 1
    end
    object fmtCamposOrigemCHAVEESTRANGEIRANOMETABELA: TStringField
      FieldName = 'CHAVEESTRANGEIRANOMETABELA'
      Visible = False
      Size = 50
    end
    object fmtCamposOrigemPERMITENULO: TStringField
      FieldName = 'PERMITENULO'
      Visible = False
      Size = 1
    end
    object fmtCamposOrigemVALORPADRAO: TStringField
      FieldName = 'VALORPADRAO'
      Visible = False
      Size = 50
    end
    object fmtCamposOrigemUSADO: TIntegerField
      DefaultExpression = '0'
      FieldName = 'USADO'
      Visible = False
    end
  end
  object dsCamposOrigem: TDataSource
    AutoEdit = False
    DataSet = fmtCamposOrigem
    Left = 104
    Top = 224
  end
  object fmtCamposDestino: TFDMemTable
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired, uvAutoCommitUpdates]
    UpdateOptions.CheckRequired = False
    UpdateOptions.AutoCommitUpdates = True
    Left = 608
    Top = 184
    object fmtCamposDestinoCAMPO: TStringField
      DisplayLabel = 'Campo Destino'
      FieldName = 'CAMPO'
      Size = 50
    end
    object fmtCamposDestinoTIPO: TIntegerField
      FieldName = 'TIPO'
      Visible = False
      OnGetText = fmtCamposDestinoTIPOGetText
    end
    object fmtCamposDestinoTAMANHO: TIntegerField
      FieldName = 'TAMANHO'
      Visible = False
    end
    object fmtCamposDestinoCHAVEPRIMARIA: TStringField
      FieldName = 'CHAVEPRIMARIA'
      Visible = False
      Size = 1
    end
    object fmtCamposDestinoCHAVEESTRANGEIRA: TStringField
      FieldName = 'CHAVEESTRANGEIRA'
      Visible = False
      Size = 1
    end
    object fmtCamposDestinoCHAVEESTRANGEIRANOMETABELA: TStringField
      FieldName = 'CHAVEESTRANGEIRANOMETABELA'
      Visible = False
      Size = 50
    end
    object fmtCamposDestinoPERMITENULO: TStringField
      FieldName = 'PERMITENULO'
      Size = 1
    end
    object fmtCamposDestinoVALORPADRAO: TStringField
      FieldName = 'VALORPADRAO'
      Visible = False
      Size = 50
    end
    object fmtCamposDestinoUSADO: TIntegerField
      DefaultExpression = '0'
      FieldName = 'USADO'
    end
  end
  object dsCamposDestino: TDataSource
    AutoEdit = False
    DataSet = fmtCamposDestino
    Left = 608
    Top = 232
  end
end
