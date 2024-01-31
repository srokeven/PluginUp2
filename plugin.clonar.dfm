object fmClonarBancoDados: TfmClonarBancoDados
  Left = 0
  Top = 0
  Caption = 'Clonar banco de dados'
  ClientHeight = 557
  ClientWidth = 986
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 16
  object pcPrincipal: TPageControl
    Left = 0
    Top = 0
    Width = 986
    Height = 557
    ActivePage = tsBancos
    Align = alClient
    TabOrder = 0
    object tsLista: TTabSheet
      Caption = 'tsLista'
      ImageIndex = 1
      ExplicitLeft = 8
      ExplicitTop = 31
      object Panel5: TPanel
        Left = 0
        Top = 0
        Width = 978
        Height = 480
        Align = alClient
        TabOrder = 0
        ExplicitTop = -2
        object grBancoDados: TDBGrid
          AlignWithMargins = True
          Left = 4
          Top = 4
          Width = 970
          Height = 472
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
      end
      object Panel6: TPanel
        Left = 0
        Top = 480
        Width = 978
        Height = 46
        Align = alBottom
        TabOrder = 1
        object btnSelecionarLista: TButton
          AlignWithMargins = True
          Left = 90
          Top = 4
          Width = 75
          Height = 38
          Margins.Left = 8
          Align = alLeft
          Caption = 'Selecionar'
          TabOrder = 0
          OnClick = btnSelecionarListaClick
          ExplicitLeft = 124
          ExplicitTop = 6
        end
        object btnAtualizar: TButton
          AlignWithMargins = True
          Left = 4
          Top = 4
          Width = 75
          Height = 38
          Align = alLeft
          Caption = 'Atualizar'
          TabOrder = 1
          ExplicitLeft = 140
          ExplicitTop = 6
          ExplicitHeight = 33
        end
      end
    end
    object tsBancos: TTabSheet
      Caption = 'tsBancos'
      ExplicitWidth = 281
      ExplicitHeight = 162
      object Panel1: TPanel
        Left = 0
        Top = 480
        Width = 978
        Height = 46
        Align = alBottom
        TabOrder = 0
        object btnProximoBancos: TButton
          AlignWithMargins = True
          Left = 95
          Top = 4
          Width = 75
          Height = 38
          Margins.Left = 8
          Align = alLeft
          Caption = 'Proximo'
          TabOrder = 0
          ExplicitLeft = 16
          ExplicitTop = 6
          ExplicitHeight = 25
        end
        object btnVoltarBancos: TButton
          AlignWithMargins = True
          Left = 4
          Top = 4
          Width = 75
          Height = 38
          Margins.Right = 8
          Align = alLeft
          Caption = 'Voltar'
          TabOrder = 1
          ExplicitLeft = 16
          ExplicitTop = 6
          ExplicitHeight = 25
        end
      end
      object Panel2: TPanel
        Left = 0
        Top = 0
        Width = 978
        Height = 480
        Align = alClient
        TabOrder = 1
        ExplicitTop = -6
        ExplicitHeight = 474
        object Label1: TLabel
          Left = 16
          Top = 16
          Width = 46
          Height = 16
          Caption = 'Sistema'
        end
        object cbSistema: TComboBox
          Left = 16
          Top = 38
          Width = 145
          Height = 24
          Style = csDropDownList
          ItemIndex = 0
          TabOrder = 0
          Text = 'MasterVendas'
          Items.Strings = (
            'MasterVendas'
            'Up2 PDV')
        end
        object GroupBox1: TGroupBox
          Left = 16
          Top = 80
          Width = 393
          Height = 281
          Caption = 'Banco de Origem'
          TabOrder = 1
          object Label7: TLabel
            Left = 14
            Top = 216
            Width = 36
            Height = 16
            Caption = 'Senha'
          end
          object Label6: TLabel
            Left = 14
            Top = 168
            Width = 43
            Height = 16
            Caption = 'Usu'#225'rio'
          end
          object Label5: TLabel
            Left = 14
            Top = 120
            Width = 162
            Height = 16
            Caption = 'Caminho do banco de dados'
          end
          object Label4: TLabel
            Left = 14
            Top = 72
            Width = 30
            Height = 16
            Caption = 'Porta'
          end
          object Label3: TLabel
            Left = 14
            Top = 24
            Width = 48
            Height = 16
            Caption = 'Servidor'
          end
          object btnTestarBancoDados: TButton
            Left = 141
            Top = 238
            Width = 122
            Height = 25
            Caption = 'Testar conex'#227'o'
            TabOrder = 0
          end
          object edServidorOrigem: TEdit
            Left = 14
            Top = 46
            Width = 121
            Height = 24
            TabOrder = 1
            Text = '127.0.0.1'
          end
          object edPortaOrigem: TEdit
            Left = 14
            Top = 94
            Width = 121
            Height = 24
            TabOrder = 2
            Text = '3055'
          end
          object edCaminhoOrigem: TEdit
            Left = 14
            Top = 142
            Width = 331
            Height = 24
            TabOrder = 3
            Text = 'C:\MasterVendas\Dados\MASTERVENDAS.fdb'
          end
          object edUsuarioOrigem: TEdit
            Left = 14
            Top = 190
            Width = 121
            Height = 24
            TabOrder = 4
            Text = 'SYSDBA'
          end
          object edSenhaOrigem: TEdit
            Left = 14
            Top = 238
            Width = 121
            Height = 24
            TabOrder = 5
            Text = 'masterkey'
          end
        end
        object GroupBox2: TGroupBox
          Left = 424
          Top = 80
          Width = 393
          Height = 281
          Caption = 'Banco de Destino'
          TabOrder = 2
          object Label2: TLabel
            Left = 14
            Top = 216
            Width = 36
            Height = 16
            Caption = 'Senha'
          end
          object Label8: TLabel
            Left = 14
            Top = 168
            Width = 43
            Height = 16
            Caption = 'Usu'#225'rio'
          end
          object Label9: TLabel
            Left = 14
            Top = 120
            Width = 162
            Height = 16
            Caption = 'Caminho do banco de dados'
          end
          object Label10: TLabel
            Left = 14
            Top = 72
            Width = 30
            Height = 16
            Caption = 'Porta'
          end
          object Label11: TLabel
            Left = 14
            Top = 24
            Width = 48
            Height = 16
            Caption = 'Servidor'
          end
          object Button1: TButton
            Left = 141
            Top = 238
            Width = 122
            Height = 25
            Caption = 'Testar conex'#227'o'
            TabOrder = 0
          end
          object edServidorDestino: TEdit
            Left = 14
            Top = 46
            Width = 121
            Height = 24
            TabOrder = 1
            Text = '127.0.0.1'
          end
          object edPortaDestino: TEdit
            Left = 14
            Top = 94
            Width = 121
            Height = 24
            TabOrder = 2
            Text = '3055'
          end
          object edCaminhoDestino: TEdit
            Left = 14
            Top = 142
            Width = 331
            Height = 24
            TabOrder = 3
            Text = 'C:\MasterVendas\Dados\MASTERVENDAS.fdb'
          end
          object edUsuarioDestino: TEdit
            Left = 14
            Top = 190
            Width = 121
            Height = 24
            TabOrder = 4
            Text = 'SYSDBA'
          end
          object edSenhaDestino: TEdit
            Left = 14
            Top = 238
            Width = 121
            Height = 24
            TabOrder = 5
            Text = 'masterkey'
          end
        end
      end
    end
    object tsProcesso: TTabSheet
      Caption = 'tsProcesso'
      ImageIndex = 2
      ExplicitLeft = 8
      ExplicitTop = 31
      object Panel3: TPanel
        Left = 0
        Top = 480
        Width = 978
        Height = 46
        Align = alBottom
        TabOrder = 0
        object btnVoltarProcesso: TButton
          AlignWithMargins = True
          Left = 4
          Top = 4
          Width = 75
          Height = 38
          Margins.Right = 8
          Align = alLeft
          Caption = 'Voltar'
          TabOrder = 0
          ExplicitLeft = 12
          ExplicitTop = 8
        end
        object btnProximoProcesso: TButton
          AlignWithMargins = True
          Left = 95
          Top = 4
          Width = 75
          Height = 38
          Margins.Left = 8
          Align = alLeft
          Caption = 'Proximo'
          TabOrder = 1
          ExplicitLeft = 103
          ExplicitTop = 8
        end
      end
      object Panel4: TPanel
        Left = 0
        Top = 0
        Width = 978
        Height = 480
        Align = alClient
        TabOrder = 1
        ExplicitLeft = 336
        ExplicitTop = 152
        ExplicitWidth = 185
        ExplicitHeight = 41
        object Label12: TLabel
          AlignWithMargins = True
          Left = 4
          Top = 4
          Width = 970
          Height = 16
          Align = alTop
          Caption = 'Log'
          ExplicitWidth = 20
        end
        object mmLogProcesso: TMemo
          Left = 1
          Top = 23
          Width = 976
          Height = 456
          Align = alClient
          Color = clBlack
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWhite
          Font.Height = -13
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          TabOrder = 0
          ExplicitLeft = 264
          ExplicitTop = 192
          ExplicitWidth = 185
          ExplicitHeight = 89
        end
      end
    end
  end
  object dsSchemas: TDataSource
    AutoEdit = False
    DataSet = fmtSchemas
    Left = 64
    Top = 256
  end
  object fmtSchemas: TFDMemTable
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
end
