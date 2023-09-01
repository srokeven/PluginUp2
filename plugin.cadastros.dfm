object fmCadastros: TfmCadastros
  Left = 0
  Top = 0
  Caption = 'Cadastros'
  ClientHeight = 588
  ClientWidth = 1186
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'Tahoma'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  WindowState = wsMaximized
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnKeyDown = FormKeyDown
  PixelsPerInch = 96
  TextHeight = 16
  object pnlSide: TPanel
    Left = 0
    Top = 0
    Width = 87
    Height = 588
    Align = alLeft
    BevelOuter = bvNone
    TabOrder = 0
    object btnCadBancoDados: TBitBtn
      AlignWithMargins = True
      Left = 3
      Top = 3
      Width = 81
      Height = 65
      Align = alTop
      Caption = '1. Banco de Dados'
      TabOrder = 0
      WordWrap = True
      OnClick = btnCadBancoDadosClick
    end
    object btnRegTabelas: TBitBtn
      AlignWithMargins = True
      Left = 3
      Top = 74
      Width = 81
      Height = 63
      Align = alTop
      Caption = '2. Registros de schemas'
      TabOrder = 1
      WordWrap = True
      OnClick = btnRegTabelasClick
    end
  end
  object pcPrincipal: TPageControl
    Left = 87
    Top = 0
    Width = 1099
    Height = 588
    ActivePage = tsCadLinksCampos
    Align = alClient
    TabOrder = 1
    object tsCadBancoDados: TTabSheet
      Caption = 'tsCadBancoDados'
      TabVisible = False
      DesignSize = (
        1091
        578)
      object pnlEdicaoBancos: TPanel
        Left = 699
        Top = -1
        Width = 399
        Height = 578
        Anchors = [akTop, akRight, akBottom]
        BevelOuter = bvNone
        Color = clSilver
        ParentBackground = False
        TabOrder = 0
        Visible = False
        object Label1: TLabel
          Left = 16
          Top = 24
          Width = 33
          Height = 16
          Caption = 'Nome'
          FocusControl = edNome
        end
        object Label2: TLabel
          Left = 16
          Top = 120
          Width = 48
          Height = 16
          Caption = 'Servidor'
          FocusControl = edServidor
        end
        object Label3: TLabel
          Left = 16
          Top = 168
          Width = 30
          Height = 16
          Caption = 'Porta'
          FocusControl = edPorta
        end
        object Label4: TLabel
          Left = 16
          Top = 216
          Width = 162
          Height = 16
          Caption = 'Caminho do banco de dados'
          FocusControl = edCaminho
        end
        object Label5: TLabel
          Left = 16
          Top = 264
          Width = 43
          Height = 16
          Caption = 'Usu'#225'rio'
          FocusControl = edUsuario
        end
        object Label6: TLabel
          Left = 16
          Top = 312
          Width = 36
          Height = 16
          Caption = 'Senha'
          FocusControl = edSenha
        end
        object Label7: TLabel
          Left = 16
          Top = 360
          Width = 135
          Height = 16
          Caption = 'Tipo de direcionamento'
        end
        object Label9: TLabel
          Left = 16
          Top = 71
          Width = 46
          Height = 16
          Caption = 'Sistema'
        end
        object btnProcurarBanco: TSpeedButton
          Left = 351
          Top = 232
          Width = 23
          Height = 22
          Caption = '...'
          OnClick = btnProcurarBancoClick
        end
        object edNome: TDBEdit
          Left = 16
          Top = 41
          Width = 329
          Height = 24
          DataField = 'NOME'
          DataSource = dsBancosDeDados
          TabOrder = 0
        end
        object edServidor: TDBEdit
          Left = 16
          Top = 136
          Width = 145
          Height = 24
          DataField = 'SERVIDOR'
          DataSource = dsBancosDeDados
          TabOrder = 2
        end
        object edPorta: TDBEdit
          Left = 16
          Top = 184
          Width = 145
          Height = 24
          DataField = 'PORTA'
          DataSource = dsBancosDeDados
          TabOrder = 3
        end
        object edCaminho: TDBEdit
          Left = 16
          Top = 232
          Width = 329
          Height = 24
          DataField = 'CAMINHO'
          DataSource = dsBancosDeDados
          TabOrder = 4
        end
        object edUsuario: TDBEdit
          Left = 16
          Top = 280
          Width = 145
          Height = 24
          DataField = 'USUARIO'
          DataSource = dsBancosDeDados
          TabOrder = 5
        end
        object edSenha: TDBEdit
          Left = 16
          Top = 330
          Width = 145
          Height = 24
          DataField = 'SENHA'
          DataSource = dsBancosDeDados
          TabOrder = 6
        end
        object btnSalvarDB: TButton
          Left = 16
          Top = 464
          Width = 75
          Height = 25
          Caption = 'Salvar'
          TabOrder = 10
          OnClick = btnSalvarDBClick
        end
        object cbTipoDB: TJvDBComboBox
          Left = 16
          Top = 378
          Width = 145
          Height = 24
          DataField = 'TIPO'
          DataSource = dsBancosDeDados
          Items.Strings = (
            'Origem'
            'Destino')
          TabOrder = 8
          UpdateFieldImmediatelly = True
          Values.Strings = (
            '0'
            '1')
          ListSettings.OutfilteredValueFont.Charset = DEFAULT_CHARSET
          ListSettings.OutfilteredValueFont.Color = clRed
          ListSettings.OutfilteredValueFont.Height = -11
          ListSettings.OutfilteredValueFont.Name = 'Tahoma'
          ListSettings.OutfilteredValueFont.Style = []
        end
        object btnTestarBancoDados: TButton
          Left = 175
          Top = 330
          Width = 122
          Height = 25
          Caption = 'Testar conex'#227'o'
          TabOrder = 7
          OnClick = btnTestarBancoDadosClick
        end
        object cbSistema: TJvDBComboBox
          Left = 16
          Top = 90
          Width = 145
          Height = 24
          DataField = 'SISTEMA'
          DataSource = dsBancosDeDados
          Items.Strings = (
            'MasterVendas'
            'Up2 PDV'
            'Outros sistemas')
          TabOrder = 1
          Values.Strings = (
            'MV'
            'PDV'
            'ALT')
          ListSettings.OutfilteredValueFont.Charset = DEFAULT_CHARSET
          ListSettings.OutfilteredValueFont.Color = clRed
          ListSettings.OutfilteredValueFont.Height = -11
          ListSettings.OutfilteredValueFont.Name = 'Tahoma'
          ListSettings.OutfilteredValueFont.Style = []
        end
        object btnZerarDatas: TButton
          Left = 16
          Top = 423
          Width = 145
          Height = 25
          Hint = 
            'Ao zerar as datas dos cadastros o sistema entender'#225' que deverar ' +
            'enviar todos os cadastros novamente'
          Caption = 'Zerar datas'
          DropDownMenu = popZerarTabelas
          ParentShowHint = False
          ShowHint = True
          Style = bsSplitButton
          TabOrder = 9
          OnClick = btnZerarDatasClick
        end
        object btnCancelaDB: TcxButton
          Left = 97
          Top = 464
          Width = 75
          Height = 25
          Caption = 'Cancelar'
          Colors.Default = clRed
          Colors.DefaultText = clRed
          Colors.Normal = clRed
          Colors.NormalText = clRed
          Colors.Hot = clRed
          Colors.HotText = clRed
          Colors.Pressed = clRed
          Colors.PressedText = clRed
          TabOrder = 11
          OnClick = btnCancelaDBClick
        end
      end
      object pnlListaBancos: TPanel
        Left = -1
        Top = 0
        Width = 694
        Height = 578
        Anchors = [akLeft, akTop, akRight, akBottom]
        BevelOuter = bvNone
        Color = clInfoBk
        ParentBackground = False
        TabOrder = 1
        object grBancoDados: TDBGrid
          AlignWithMargins = True
          Left = 3
          Top = 3
          Width = 688
          Height = 525
          Align = alClient
          BorderStyle = bsNone
          DataSource = dsBancosDeDados
          Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgTitleClick, dgTitleHotTrack]
          TabOrder = 0
          TitleFont.Charset = DEFAULT_CHARSET
          TitleFont.Color = clWindowText
          TitleFont.Height = -13
          TitleFont.Name = 'Tahoma'
          TitleFont.Style = []
        end
        object pnlButtonsCadBancoDados: TPanel
          AlignWithMargins = True
          Left = 3
          Top = 534
          Width = 688
          Height = 41
          Align = alBottom
          BevelKind = bkFlat
          BevelOuter = bvNone
          TabOrder = 1
          object btnNovoDB: TButton
            AlignWithMargins = True
            Left = 3
            Top = 3
            Width = 75
            Height = 31
            Align = alLeft
            Caption = 'Novo'
            TabOrder = 0
            OnClick = btnNovoDBClick
          end
          object btnEditarDB: TButton
            AlignWithMargins = True
            Left = 84
            Top = 3
            Width = 75
            Height = 31
            Align = alLeft
            Caption = 'Editar'
            TabOrder = 1
            OnClick = btnEditarDBClick
          end
          object btnTabelasDB: TButton
            AlignWithMargins = True
            Left = 246
            Top = 3
            Width = 75
            Height = 31
            Align = alLeft
            Caption = 'Tabelas'
            TabOrder = 2
            OnClick = btnTabelasDBClick
          end
          object btnDeletarDB: TcxButton
            AlignWithMargins = True
            Left = 165
            Top = 3
            Width = 75
            Height = 31
            Align = alLeft
            Caption = 'Deletar'
            Colors.Default = clRed
            Colors.DefaultText = clRed
            Colors.Normal = clRed
            Colors.NormalText = clRed
            Colors.Hot = clRed
            Colors.HotText = clRed
            Colors.Pressed = clRed
            Colors.PressedText = clRed
            TabOrder = 3
            OnClick = btnDeletarDBClick
          end
        end
      end
    end
    object tsCadTabelas: TTabSheet
      Caption = 'tsCadTabelas'
      ImageIndex = 1
      TabVisible = False
      DesignSize = (
        1091
        578)
      object pnlTabelasSelecionadas: TPanel
        Left = 692
        Top = 0
        Width = 399
        Height = 578
        Anchors = [akTop, akRight, akBottom]
        BevelOuter = bvNone
        Color = clSilver
        ParentBackground = False
        TabOrder = 0
        object Label8: TLabel
          AlignWithMargins = True
          Left = 3
          Top = 3
          Width = 393
          Height = 16
          Align = alTop
          Caption = 'Tabelas selecionadas'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clGreen
          Font.Height = -13
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
          ExplicitWidth = 136
        end
        object lbListaTabelasSelecionadas: TListBox
          AlignWithMargins = True
          Left = 3
          Top = 25
          Width = 393
          Height = 503
          Align = alClient
          BevelInner = bvNone
          BevelOuter = bvNone
          TabOrder = 0
        end
        object pnlButtonsTabelasSelecionadas: TPanel
          AlignWithMargins = True
          Left = 3
          Top = 534
          Width = 393
          Height = 41
          Align = alBottom
          BevelKind = bkFlat
          BevelOuter = bvNone
          TabOrder = 1
          object btnSalvarTabelas: TButton
            AlignWithMargins = True
            Left = 3
            Top = 3
            Width = 75
            Height = 31
            Align = alLeft
            Caption = 'Salvar'
            TabOrder = 0
            OnClick = btnSalvarTabelasClick
          end
          object btnRemoverTabelas: TcxButton
            AlignWithMargins = True
            Left = 311
            Top = 3
            Width = 75
            Height = 31
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
            TabOrder = 1
            OnClick = btnRemoverTabelasClick
            ExplicitLeft = 84
          end
          object btnVoltarTabela: TButton
            AlignWithMargins = True
            Left = 84
            Top = 3
            Width = 75
            Height = 31
            Align = alLeft
            Caption = 'Cancelar'
            TabOrder = 2
            OnClick = btnVoltarTabelaClick
            ExplicitLeft = 603
          end
        end
      end
      object pnlListaTabelas: TPanel
        Left = 0
        Top = 0
        Width = 691
        Height = 578
        Anchors = [akLeft, akTop, akRight, akBottom]
        BevelOuter = bvNone
        Color = clInfoBk
        ParentBackground = False
        TabOrder = 1
        object grTabelas: TDBGrid
          AlignWithMargins = True
          Left = 3
          Top = 3
          Width = 685
          Height = 525
          Align = alClient
          BorderStyle = bsNone
          DataSource = dsTabelas
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
        object pnlButtonsTabelas: TPanel
          AlignWithMargins = True
          Left = 3
          Top = 534
          Width = 685
          Height = 41
          Align = alBottom
          BevelKind = bkFlat
          BevelOuter = bvNone
          TabOrder = 1
          object btnSelecionarTabela: TButton
            AlignWithMargins = True
            Left = 3
            Top = 3
            Width = 75
            Height = 31
            Align = alLeft
            Caption = 'Selecionar'
            TabOrder = 0
            OnClick = btnSelecionarTabelaClick
          end
        end
      end
    end
    object tsCadSchemas: TTabSheet
      Caption = 'tsCadSchemas'
      ImageIndex = 2
      TabVisible = False
      DesignSize = (
        1091
        578)
      object pnlEditsSchemas: TPanel
        Left = 636
        Top = 0
        Width = 455
        Height = 578
        Anchors = [akTop, akRight, akBottom]
        BevelOuter = bvNone
        Color = clSilver
        ParentBackground = False
        TabOrder = 0
        Visible = False
        DesignSize = (
          455
          578)
        object Label10: TLabel
          Left = 16
          Top = 6
          Width = 154
          Height = 16
          Caption = 'Banco de dados de Origem'
          FocusControl = edNome
        end
        object Label11: TLabel
          Left = 16
          Top = 162
          Width = 154
          Height = 16
          Caption = 'Banco de dados de Destino'
          FocusControl = edNome
        end
        object Label12: TLabel
          Left = 16
          Top = 318
          Width = 45
          Height = 16
          Caption = 'Tabelas'
          FocusControl = edNome
        end
        object lbSelecionarArquivoOrigem: TLabel
          Left = 16
          Top = 140
          Width = 120
          Height = 16
          Cursor = crHandPoint
          Caption = 'Selecionar arquivo'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clHighlight
          Font.Height = -13
          Font.Name = 'Tahoma'
          Font.Style = [fsBold, fsUnderline]
          ParentFont = False
          OnClick = lbSelecionarArquivoOrigemClick
        end
        object lbSelecionarArquivoDestino: TLabel
          Left = 16
          Top = 296
          Width = 120
          Height = 16
          Cursor = crHandPoint
          Caption = 'Selecionar arquivo'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clHighlight
          Font.Height = -13
          Font.Name = 'Tahoma'
          Font.Style = [fsBold, fsUnderline]
          ParentFont = False
          OnClick = lbSelecionarArquivoDestinoClick
        end
        object lbCriarLinks: TLabel
          Left = 16
          Top = 517
          Width = 135
          Height = 16
          Cursor = crHandPoint
          Anchors = [akLeft, akBottom]
          Caption = 'Criar links de tabelas'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clHighlight
          Font.Height = -13
          Font.Name = 'Tahoma'
          Font.Style = [fsBold, fsUnderline]
          ParentFont = False
          OnClick = lbCriarLinksClick
          ExplicitTop = 496
        end
        object btnSalvarSchema: TButton
          Left = 16
          Top = 539
          Width = 82
          Height = 33
          Anchors = [akLeft, akBottom]
          Caption = 'Salvar'
          TabOrder = 0
          OnClick = btnSalvarSchemaClick
        end
        object mmBancoOrigem: TMemo
          Left = 16
          Top = 28
          Width = 425
          Height = 109
          Color = clInfoBk
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'JetBrains Mono NL SemiBold'
          Font.Style = []
          Lines.Strings = (
            'Selecione o arquivo'
            'do banco de Dados'
            ' |'
            '\|/'
            ' v')
          ParentFont = False
          ReadOnly = True
          TabOrder = 1
        end
        object mmBancoDestino: TMemo
          Left = 16
          Top = 184
          Width = 425
          Height = 109
          Color = clInfoBk
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'JetBrains Mono NL SemiBold'
          Font.Style = []
          Lines.Strings = (
            'Selecione o arquivo'
            'do banco de Dados'
            ' |'
            '\|/'
            ' v')
          ParentFont = False
          ReadOnly = True
          TabOrder = 2
        end
        object mmTabelasSchema: TMemo
          Left = 16
          Top = 340
          Width = 425
          Height = 171
          Anchors = [akLeft, akTop, akBottom]
          Color = clInfoBk
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'JetBrains Mono NL SemiBold'
          Font.Style = []
          Lines.Strings = (
            'Selecione o arquivo'
            'do banco de Dados'
            ' |'
            '\|/'
            ' v')
          ParentFont = False
          ReadOnly = True
          TabOrder = 3
        end
        object btnCancelaSchema: TcxButton
          Left = 104
          Top = 539
          Width = 81
          Height = 33
          Anchors = [akLeft, akBottom]
          Caption = 'Cancelar'
          Colors.Default = clRed
          Colors.DefaultText = clRed
          Colors.Normal = clRed
          Colors.NormalText = clRed
          Colors.Hot = clRed
          Colors.HotText = clRed
          Colors.Pressed = clRed
          Colors.PressedText = clRed
          TabOrder = 4
          OnClick = btnCancelaSchemaClick
        end
      end
      object pnlListaSchemas: TPanel
        Left = -1
        Top = -1
        Width = 634
        Height = 578
        Anchors = [akLeft, akTop, akRight, akBottom]
        BevelOuter = bvNone
        Color = clInfoBk
        ParentBackground = False
        TabOrder = 1
        object grListaSchemas: TDBGrid
          AlignWithMargins = True
          Left = 3
          Top = 3
          Width = 628
          Height = 525
          Align = alClient
          BorderStyle = bsNone
          DataSource = dsSchemas
          Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgTitleClick, dgTitleHotTrack]
          TabOrder = 0
          TitleFont.Charset = DEFAULT_CHARSET
          TitleFont.Color = clWindowText
          TitleFont.Height = -13
          TitleFont.Name = 'Tahoma'
          TitleFont.Style = []
        end
        object pnlButtonsSchemas: TPanel
          AlignWithMargins = True
          Left = 3
          Top = 534
          Width = 628
          Height = 41
          Align = alBottom
          BevelKind = bkFlat
          BevelOuter = bvNone
          TabOrder = 1
          object btnNovoSchema: TButton
            AlignWithMargins = True
            Left = 3
            Top = 3
            Width = 75
            Height = 31
            Align = alLeft
            Caption = 'Novo'
            TabOrder = 0
            OnClick = btnNovoSchemaClick
          end
          object btnAlterarSchema: TButton
            AlignWithMargins = True
            Left = 84
            Top = 3
            Width = 75
            Height = 31
            Align = alLeft
            Caption = 'Editar'
            TabOrder = 1
            OnClick = btnAlterarSchemaClick
          end
          object btnDeletaSchema: TcxButton
            AlignWithMargins = True
            Left = 165
            Top = 3
            Width = 75
            Height = 31
            Align = alLeft
            Caption = 'Deletar'
            Colors.Default = clRed
            Colors.DefaultText = clRed
            Colors.Normal = clRed
            Colors.NormalText = clRed
            Colors.Hot = clRed
            Colors.HotText = clRed
            Colors.Pressed = clRed
            Colors.PressedText = clRed
            TabOrder = 2
            OnClick = btnDeletaSchemaClick
          end
        end
      end
    end
    object tsSelBancosDados: TTabSheet
      Caption = 'tsSelBancosDados'
      ImageIndex = 3
      TabVisible = False
      object grSelecaoBancos: TDBGrid
        AlignWithMargins = True
        Left = 3
        Top = 44
        Width = 1085
        Height = 490
        Align = alClient
        BorderStyle = bsNone
        DataSource = dsSelecionaBancos
        Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgTitleClick, dgTitleHotTrack]
        TabOrder = 0
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -13
        TitleFont.Name = 'Tahoma'
        TitleFont.Style = []
      end
      object pnlButtonsSelecionaBanco: TPanel
        Left = 0
        Top = 537
        Width = 1091
        Height = 41
        Align = alBottom
        TabOrder = 1
        object btnSelecionarBanco: TButton
          AlignWithMargins = True
          Left = 4
          Top = 4
          Width = 85
          Height = 33
          Align = alLeft
          Caption = 'Selecionar'
          TabOrder = 0
          OnClick = btnSelecionarBancoClick
        end
        object btnCancelaBanco: TcxButton
          AlignWithMargins = True
          Left = 1002
          Top = 4
          Width = 85
          Height = 33
          Align = alRight
          Caption = 'Cancelar'
          Colors.Default = clRed
          Colors.DefaultText = clRed
          Colors.Normal = clRed
          Colors.NormalText = clRed
          Colors.Hot = clRed
          Colors.HotText = clRed
          Colors.Pressed = clRed
          Colors.PressedText = clRed
          TabOrder = 1
          OnClick = btnCancelaBancoClick
        end
      end
      object pnlTopoSelecaoBancos: TPanel
        Left = 0
        Top = 0
        Width = 1091
        Height = 41
        Align = alTop
        Caption = 'Selecione o registro do banco de dados'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clHighlight
        Font.Height = -19
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        TabOrder = 2
      end
    end
    object tsCadLinks: TTabSheet
      Caption = 'tsCadLinksTabelas'
      ImageIndex = 4
      TabVisible = False
      DesignSize = (
        1091
        578)
      object pnlTabelaOrigem: TPanel
        Left = 2
        Top = 3
        Width = 274
        Height = 571
        Anchors = [akLeft, akTop, akBottom]
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
          Width = 264
          Height = 561
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
        Left = 290
        Top = 3
        Width = 274
        Height = 571
        Anchors = [akLeft, akTop, akBottom]
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
          Width = 264
          Height = 561
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
      object pnlLinks: TPanel
        Left = 576
        Top = 33
        Width = 510
        Height = 541
        Anchors = [akLeft, akTop, akRight, akBottom]
        BevelKind = bkFlat
        BevelOuter = bvNone
        ParentBackground = False
        TabOrder = 2
        object lbListaLinks: TListBox
          AlignWithMargins = True
          Left = 3
          Top = 3
          Width = 500
          Height = 497
          Align = alClient
          TabOrder = 0
        end
        object pnlBottomListLinks: TPanel
          Left = 0
          Top = 503
          Width = 506
          Height = 34
          Align = alBottom
          BevelOuter = bvNone
          TabOrder = 1
          object btnSalvarLink: TButton
            AlignWithMargins = True
            Left = 3
            Top = 4
            Width = 75
            Height = 26
            Margins.Top = 4
            Margins.Bottom = 4
            Align = alLeft
            Caption = 'Salvar'
            TabOrder = 0
            OnClick = btnSalvarLinkClick
          end
          object btnAlterarLink: TButton
            AlignWithMargins = True
            Left = 165
            Top = 4
            Width = 75
            Height = 26
            Margins.Top = 4
            Margins.Bottom = 4
            Align = alLeft
            Caption = 'Alterar'
            TabOrder = 1
            OnClick = btnAlterarLinkClick
            ExplicitLeft = 84
          end
          object btnExportarSQL: TButton
            AlignWithMargins = True
            Left = 246
            Top = 4
            Width = 99
            Height = 26
            Margins.Top = 4
            Margins.Bottom = 4
            Align = alLeft
            Caption = 'Exportar SQL'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clRed
            Font.Height = -13
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
            TabOrder = 2
            StyleElements = []
            OnClick = btnExportarSQLClick
          end
          object btnCancelaLink: TcxButton
            AlignWithMargins = True
            Left = 84
            Top = 3
            Width = 75
            Height = 28
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
            OnClick = btnCancelaLinkClick
          end
          object btnRemoveLink: TcxButton
            AlignWithMargins = True
            Left = 428
            Top = 3
            Width = 75
            Height = 28
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
            TabOrder = 4
            OnClick = btnRemoveLinkClick
            ExplicitLeft = 165
          end
        end
      end
      object btnCriarLinkCampos: TButton
        Left = 576
        Top = 3
        Width = 291
        Height = 25
        Caption = 'Criar link entre as tabelas selecionadas'
        TabOrder = 3
        OnClick = btnCriarLinkCamposClick
      end
    end
    object tsCadLinksCampos: TTabSheet
      Caption = 'tsCadLinksCampos'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = []
      ImageIndex = 5
      ParentFont = False
      TabVisible = False
      DesignSize = (
        1091
        578)
      object pnlCamposOrigem: TPanel
        Left = 3
        Top = 3
        Width = 300
        Height = 572
        Anchors = [akLeft, akTop, akBottom]
        BevelKind = bkFlat
        BevelOuter = bvNone
        Color = clTeal
        ParentBackground = False
        TabOrder = 0
        object grCamposOrigem: TDBGrid
          AlignWithMargins = True
          Left = 3
          Top = 31
          Width = 290
          Height = 534
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
          Width = 290
          Height = 25
          Margins.Bottom = 0
          Align = alTop
          Caption = 'Unir tabela '#224' tabela de origem'
          TabOrder = 1
          OnClick = btnJoinTabelaClick
        end
      end
      object pnlCamposDestino: TPanel
        Left = 524
        Top = 3
        Width = 300
        Height = 572
        Anchors = [akLeft, akTop, akBottom]
        BevelKind = bkFlat
        BevelOuter = bvNone
        Color = clSkyBlue
        ParentBackground = False
        TabOrder = 1
        object grCamposDestino: TDBGrid
          AlignWithMargins = True
          Left = 3
          Top = 3
          Width = 290
          Height = 562
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
        Left = 830
        Top = 3
        Width = 253
        Height = 572
        Anchors = [akLeft, akTop, akRight, akBottom]
        BevelKind = bkFlat
        BevelOuter = bvNone
        ParentBackground = False
        TabOrder = 2
        object lbListaCamposLink: TListBox
          AlignWithMargins = True
          Left = 3
          Top = 3
          Width = 243
          Height = 528
          Align = alClient
          TabOrder = 0
        end
        object Panel2: TPanel
          Left = 0
          Top = 534
          Width = 249
          Height = 34
          Align = alBottom
          BevelOuter = bvNone
          TabOrder = 1
          object btnSalvarCamposLinks: TButton
            AlignWithMargins = True
            Left = 3
            Top = 5
            Width = 75
            Height = 24
            Margins.Top = 5
            Margins.Bottom = 5
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
            Top = 5
            Width = 75
            Height = 24
            Margins.Top = 5
            Margins.Bottom = 5
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
            Left = 171
            Top = 3
            Width = 75
            Height = 28
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
            Top = 3
            Width = 75
            Height = 28
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
        end
      end
      object pnlCriarLink: TPanel
        Left = 309
        Top = 3
        Width = 212
        Height = 572
        Anchors = [akLeft, akTop, akBottom]
        ParentBackground = False
        TabOrder = 3
        DesignSize = (
          212
          572)
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
          OnClick = Label32Click
        end
        object chkSemCampoOrigem: TCheckBox
          Left = 8
          Top = 5
          Width = 153
          Height = 17
          Caption = 'Sem campo de origem'
          TabOrder = 0
          OnClick = chkSemCampoOrigemClick
        end
        object mmExpressaoLivre: TMemo
          Left = 8
          Top = 472
          Width = 193
          Height = 61
          Anchors = [akLeft, akTop, akBottom]
          TabOrder = 1
        end
        object btnCriarLink: TButton
          Left = 7
          Top = 539
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
          OnClick = btnCriarLinkClick
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
    end
    object tsBoasVindas: TTabSheet
      Caption = 'tsBoasVindas'
      ImageIndex = 6
      TabVisible = False
      object Label33: TLabel
        Left = 16
        Top = 11
        Width = 183
        Height = 16
        Caption = '1. Cadastre os bancos de dados'
      end
      object Label34: TLabel
        Left = 16
        Top = 33
        Width = 370
        Height = 16
        Caption = '2. Informe as tabelas que ser'#227'o usadas para migra'#231#227'o de dados'
      end
      object Label35: TLabel
        Left = 16
        Top = 55
        Width = 466
        Height = 16
        Caption = 
          '3. Crie um registro de esquema selecionando os bancos e suas tab' +
          'elas e campos'
      end
      object Label36: TLabel
        Left = 16
        Top = 77
        Width = 175
        Height = 16
        Caption = '4. Inicie o servi'#231'o de migra'#231#227'o'
      end
    end
  end
  object fmtBancosDeDados: TFDMemTable
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
    Left = 60
    Top = 107
    object fmtBancosDeDadosNOME: TStringField
      DisplayLabel = 'Nome'
      FieldName = 'NOME'
      Size = 50
    end
    object fmtBancosDeDadosSERVIDOR: TStringField
      FieldName = 'SERVIDOR'
      Visible = False
      Size = 50
    end
    object fmtBancosDeDadosPORTA: TStringField
      FieldName = 'PORTA'
      Visible = False
      Size = 6
    end
    object fmtBancosDeDadosCAMINHO: TStringField
      FieldName = 'CAMINHO'
      Visible = False
      Size = 150
    end
    object fmtBancosDeDadosUSUARIO: TStringField
      FieldName = 'USUARIO'
      Visible = False
      Size = 50
    end
    object fmtBancosDeDadosSENHA: TStringField
      FieldName = 'SENHA'
      Visible = False
      Size = 50
    end
    object fmtBancosDeDadosTIPO: TIntegerField
      FieldName = 'TIPO'
      Visible = False
    end
    object fmtBancosDeDadosSISTEMA: TStringField
      FieldName = 'SISTEMA'
      Visible = False
      Size = 10
    end
  end
  object dsBancosDeDados: TDataSource
    AutoEdit = False
    DataSet = fmtBancosDeDados
    OnStateChange = dsBancosDeDadosStateChange
    OnDataChange = dsBancosDeDadosDataChange
    Left = 64
    Top = 128
  end
  object fmtTabelas: TFDMemTable
    Filtered = True
    Filter = 'SELECIONADO = 0'
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired, uvAutoCommitUpdates]
    UpdateOptions.CheckRequired = False
    UpdateOptions.AutoCommitUpdates = True
    Left = 56
    Top = 177
    object fmtTabelasNOME: TStringField
      DisplayLabel = 'Tabelas disponiveis'
      FieldName = 'NOME'
      Size = 50
    end
    object fmtTabelasSELECIONADO: TIntegerField
      DefaultExpression = '0'
      FieldName = 'SELECIONADO'
      Visible = False
    end
    object fmtTabelasSISTEMA: TStringField
      FieldName = 'SISTEMA'
      Visible = False
      Size = 10
    end
  end
  object dsTabelas: TDataSource
    AutoEdit = False
    DataSet = fmtTabelas
    OnStateChange = dsBancosDeDadosStateChange
    Left = 64
    Top = 192
  end
  object fmtSchemas: TFDMemTable
    AfterClose = fmtSchemasAfterClose
    AfterInsert = fmtSchemasAfterInsert
    AfterEdit = fmtSchemasAfterEdit
    AfterPost = fmtSchemasAfterPost
    AfterCancel = fmtSchemasAfterCancel
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired, uvAutoCommitUpdates]
    UpdateOptions.CheckRequired = False
    UpdateOptions.AutoCommitUpdates = True
    Left = 56
    Top = 248
    object fmtSchemasDESCRICAO: TStringField
      DisplayLabel = 'Descri'#231#227'o'
      FieldName = 'DESCRICAO'
      Size = 100
    end
    object fmtSchemasDIR_ARQUIVO: TStringField
      FieldName = 'DIR_ARQUIVO'
      Visible = False
      Size = 500
    end
  end
  object dsSchemas: TDataSource
    AutoEdit = False
    DataSet = fmtSchemas
    OnStateChange = dsSchemasStateChange
    Left = 64
    Top = 256
  end
  object fmtSelecionaBancos: TFDMemTable
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
    Left = 60
    Top = 307
    object fmtSelecionaBancosNOME: TStringField
      DisplayLabel = 'Nome'
      FieldName = 'NOME'
      Size = 50
    end
    object fmtSelecionaBancosSISTEMA: TStringField
      DisplayLabel = 'Sistema'
      DisplayWidth = 6
      FieldName = 'SISTEMA'
      Size = 10
    end
    object fmtSelecionaBancosSERVIDOR: TStringField
      DisplayLabel = 'Servidor'
      DisplayWidth = 15
      FieldName = 'SERVIDOR'
      Size = 50
    end
    object fmtSelecionaBancosPORTA: TStringField
      DisplayLabel = 'Porta'
      FieldName = 'PORTA'
      Visible = False
      Size = 6
    end
    object fmtSelecionaBancosCAMINHO: TStringField
      DisplayLabel = 'Diret'#243'rio'
      FieldName = 'CAMINHO'
      Size = 150
    end
    object fmtSelecionaBancosUSUARIO: TStringField
      FieldName = 'USUARIO'
      Visible = False
      Size = 50
    end
    object fmtSelecionaBancosSENHA: TStringField
      FieldName = 'SENHA'
      Visible = False
      Size = 50
    end
    object fmtSelecionaBancosTIPO: TIntegerField
      FieldName = 'TIPO'
      Visible = False
    end
    object fmtSelecionaBancosARQUIVO: TStringField
      FieldName = 'ARQUIVO'
      Visible = False
      Size = 500
    end
  end
  object dsSelecionaBancos: TDataSource
    AutoEdit = False
    DataSet = fmtSelecionaBancos
    Left = 72
    Top = 320
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
    Left = 54
    Top = 369
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
    Left = 56
    Top = 432
    object fmtTabelasDestinoSEL: TIntegerField
      Alignment = taCenter
      DefaultExpression = '0'
      DisplayLabel = '[  ]'
      DisplayWidth = 3
      FieldName = 'SEL'
      OnGetText = fmtTabelasOrigemSELGetText
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
  object dsTabelasOrigem: TDataSource
    AutoEdit = False
    DataSet = fmtTabelasOrigem
    Left = 64
    Top = 384
  end
  object dsTabelasDestino: TDataSource
    AutoEdit = False
    DataSet = fmtTabelasDestino
    Left = 64
    Top = 448
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
      OnGetText = fmtCamposOrigemTAMANHOGetText
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
  object fmtCamposDestino: TFDMemTable
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired, uvAutoCommitUpdates]
    UpdateOptions.CheckRequired = False
    UpdateOptions.AutoCommitUpdates = True
    Left = 104
    Top = 272
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
      OnGetText = fmtCamposDestinoTAMANHOGetText
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
  object dsCamposOrigem: TDataSource
    AutoEdit = False
    DataSet = fmtCamposOrigem
    OnStateChange = dsBancosDeDadosStateChange
    Left = 104
    Top = 224
  end
  object dsCamposDestino: TDataSource
    AutoEdit = False
    DataSet = fmtCamposDestino
    OnStateChange = dsBancosDeDadosStateChange
    Left = 112
    Top = 312
  end
  object fmtTabelasDependentes: TFDMemTable
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired, uvAutoCommitUpdates]
    UpdateOptions.CheckRequired = False
    UpdateOptions.AutoCommitUpdates = True
    Left = 125
    Top = 374
    object fmtTabelasDependentesTABELA_MASTER: TStringField
      FieldName = 'TABELA_MASTER'
      Size = 50
    end
    object fmtTabelasDependentesTABELA_DEPENDENTE: TStringField
      FieldName = 'TABELA_DEPENDENTE'
      Size = 50
    end
  end
  object popZerarTabelas: TPopupMenu
    Left = 840
    Top = 448
    object CLIENTES1: TMenuItem
      Caption = 'CLIENTES'
      OnClick = VENDEDORES1Click
    end
    object FORNECEDORES1: TMenuItem
      Caption = 'FORNECEDORES'
      OnClick = VENDEDORES1Click
    end
    object GRUPOS1: TMenuItem
      Caption = 'GRUPOS'
      OnClick = VENDEDORES1Click
    end
    object GRUPOSCLIENTE1: TMenuItem
      Caption = 'GRUPOSCLIENTE'
      OnClick = VENDEDORES1Click
    end
    object MARCAS1: TMenuItem
      Caption = 'MARCAS'
      OnClick = VENDEDORES1Click
    end
    object SUBGRUPOS1: TMenuItem
      Caption = 'SUBGRUPOS'
      OnClick = VENDEDORES1Click
    end
    object PRODUTOS1: TMenuItem
      Caption = 'PRODUTOS'
      OnClick = VENDEDORES1Click
    end
    object CAIXAS1: TMenuItem
      Caption = 'CAIXAS'
      OnClick = VENDEDORES1Click
    end
    object CAIXATIPOSMOVIMENTOS1: TMenuItem
      Caption = 'CAIXA_TIPOS_MOVIMENTOS'
      OnClick = VENDEDORES1Click
    end
    object DESPESAS1: TMenuItem
      Caption = 'DESPESAS'
      OnClick = VENDEDORES1Click
    end
    object EQUIPAMENTOS1: TMenuItem
      Caption = 'EQUIPAMENTOS'
      OnClick = VENDEDORES1Click
    end
    object EQUIPAMENTOSCLIENTES1: TMenuItem
      Caption = 'EQUIPAMENTOS_CLIENTES'
      OnClick = VENDEDORES1Click
    end
    object ESTOQUE1: TMenuItem
      Caption = 'ESTOQUE'
      OnClick = VENDEDORES1Click
    end
    object FILIAIS1: TMenuItem
      Caption = 'FILIAIS'
      OnClick = VENDEDORES1Click
    end
    object PARCELASPRAZOS1: TMenuItem
      Caption = 'PARCELAS_PRAZOS'
      OnClick = VENDEDORES1Click
    end
    object PRAZOS1: TMenuItem
      Caption = 'PRAZOS'
      OnClick = VENDEDORES1Click
    end
    object REGRASTRIBUTACAO1: TMenuItem
      Caption = 'REGRASTRIBUTACAO'
      OnClick = VENDEDORES1Click
    end
    object SERVICOS1: TMenuItem
      Caption = 'SERVICOS'
      OnClick = VENDEDORES1Click
    end
    object ECNICOS1: TMenuItem
      Caption = 'TECNICOS'
      OnClick = VENDEDORES1Click
    end
    object IPOSDOCUMENTOS1: TMenuItem
      Caption = 'TIPOS_DOCUMENTOS'
      OnClick = VENDEDORES1Click
    end
    object IPOSPAGAMENTOS1: TMenuItem
      Caption = 'TIPOS_PAGAMENTOS'
      OnClick = VENDEDORES1Click
    end
    object IPOESTOQUEMOV1: TMenuItem
      Caption = 'TIPO_ESTOQUE_MOV'
      OnClick = VENDEDORES1Click
    end
    object UNIDADEMEDIDA1: TMenuItem
      Caption = 'UNIDADE_MEDIDA'
      OnClick = VENDEDORES1Click
    end
    object VENDEDORES1: TMenuItem
      Caption = 'VENDEDORES'
      OnClick = VENDEDORES1Click
    end
    object PRODUTOSFORNECEDORES1: TMenuItem
      Caption = 'PRODUTOS_FORNECEDORES'
      OnClick = VENDEDORES1Click
    end
  end
  object popZerarTabelasPDV: TPopupMenu
    Left = 936
    Top = 448
    object BCAIXA1: TMenuItem
      Caption = 'TB_CAIXA'
      OnClick = BOPERADOR1Click
    end
    object BFORMAPAGAMENTO1: TMenuItem
      Caption = 'TB_FORMA_PAGAMENTO'
      OnClick = BOPERADOR1Click
    end
    object BFORNECEDOR1: TMenuItem
      Caption = 'TB_FORNECEDOR'
      OnClick = BOPERADOR1Click
    end
    object BGRUPO1: TMenuItem
      Caption = 'TB_GRUPO'
      OnClick = BOPERADOR1Click
    end
    object BMARCA1: TMenuItem
      Caption = 'TB_MARCA'
      OnClick = BOPERADOR1Click
    end
    object BPESSOA1: TMenuItem
      Caption = 'TB_PESSOA'
      OnClick = BOPERADOR1Click
    end
    object BPRODUTO1: TMenuItem
      Caption = 'TB_PRODUTO'
      OnClick = BOPERADOR1Click
    end
    object BUNIDADE1: TMenuItem
      Caption = 'TB_UNIDADE'
      OnClick = BOPERADOR1Click
    end
    object BOPERADOR1: TMenuItem
      Caption = 'TB_OPERADOR'
      OnClick = BOPERADOR1Click
    end
    object BRELACIONAR1: TMenuItem
      Caption = 'TB_RELACIONAR'
      OnClick = BOPERADOR1Click
    end
  end
  object odArquivosBanco: TOpenDialog
    Filter = 'Banco de dados|*.fdb|Arquivo INI|*.ini'
    Left = 888
    Top = 400
  end
  object sdArquivos: TSaveDialog
    DefaultExt = '.sql'
    Filter = 'Arquivo SQL|*.sql'
    Left = 707
    Top = 103
  end
end
