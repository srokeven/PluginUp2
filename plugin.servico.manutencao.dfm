object fmServicos: TfmServicos
  Left = 0
  Top = 0
  Caption = 'Servi'#231'os'
  ClientHeight = 522
  ClientWidth = 1007
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  WindowState = wsMaximized
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 16
  object pcPrincipal: TPageControl
    Left = 0
    Top = 0
    Width = 1007
    Height = 522
    ActivePage = tsRetorno
    Align = alClient
    TabOrder = 0
    object tsRetorno: TTabSheet
      Caption = 'tsRetorno'
      TabVisible = False
      object pnlSideBar: TPanel
        Left = 0
        Top = 0
        Width = 153
        Height = 512
        Align = alLeft
        TabOrder = 0
        object Label1: TLabel
          Left = 2
          Top = 52
          Width = 92
          Height = 16
          Caption = 'Porta de servi'#231'o'
        end
        object Label2: TLabel
          Left = 2
          Top = 4
          Width = 87
          Height = 16
          Caption = 'Host de servi'#231'o'
        end
        object Bevel1: TBevel
          Left = 2
          Top = 269
          Width = 145
          Height = 2
        end
        object Label3: TLabel
          Left = 2
          Top = 277
          Width = 65
          Height = 16
          Caption = 'Data do log'
        end
        object btnStatus: TButton
          Left = 2
          Top = 104
          Width = 145
          Height = 49
          Caption = 'Status do servi'#231'o'
          TabOrder = 0
          OnClick = btnStatusClick
        end
        object btnIniciar: TButton
          Left = 2
          Top = 159
          Width = 145
          Height = 49
          Caption = 'Iniciar servi'#231'o'
          TabOrder = 1
          OnClick = btnIniciarClick
        end
        object btnParar: TButton
          Left = 2
          Top = 214
          Width = 145
          Height = 49
          Caption = 'Parar servi'#231'o'
          TabOrder = 2
          OnClick = btnPararClick
        end
        object btnLog: TButton
          Left = 2
          Top = 329
          Width = 145
          Height = 49
          Caption = 'Log do servi'#231'o'
          TabOrder = 3
          OnClick = btnLogClick
        end
        object edPorta: TEdit
          Left = 2
          Top = 74
          Width = 145
          Height = 24
          NumbersOnly = True
          TabOrder = 4
          Text = '49255'
        end
        object edHost: TEdit
          Left = 2
          Top = 26
          Width = 145
          Height = 24
          TabOrder = 5
          Text = '127.0.0.1'
        end
        object btnListaLogs: TButton
          Left = 2
          Top = 384
          Width = 145
          Height = 49
          Caption = 'Lista de logs'
          TabOrder = 6
          OnClick = btnListaLogsClick
        end
        object edDataLog: TcxDateEdit
          Left = 2
          Top = 299
          TabOrder = 7
          Width = 145
        end
        object chkAutoRefresh: TCheckBox
          Left = 3
          Top = 439
          Width = 145
          Height = 17
          Caption = 'Auto refresh (Status)'
          TabOrder = 8
          OnClick = chkAutoRefreshClick
        end
        object chkAutoRefreshLog: TCheckBox
          Left = 3
          Top = 462
          Width = 145
          Height = 17
          Caption = 'Auto refresh (Log)'
          TabOrder = 9
          OnClick = chkAutoRefreshLogClick
        end
        object chkLimpaLog: TCheckBox
          Left = 3
          Top = 485
          Width = 145
          Height = 17
          Hint = 'Limpa os logs anteriores ao consultar um novo'
          Caption = 'Limpar Log'
          Checked = True
          ParentShowHint = False
          ShowHint = True
          State = cbChecked
          TabOrder = 10
        end
      end
      object pnlBackground: TPanel
        Left = 153
        Top = 0
        Width = 846
        Height = 512
        Align = alClient
        TabOrder = 1
        object mmResposta: TMemo
          Left = 1
          Top = 1
          Width = 844
          Height = 510
          Align = alClient
          Color = clInfoBk
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'JetBrains Mono NL Medium'
          Font.Style = []
          Lines.Strings = (
            'Log de retornos das requisi'#231#245'es do servi'#231'o')
          ParentFont = False
          TabOrder = 0
        end
      end
    end
  end
  object tmAutoRefresh: TTimer
    Enabled = False
    Interval = 2000
    OnTimer = tmAutoRefreshTimer
    Left = 272
    Top = 160
  end
  object tmAutoRefreshLog: TTimer
    Enabled = False
    Interval = 2000
    OnTimer = tmAutoRefreshLogTimer
    Left = 272
    Top = 224
  end
end
