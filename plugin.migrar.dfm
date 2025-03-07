object fmMigrarBancoDados: TfmMigrarBancoDados
  Left = 0
  Top = 0
  Caption = 'Migrar banco de dados'
  ClientHeight = 556
  ClientWidth = 1104
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'Tahoma'
  Font.Style = []
  Position = poScreenCenter
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnShow = FormShow
  TextHeight = 16
  object pcPrincipal: TPageControl
    Left = 0
    Top = 0
    Width = 1104
    Height = 556
    ActivePage = tsProcesso
    Align = alClient
    TabOrder = 0
    ExplicitWidth = 1098
    ExplicitHeight = 547
    object tsBancos: TTabSheet
      Caption = 'tsBancos'
      TabVisible = False
      object Panel1: TPanel
        Left = 0
        Top = 492
        Width = 1096
        Height = 54
        Align = alBottom
        TabOrder = 0
        object btnProximoBancos: TButton
          AlignWithMargins = True
          Left = 9
          Top = 4
          Width = 128
          Height = 46
          Margins.Left = 8
          Align = alLeft
          Caption = 'Pr'#243'ximo'
          TabOrder = 0
          OnClick = btnProximoBancosClick
        end
      end
      object Panel2: TPanel
        Left = 0
        Top = 0
        Width = 1096
        Height = 492
        Align = alClient
        TabOrder = 1
        object GroupBox1: TGroupBox
          Left = 24
          Top = 23
          Width = 393
          Height = 345
          Caption = 'Banco de Origem'
          TabOrder = 0
          object Label7: TLabel
            Left = 15
            Top = 272
            Width = 36
            Height = 16
            Caption = 'Senha'
          end
          object Label6: TLabel
            Left = 15
            Top = 224
            Width = 43
            Height = 16
            Caption = 'Usu'#225'rio'
          end
          object Label5: TLabel
            Left = 15
            Top = 176
            Width = 162
            Height = 16
            Caption = 'Caminho do banco de dados'
          end
          object Label4: TLabel
            Left = 15
            Top = 128
            Width = 30
            Height = 16
            Caption = 'Porta'
          end
          object Label3: TLabel
            Left = 15
            Top = 80
            Width = 48
            Height = 16
            Caption = 'Servidor'
          end
          object Label1: TLabel
            Left = 15
            Top = 24
            Width = 46
            Height = 16
            Caption = 'Sistema'
          end
          object SpeedButton1: TSpeedButton
            Left = 352
            Top = 200
            Width = 23
            Height = 22
            Glyph.Data = {
              36040000424D3604000000000000360000002800000010000000100000000100
              2000000000000004000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              000000000000000000020000000E0B14308329448DFB1D2F58A5000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000020000000E0D1937883C6DB2FF5BB1F9FF325196F4000000000000
              00000000000100000004000000090000000D0000000F0000000F0000000C0000
              00070000000E0F1D3C864A7CBCFF73C4FFFF467CC3FF17254485000000000000
              0002000000081C130F465A3B31BC7C5043F87F5244FF7B4E42FA57382FC11E14
              1059112142875686C2FF88D0FFFF5186C7FF142343880000000F000000010302
              02104A332C91946B5DFDC6ACA1FFE4D1C6FFEDDDD2FFE2D0C5FFC0A599FF855C
              50FF6E6B7EFF98D4F8FF5B8ECBFF152545840000000D00000002000000076046
              3DA6B39288FFE9DAD0FFDAC0A1FFCBA87AFFC49B66FFCCAA7EFFDCC2A5FFE5D2
              C6FF9A766AFF736A77FF162747850000000E00000002000000002A201D4AAE88
              7CFFEFE6DFFFCDA67CFFCDA26BFFE3C28CFFEDD5A2FFE7CD9EFFD3B182FFD0AE
              88FFE7D5CAFF885F53FF25181464000000070000000000000000755B53ACDFCE
              C9FFDDC1A8FFC99865FFE8BE83FFE9C388FFEDCA97FFEFD3A7FFF2D9B0FFD5B1
              87FFDBBEA6FFC5ACA2FF5A3D33C10000000C0000000000000000A9877CE9F8F4
              F2FFC79873FFDEAB77FFEFCDABFFF0D0B1FFEDC9A1FFECC69AFFEFCFA9FFE9C9
              A4FFC89B77FFE6D6CEFF7C5448F10000000F0000000000000000C09C90FFFDFD
              FCFFBE875FFFEDCFB9FFF5DFD2FFF2D6C1FFF1CFB4FFEDC6A4FFECC19BFFEFC8
              A6FFC08B67FFF1E6DFFF8B6154FF0000000F0000000000000000AF9186E6F9F5
              F4FFC69474FFE8CDC3FFF9E8E4FFF6DED2FFF3D4C2FFF0CBB2FFEBB78EFFE5B7
              92FFC59172FFEBDFD9FF866055EE0000000D0000000000000000876F68B0E7D9
              D4FFE2C6B7FFC89072FFFAEFF2FFF9E7E4FFF6DDD3FFF1C8B2FFEBAF88FFC98E
              6CFFDCBBAAFFD3C0B7FF6B4F46BC00000009000000000000000026201E36CCAF
              A7FAFBF8F7FFCF9F88FFC78E72FFE9CDC6FFEDC7B5FFDD9F79FFC88865FFCE9D
              84FFF5EFEBFFB39387FF2A201D52000000040000000000000000000000036454
              4F84D9C2BAFFFDFBFAFFE2C6B8FFCB977EFFC08163FFCB977DFFE0C4B4FFFAF6
              F5FFC9B0A7FF6B564EA700000009000000010000000000000000000000000202
              020762534D81CEB2A9FAEADDD8FFF9F5F4FFFFFFFFFFF9F5F4FFE9DCD7FFC8AC
              A2FC62504B900404031000000002000000000000000000000000000000000000
              000000000003241F1D3486726BADB69B91E6CCADA1FFB99C92E988736CB22822
              1F3E000000060000000100000000000000000000000000000000}
            OnClick = SpeedButton1Click
          end
          object btnTestarBancoDados: TButton
            Left = 142
            Top = 294
            Width = 122
            Height = 25
            Caption = 'Testar conex'#227'o'
            TabOrder = 0
            OnClick = btnTestarBancoDadosClick
          end
          object edServidorOrigem: TEdit
            Left = 15
            Top = 102
            Width = 121
            Height = 24
            TabOrder = 1
            Text = '127.0.0.1'
          end
          object edPortaOrigem: TEdit
            Left = 15
            Top = 150
            Width = 121
            Height = 24
            TabOrder = 2
            Text = '3055'
          end
          object edCaminhoOrigem: TEdit
            Left = 15
            Top = 198
            Width = 331
            Height = 24
            TabOrder = 3
            Text = 'C:\MasterVendas\Dados\MASTERVENDAS.fdb'
          end
          object edUsuarioOrigem: TEdit
            Left = 15
            Top = 246
            Width = 121
            Height = 24
            TabOrder = 4
            Text = 'SYSDBA'
          end
          object edSenhaOrigem: TEdit
            Left = 15
            Top = 294
            Width = 121
            Height = 24
            TabOrder = 5
            Text = 'masterkey'
          end
          object cbSistema: TComboBox
            Left = 15
            Top = 46
            Width = 145
            Height = 24
            Style = csDropDownList
            Enabled = False
            ItemIndex = 1
            TabOrder = 6
            Text = 'Up2 PDV'
            Items.Strings = (
              'MasterVendas'
              'Up2 PDV')
          end
        end
        object GroupBox2: TGroupBox
          Left = 423
          Top = 16
          Width = 393
          Height = 345
          Caption = 'Banco de Destino'
          TabOrder = 1
          object Label2: TLabel
            Left = 14
            Top = 272
            Width = 36
            Height = 16
            Caption = 'Senha'
          end
          object Label8: TLabel
            Left = 14
            Top = 224
            Width = 43
            Height = 16
            Caption = 'Usu'#225'rio'
          end
          object Label9: TLabel
            Left = 14
            Top = 176
            Width = 162
            Height = 16
            Caption = 'Caminho do banco de dados'
          end
          object Label10: TLabel
            Left = 14
            Top = 128
            Width = 30
            Height = 16
            Caption = 'Porta'
          end
          object Label11: TLabel
            Left = 14
            Top = 80
            Width = 48
            Height = 16
            Caption = 'Servidor'
          end
          object Label13: TLabel
            Left = 15
            Top = 24
            Width = 46
            Height = 16
            Caption = 'Sistema'
          end
          object lbSistemaDestino: TLabel
            Left = 15
            Top = 46
            Width = 165
            Height = 19
            Caption = 'MasterVendas Fiscal'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -16
            Font.Name = 'Tahoma'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object SpeedButton2: TSpeedButton
            Left = 351
            Top = 200
            Width = 23
            Height = 22
            Glyph.Data = {
              36040000424D3604000000000000360000002800000010000000100000000100
              2000000000000004000000000000000000000000000000000000000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              000000000000000000020000000E0B14308329448DFB1D2F58A5000000000000
              0000000000000000000000000000000000000000000000000000000000000000
              0000000000020000000E0D1937883C6DB2FF5BB1F9FF325196F4000000000000
              00000000000100000004000000090000000D0000000F0000000F0000000C0000
              00070000000E0F1D3C864A7CBCFF73C4FFFF467CC3FF17254485000000000000
              0002000000081C130F465A3B31BC7C5043F87F5244FF7B4E42FA57382FC11E14
              1059112142875686C2FF88D0FFFF5186C7FF142343880000000F000000010302
              02104A332C91946B5DFDC6ACA1FFE4D1C6FFEDDDD2FFE2D0C5FFC0A599FF855C
              50FF6E6B7EFF98D4F8FF5B8ECBFF152545840000000D00000002000000076046
              3DA6B39288FFE9DAD0FFDAC0A1FFCBA87AFFC49B66FFCCAA7EFFDCC2A5FFE5D2
              C6FF9A766AFF736A77FF162747850000000E00000002000000002A201D4AAE88
              7CFFEFE6DFFFCDA67CFFCDA26BFFE3C28CFFEDD5A2FFE7CD9EFFD3B182FFD0AE
              88FFE7D5CAFF885F53FF25181464000000070000000000000000755B53ACDFCE
              C9FFDDC1A8FFC99865FFE8BE83FFE9C388FFEDCA97FFEFD3A7FFF2D9B0FFD5B1
              87FFDBBEA6FFC5ACA2FF5A3D33C10000000C0000000000000000A9877CE9F8F4
              F2FFC79873FFDEAB77FFEFCDABFFF0D0B1FFEDC9A1FFECC69AFFEFCFA9FFE9C9
              A4FFC89B77FFE6D6CEFF7C5448F10000000F0000000000000000C09C90FFFDFD
              FCFFBE875FFFEDCFB9FFF5DFD2FFF2D6C1FFF1CFB4FFEDC6A4FFECC19BFFEFC8
              A6FFC08B67FFF1E6DFFF8B6154FF0000000F0000000000000000AF9186E6F9F5
              F4FFC69474FFE8CDC3FFF9E8E4FFF6DED2FFF3D4C2FFF0CBB2FFEBB78EFFE5B7
              92FFC59172FFEBDFD9FF866055EE0000000D0000000000000000876F68B0E7D9
              D4FFE2C6B7FFC89072FFFAEFF2FFF9E7E4FFF6DDD3FFF1C8B2FFEBAF88FFC98E
              6CFFDCBBAAFFD3C0B7FF6B4F46BC00000009000000000000000026201E36CCAF
              A7FAFBF8F7FFCF9F88FFC78E72FFE9CDC6FFEDC7B5FFDD9F79FFC88865FFCE9D
              84FFF5EFEBFFB39387FF2A201D52000000040000000000000000000000036454
              4F84D9C2BAFFFDFBFAFFE2C6B8FFCB977EFFC08163FFCB977DFFE0C4B4FFFAF6
              F5FFC9B0A7FF6B564EA700000009000000010000000000000000000000000202
              020762534D81CEB2A9FAEADDD8FFF9F5F4FFFFFFFFFFF9F5F4FFE9DCD7FFC8AC
              A2FC62504B900404031000000002000000000000000000000000000000000000
              000000000003241F1D3486726BADB69B91E6CCADA1FFB99C92E988736CB22822
              1F3E000000060000000100000000000000000000000000000000}
            OnClick = SpeedButton2Click
          end
          object btnTestarConexaoDadosDestino: TButton
            Left = 141
            Top = 294
            Width = 122
            Height = 25
            Caption = 'Testar conex'#227'o'
            TabOrder = 0
            OnClick = btnTestarConexaoDadosDestinoClick
          end
          object edServidorDestino: TEdit
            Left = 14
            Top = 102
            Width = 121
            Height = 24
            TabOrder = 1
            Text = '127.0.0.1'
          end
          object edPortaDestino: TEdit
            Left = 14
            Top = 150
            Width = 121
            Height = 24
            TabOrder = 2
            Text = '3055'
          end
          object edCaminhoDestino: TEdit
            Left = 14
            Top = 198
            Width = 331
            Height = 24
            TabOrder = 3
            Text = 'C:\MasterVendas\Dados\MASTERVENDAS.fdb'
          end
          object edUsuarioDestino: TEdit
            Left = 14
            Top = 246
            Width = 121
            Height = 24
            TabOrder = 4
            Text = 'SYSDBA'
          end
          object edSenhaDestino: TEdit
            Left = 14
            Top = 294
            Width = 121
            Height = 24
            TabOrder = 5
            Text = 'masterkey'
          end
        end
        object cbTema: TComboBox
          Left = 16
          Top = 374
          Width = 297
          Height = 24
          Style = csDropDownList
          ItemIndex = 0
          TabOrder = 2
          Text = 'Windows'
          OnSelect = cbTemaSelect
          Items.Strings = (
            'Windows'
            'Amethyst Kamri'
            'Cyan Dusk'
            'Iceberg Classico'
            'Luna'
            'Windows'
            'Glossy'
            'Windows10'
            'Windows10 Dark'
            'Windows10 SlateGray')
        end
      end
    end
    object tsLista: TTabSheet
      Caption = 'tsLista'
      ImageIndex = 1
      TabVisible = False
      object Panel5: TPanel
        Left = 0
        Top = 0
        Width = 1096
        Height = 492
        Align = alClient
        TabOrder = 0
        object grBancoDados: TDBGrid
          AlignWithMargins = True
          Left = 52
          Top = 4
          Width = 1040
          Height = 484
          Align = alClient
          BorderStyle = bsNone
          DataSource = dsSchemas
          Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgTitleClick, dgTitleHotTrack]
          TabOrder = 0
          TitleFont.Charset = DEFAULT_CHARSET
          TitleFont.Color = clWindowText
          TitleFont.Height = -13
          TitleFont.Name = 'Tahoma'
          TitleFont.Style = []
          OnCellClick = grBancoDadosCellClick
          OnDrawColumnCell = grBancoDadosDrawColumnCell
          OnTitleClick = grBancoDadosTitleClick
        end
        object Panel7: TPanel
          Left = 1
          Top = 1
          Width = 48
          Height = 490
          Align = alLeft
          TabOrder = 1
          object btnMoveUp: TcxButton
            AlignWithMargins = True
            Left = 4
            Top = 4
            Width = 40
            Height = 45
            Align = alTop
            OptionsImage.Glyph.SourceDPI = 96
            OptionsImage.Glyph.Data = {
              89504E470D0A1A0A0000000D4948445200000020000000200806000000737A7A
              F40000000F744558745469746C650055703B4172726F773BC85E281400000540
              49444154785EC5976B6C145514C7FF33BB4CB7A5BBB46C296D740BE595B669CB
              8A5021585E02220F6B0043A27E5141412522820F62521E2AC6285121248868D4
              A046F1851A1F24068D2106231034EA0712310D282FDB6DBBCB3EEE3DC7E5CECD
              CC486BB6E31766F79FD9ECDE3BFFDF3DE7DC73B30633E34A5E26AEF015F41A18
              86E1C7C03B78C06164E6FE01BCDABAEF38EC710CF65A308361E08965E38DF637
              0F2F0C0EB2F677257A6E7EFEDED6CF1E79E57B6226358F0DCF78EDB76DE5D442
              117045C478707153BF134A83A6B1F2E9B7224596B5EBCEF975D8BEEFD8AE650F
              EF687876F9E444774EB2271C8E79FBEE4300E0034061F78D6F386F0EC01C76F5
              984D531AABAA7BCD00A6C563D5C954660B8035914101EACA7A2158BD25B1BF22
              24C92AF8644BBDB4B9B176C797132ACB07AFAEAB8DA23323513F6E188647C3F7
              2DDFFAD10400669915503BEB9288005200E4138074EED923C0686E5D68158787
              BE3C7B628D792643C848C6E98B8405ADA3CD5069D99ED1F11916008358875FDF
              A5F407A08899E1281F5A15FAB9B7AD5F151F53110F9616A127272125239DBFA3
              D8C2A4FAEAA6E9CBD63F00C08C86820A4282553A658EFF0F801DFA21966D7ED7
              A6BDB14824FCE475CD57E16C4A202B0842DA3A93146889C7501E896C6C5BBDB3
              46D549711E82600348E9AF08A560107BF73B02918AD88BB327C64ACE65045259
              093BCCECDC4FA7809B5AC794BCF177CF76008B01E4585D80F09F02061330B428
              A856BFE299FD8BC6D64417555486713E25D5EA73524BC8BC08DDE91C221561D4
              8DAA9CBF64FDDE5B0004AA4B2D433283FC029020448B6DF3E9B7AE298F944577
              CC6A19818EEE2CD259A10C7339991741081B229B239CECCA60D6D4D10897455F
              B866CEDDE50002B148912124F94B819E6000088E9B34BFBD351EABEA9240222D
              9C90DB52395662425E8C336600B35A46552512F3361F3DB0E72100FCEE9685F4
              5FEDDA3D0DDDB3C0315FBA6E4F4B4363D3B74BE7359827BAD2C80806B4294383
              900B411A625434847D1F1FA35F8F1F9B7EF0F5B58701080034D0B340857E786D
              63A86CF8889D335A469A47FE48E0422A8790158465993060C0D4AC52B2AA0549
              8C4C562A7526D298336D9C79EAF4855D91CADAA9DD677FEFF5749401010CBAE1
              8ECDABE275D5CD493670AE37AB0C84CC0129F6F47A2D3098744A18AA46CE6781
              6BC78F68E8ED7EFCFEAF77DFB34D9BCB42006ACBCDBCBD7DE4D068B4BDB9BE1A
              473A7AD4036D32657E190003FACE004883745C48A1B9B1063FFFF6E786A6B9AB
              3FFCE9ABED27741AB82040D5D849CFCD9C5C5BD29325540D290250E4989EF82B
              0918B609E01A831835C306BB85498CCE94C0EC69F525E7CE776DD3BD41140070
              B816BCF7C52FEE0A75C3696B8B8398F48A7552E146404AC607EFFF60CF23B750
              83A1D21B9D0516480103106F6F9C3718400080A9EFA1C51B3E3D55620594097B
              27B8E1B7EB44100EBCB4A406C0459D730690D3A282007A5246D1BA908610AC0C
              88FF5D8460F7E414C4BA87200D20E90939BBF92FDC09B9EDD14FE4D1533D0280
              D462410449B02188D567220D45B07F93A4A4CDC4251D3A9910D7AF7847BAE685
              0120A454263F76743B454FEAE453E6BAE190D380A4FE2C349C37D77A8CCFD350
              F6390D0D29499B3909D06F7737C87E0054CDFA04D02BEAF39DBB42C375669745
              995FEE25597FE73F028C29238718CE42C84E435579B163426018E4347905C8CC
              0E974BE81320931158F7D4E700E014D4C564F2E0ABAF7D37C37EA2E178F45971
              2EFD8DDA72DAFAB1ADCE73E0E734F4CAD4A02100168040BF4DC5DD6A5900690D
              41FEFF19F515EB2D95D2CDC528309E940A04DF2780D6002F3F63AFF8DFF37F00
              2CE087A47453C8DD0000000049454E44AE426082}
            TabOrder = 0
            OnClick = btnMoveUpClick
          end
          object btnMoveDown: TcxButton
            AlignWithMargins = True
            Left = 4
            Top = 55
            Width = 40
            Height = 45
            Align = alTop
            LookAndFeel.Kind = lfUltraFlat
            LookAndFeel.NativeStyle = True
            OptionsImage.Glyph.SourceDPI = 96
            OptionsImage.Glyph.Data = {
              89504E470D0A1A0A0000000D4948445200000020000000200806000000737A7A
              F400000011744558745469746C6500446F776E3B4172726F773BBDFC82580000
              054949444154785EC5576B6C1455143E77765BB6A52F94572421FE43629598E0
              0F125F1053E2E387F1111225FCC184289A28602AD83F4D5684180D181F140289
              0643404C5A68402A058152207D00A5DDED63BBDD6E5BA8DD2E6BA58F7DDC7BAE
              7BEF9C19596BD88E89619293BB33B373CEF77DE77167989412EEE761C07D3EDC
              779F30C666EAE05E7FBCA7A4FF54DCED2020CB1E9C00903955C0B6CF8EB68109
              546A2F9FBCB18C790F5F3BC100564B60E675722FAD98D264178B8DD7EDDAF8CC
              8B00801F7C7BC126BC7BE3D33307802861D3AB8F69E7F96E43B39720576F7A6D
              994D525394D3A957EC6D2CA3DAC2CAF52BCC6B55179D298052DACCE830840098
              E408ED7F24CC3B088094536588008B0ADC2010810030CB8D40E91080908099F4
              18228290A63A529A1A2052B2D1FC3F2205A33A414A9510E81000CA6905881484
              2B143673A5960D00520A24BF0B800402201C01D032CACC86624220494D924BC8
              58A562AF9413DC063D372F870D4F24A5E0CE52C0BCEB9683779DDD6E86321598
              2B13044003D4800804DD3783B9E83958383B5766B46716008C02BAC8ACF31CCE
              11B880B409407265B32720292EAD7C7BC80F52504E26D47936055C9BF75E4E00
              3996946FA18BD052C0EC14A0D52ACC94402828C8830D5F9E1BA13AB167C6BE2D
              2BF32C40D91460A978A2764DD9D297972C9E03773764748A6B89911C23E51EA9
              16521CE1FDB54F4241AE6117A02F380ADF57379F527EB3D600C5C1C0F50B1F1D
              F3E4AE7A7EE592FCD184B0BAC26E3F29993E41CBD0BC178EC521149DB45393EF
              32E0B7FA8EA9BEAB67B658EC6704E0C4FE8AFEB98B977ADB3A0AB7CF5BF40024
              5411B80CBBFD084F4601521AF49AE4025CC0A0AD671022B7867634D57E15A21A
              C80A0008293FFEDDE6AA9C0FF7BDF9ECBCA2D2B1B8D015EEC971813BC7D06A1A
              1A0FD345278454AB4E4122298031801C8110EC1AF49F3FB86D0F0024C9EFB483
              5E48A66DC7CAFDACB2F53B57942E7FEAD7D2271E366EC6A6480106C04CB6F640
              A2A98394A6E27C37B434766277F3B9175A8EED541B817A181D6CC7DA67AA6E7F
              7973F1FCC307162C287EDB53381BC6931C98BDF35163DBE7666D78D20A0D0623
              303C30F4433A7813B1978EDE88D67AEB24214EB4FCB2FFD376DFE0C8EC1C531D
              21CC561448434898D704D147CEA1ABA32FE23F7BC04BCCC5AA770E3903203842
              EBE01D5D0BC1AB75A33783BE725FFB1014CC72EBAA27231048ED282137D705BE
              AB41F83DE4AF180E5C8AA8E7CFF4DC46CE053802C0050247B40A32597F60D3F1
              BEDEF0E989D804B80C06889A31AD661B1ACC80E8AD188403E1B3AD3595D54A3D
              C525A5D4710880640668EC1BB3C6683CD054BBCD776360CAE332F4F091C45C1B
              221880D0DE1A880FDC38B9150026158F93FEA814526F6E4E01A066C6A5BD2726
              3B1B7E0CDCEAEFFE22D43BAC6782662E4CF6EEF479777B1822E1DE5D03D76A02
              C41E39A2561353D2690A04A4E8E1740E256D22F12B3F57EE0D760DF853F1B8F5
              E6A4D7F1B10908FA7BBBFDA73FDF43EC454D7B44B1A71D943B4F814050A62BFE
              546754D74262FCF69F43FE868FBB6E0CA0DB30F4E6E462001D4D5D38D273B13C
              353536A6DA57A9A6141282F60A44E72F249CE6AD5E983D21E3BEFA6FAE142E7C
              E450C9FCE2B74A16CC81FE9E21180E058FF4371DBC6CB5DD4FD746242A02A4BC
              7300D4E7B4F9D863840A72A2FBFCBE1D79455B573FFE60D1DCC0F54034DC7C70
              BBCA84BA4FA0335EDDADF8331EC5CFBD7B444F351A71F6EFF3556B18812E7CF4
              A58AD74B1E2AAD1AF25FDA106AD87D1400EE2800A5AF7C2DFFED13A9A3FA3D6B
              74670390FD0B8940E4A52D97466DDCCAFDFFF56996418A8221553C7509DDFFCF
              1FA7CE4188E9D79C1F7F01A1F10A94BB25B4830000000049454E44AE426082}
            TabOrder = 1
            OnClick = btnMoveDownClick
          end
        end
      end
      object Panel6: TPanel
        Left = 0
        Top = 492
        Width = 1096
        Height = 54
        Align = alBottom
        TabOrder = 1
        object Shape1: TShape
          AlignWithMargins = True
          Left = 281
          Top = 4
          Width = 1
          Height = 46
          Margins.Left = 10
          Margins.Right = 10
          Align = alLeft
          ExplicitLeft = 282
        end
        object btnProximaLista: TButton
          AlignWithMargins = True
          Left = 140
          Top = 4
          Width = 128
          Height = 46
          Margins.Left = 4
          Align = alLeft
          Caption = 'Pr'#243'ximo'
          TabOrder = 0
          OnClick = btnProximaListaClick
        end
        object btnVoltarLista: TButton
          AlignWithMargins = True
          Left = 4
          Top = 4
          Width = 128
          Height = 46
          Margins.Right = 4
          Align = alLeft
          Caption = 'Voltar'
          TabOrder = 1
          OnClick = btnVoltarListaClick
        end
        object btnIncluirSchema: TButton
          AlignWithMargins = True
          Left = 295
          Top = 4
          Width = 128
          Height = 46
          Align = alLeft
          Caption = 'Incluir'
          TabOrder = 2
          OnClick = btnIncluirSchemaClick
        end
        object btnAlterarSchema: TButton
          AlignWithMargins = True
          Left = 429
          Top = 4
          Width = 128
          Height = 46
          Align = alLeft
          Caption = 'Alterar'
          TabOrder = 3
          OnClick = btnAlterarSchemaClick
        end
        object btnExcluirSchema: TButton
          AlignWithMargins = True
          Left = 563
          Top = 4
          Width = 128
          Height = 46
          Align = alLeft
          Caption = 'Excluir'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clRed
          Font.Height = -13
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          TabOrder = 4
          OnClick = btnExcluirSchemaClick
        end
      end
    end
    object tsProcesso: TTabSheet
      Caption = 'tsProcesso'
      ImageIndex = 2
      TabVisible = False
      object Panel3: TPanel
        Left = 0
        Top = 492
        Width = 1096
        Height = 54
        Align = alBottom
        TabOrder = 0
        ExplicitTop = 483
        ExplicitWidth = 1090
        object Shape2: TShape
          AlignWithMargins = True
          Left = 281
          Top = 4
          Width = 1
          Height = 46
          Margins.Left = 10
          Margins.Right = 10
          Align = alLeft
          ExplicitLeft = 282
        end
        object btnVoltarProcesso: TButton
          AlignWithMargins = True
          Left = 4
          Top = 4
          Width = 128
          Height = 46
          Margins.Right = 4
          Align = alLeft
          Caption = 'Voltar'
          TabOrder = 0
        end
        object btnIniciarProcesso: TButton
          AlignWithMargins = True
          Left = 140
          Top = 4
          Width = 128
          Height = 46
          Margins.Left = 4
          Align = alLeft
          Caption = 'Iniciar'
          TabOrder = 1
          OnClick = btnIniciarProcessoClick
        end
        object btnPrepararBancoOrigem: TButton
          AlignWithMargins = True
          Left = 296
          Top = 4
          Width = 128
          Height = 46
          Margins.Left = 4
          Align = alLeft
          Caption = 'Preparar banco Up2PDV'
          TabOrder = 2
          WordWrap = True
          OnClick = btnPrepararBancoOrigemClick
        end
        object btnPrepararBancoDestino: TButton
          AlignWithMargins = True
          Left = 431
          Top = 4
          Width = 128
          Height = 46
          Margins.Left = 4
          Align = alLeft
          Caption = 'Preparar banco MV FISCAL'
          TabOrder = 3
          WordWrap = True
          OnClick = btnPrepararBancoDestinoClick
        end
      end
      object Panel4: TPanel
        Left = 0
        Top = 0
        Width = 1096
        Height = 492
        Align = alClient
        TabOrder = 1
        ExplicitWidth = 1090
        ExplicitHeight = 483
        object Label12: TLabel
          AlignWithMargins = True
          Left = 4
          Top = 4
          Width = 1088
          Height = 16
          Align = alTop
          Caption = 'Log'
          ExplicitWidth = 20
        end
        object lbProcessamento: TLabel
          AlignWithMargins = True
          Left = 4
          Top = 472
          Width = 1088
          Height = 16
          Align = alBottom
          Caption = '[ | ]'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -16
          Font.Name = 'Courier'
          Font.Style = [fsBold]
          ParentFont = False
          ExplicitWidth = 51
        end
        object mmLogProcesso: TMemo
          AlignWithMargins = True
          Left = 4
          Top = 26
          Width = 1088
          Height = 440
          Align = alClient
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Courier'
          Font.Style = [fsBold]
          ParentFont = False
          ReadOnly = True
          TabOrder = 0
          ExplicitWidth = 1082
          ExplicitHeight = 431
        end
      end
    end
    object tsSQLs: TTabSheet
      Caption = 'tsSQLs'
      ImageIndex = 4
      TabVisible = False
      object mmSQLSequencia: TMemo
        Left = 3
        Top = 3
        Width = 972
        Height = 182
        Lines.Strings = (
          'execute block'
          'as'
          'declare variable VMAXID integer;'
          'begin'
          '  select coalesce(max(ID), 0) from CAIXAS into :VMAXID;'
          
            '  execute statement('#39'ALTER SEQUENCE CAIXAS_ID_SEQ RESTART WITH '#39 +
            ' || cast(:VMAXID as varchar(16)));'
          
            '  select coalesce(max(ID), 0) from CAIXA_TIPOS_MOVIMENTOS into :' +
            'VMAXID;'
          
            '  execute statement('#39'ALTER SEQUENCE CAIXA_TIPOS_MOVIMENTOS_ID_SE' +
            'Q RESTART WITH '#39' || cast(:VMAXID as varchar(16)));'
          '  select coalesce(max(ID), 0) from CLIENTES into :VMAXID;'
          
            '  execute statement('#39'ALTER SEQUENCE CLIENTES_ID_SEQ RESTART WITH' +
            ' '#39' || cast(:VMAXID as varchar(16)));'
          
            '  select coalesce(max(ID), 0) from CONTA_PR where TIPO = 1 into ' +
            ':VMAXID;'
          
            '  execute statement('#39'ALTER SEQUENCE CONTA_RECEBER_SEQ RESTART WI' +
            'TH '#39' || cast(:VMAXID as varchar(16)));'
          
            '  select coalesce(max(ID), 0) from CONTA_PR where TIPO = 2 into ' +
            ':VMAXID;'
          
            '  execute statement('#39'ALTER SEQUENCE CONTA_PAGAR_SEQ RESTART WITH' +
            ' '#39' || cast(:VMAXID as varchar(16)));'
          '  select coalesce(max(ID), 0) from EQUIPAMENTOS into :VMAXID;'
          
            '  execute statement('#39'ALTER SEQUENCE EQUIPAMENTOS_ID_SEQ RESTART ' +
            'WITH '#39' || cast(:VMAXID as varchar(16)));'
          '  select coalesce(max(ID), 0) from ESTOQUE into :VMAXID;'
          
            '  execute statement('#39'ALTER SEQUENCE ESTOQUE_ID_SEQ RESTART WITH ' +
            #39' || cast(:VMAXID as varchar(16)));'
          '  select coalesce(max(ID), 0) from FILIAIS into :VMAXID;'
          
            '  execute statement('#39'ALTER SEQUENCE FILIAIS_ID_SEQ RESTART WITH ' +
            #39' || cast(:VMAXID as varchar(16)));'
          '  select coalesce(max(ID), 0) from FORNECEDORES into :VMAXID;'
          
            '  execute statement('#39'ALTER SEQUENCE FORNECEDORES_ID_SEQ RESTART ' +
            'WITH '#39' || cast(:VMAXID as varchar(16)));'
          '  select coalesce(max(ID), 0) from GRUPOS into :VMAXID;'
          
            '  execute statement('#39'ALTER SEQUENCE GRUPOS_ID_SEQ RESTART WITH '#39 +
            ' || cast(:VMAXID as varchar(16)));'
          '  select coalesce(max(ID), 0) from GRUPOSCLIENTE into :VMAXID;'
          
            '  execute statement('#39'ALTER SEQUENCE GRUPOSCLIENTE_ID_SEQ RESTART' +
            ' WITH '#39' || cast(:VMAXID as varchar(16)));'
          '  select coalesce(max(ID), 0) from MARCAS into :VMAXID;'
          
            '  execute statement('#39'ALTER SEQUENCE MARCAS_ID_SEQ RESTART WITH '#39 +
            ' || cast(:VMAXID as varchar(16)));'
          '  select coalesce(max(ID), 0) from PARCELAS_PRAZOS into :VMAXID;'
          
            '  execute statement('#39'ALTER SEQUENCE PARCELAS_PRAZOS_ID_SEQ RESTA' +
            'RT WITH '#39' || cast(:VMAXID as varchar(16)));'
          '  select coalesce(max(ID), 0) from PERFIL into :VMAXID;'
          
            '  execute statement('#39'ALTER SEQUENCE PERFIL_ID_SEQ RESTART WITH '#39 +
            ' || cast(:VMAXID as varchar(16)));'
          '  select coalesce(max(ID), 0) from PRODUTOS into :VMAXID;'
          
            '  execute statement('#39'ALTER SEQUENCE PRODUTOS_ID_SEQ RESTART WITH' +
            ' '#39' || cast(:VMAXID as varchar(16)));'
          
            '  select coalesce(max(ID), 0) from PERFIL_IMPORTACAO into :VMAXI' +
            'D;'
          
            '  execute statement('#39'ALTER SEQUENCE PERFIL_IMPORTACAO_ID_SEQ RES' +
            'TART WITH '#39' || cast(:VMAXID as varchar(16)));'
          '  select coalesce(max(ID), 0) from PRAZOS into :VMAXID;'
          
            '  execute statement('#39'ALTER SEQUENCE PRAZOS_ID_SEQ RESTART WITH '#39 +
            ' || cast(:VMAXID as varchar(16)));'
          
            '  select coalesce(max(ID), 0) from PRODUTOS_FORNECEDORES into :V' +
            'MAXID;'
          
            '  execute statement('#39'ALTER SEQUENCE PRODUTOS_FORNECEDORES_ID_SEQ' +
            ' RESTART WITH '#39' || cast(:VMAXID as varchar(16)));'
          
            '  select coalesce(max(ID), 0) from REGRASTRIBUTACAO into :VMAXID' +
            ';'
          
            '  execute statement('#39'ALTER SEQUENCE REGRASTRIBUTACAO_ID_SEQ REST' +
            'ART WITH '#39' || cast(:VMAXID as varchar(16)));'
          '  select coalesce(max(ID), 0) from SERVICOS into :VMAXID;'
          
            '  execute statement('#39'ALTER SEQUENCE SERVICOS_ID_SEQ RESTART WITH' +
            ' '#39' || cast(:VMAXID as varchar(16)));'
          '  select coalesce(max(ID), 0) from SUBGRUPOS into :VMAXID;'
          
            '  execute statement('#39'ALTER SEQUENCE SUBGRUPO_ID_SEQ RESTART WITH' +
            ' '#39' || cast(:VMAXID as varchar(16)));'
          '  select coalesce(max(ID), 0) from TECNICOS into :VMAXID;'
          
            '  execute statement('#39'ALTER SEQUENCE TECNICOS_ID_SEQ RESTART WITH' +
            ' '#39' || cast(:VMAXID as varchar(16)));'
          
            '  select coalesce(max(ID), 0) from TIPOS_DOCUMENTOS into :VMAXID' +
            ';'
          
            '  execute statement('#39'ALTER SEQUENCE TIPOS_DOCUMENTOS_ID_SEQ REST' +
            'ART WITH '#39' || cast(:VMAXID as varchar(16)));'
          
            '  select coalesce(max(ID), 0) from TIPOS_PAGAMENTOS into :VMAXID' +
            ';'
          
            '  execute statement('#39'ALTER SEQUENCE TIPOS_PAGAMENTOS_ID_SEQ REST' +
            'ART WITH '#39' || cast(:VMAXID as varchar(16)));'
          
            '  select coalesce(max(ID), 0) from TIPO_ESTOQUE_MOV into :VMAXID' +
            ';'
          
            '  execute statement('#39'ALTER SEQUENCE TIPO_ESTOQUE_MOV_ID_SEQ REST' +
            'ART WITH '#39' || cast(:VMAXID as varchar(16)));'
          '  select coalesce(max(ID), 0) from USUARIOS into :VMAXID;'
          
            '  execute statement('#39'ALTER SEQUENCE USUARIOS_ID_SEQ RESTART WITH' +
            ' '#39' || cast(:VMAXID as varchar(16)));'
          '  select coalesce(max(ID), 0) from VENDEDORES into :VMAXID;'
          
            '  execute statement('#39'ALTER SEQUENCE VENDEDORES_SEQ RESTART WITH ' +
            #39' || cast(:VMAXID as varchar(16)));'
          '  select coalesce(max(ID), 0) from CFE into :VMAXID;'
          
            '  execute statement('#39'ALTER SEQUENCE CFE_ID_SEQ RESTART WITH '#39' ||' +
            ' cast(:VMAXID as varchar(16)));'
          '  select coalesce(max(ID), 0) from CFE_PAGAMENTOS into :VMAXID;'
          
            '  execute statement('#39'ALTER SEQUENCE CFE_PAGAMENTOS_ID_SEQ RESTAR' +
            'T WITH '#39' || cast(:VMAXID as varchar(16)));'
          '  select coalesce(max(ID), 0) from CFE_PRODUTOS into :VMAXID;'
          
            '  execute statement('#39'ALTER SEQUENCE CFE_PRODUTOS_ID_SEQ RESTART ' +
            'WITH '#39' || cast(:VMAXID as varchar(16)));'
          '  select coalesce(max(ID), 0) from CONDUTORES into :VMAXID;'
          
            '  execute statement('#39'ALTER SEQUENCE GEN_CONDUTORES_ID RESTART WI' +
            'TH '#39' || cast(:VMAXID as varchar(16)));'
          '  select coalesce(max(ID), 0) from MDFE into :VMAXID;'
          
            '  execute statement('#39'ALTER SEQUENCE MDFE_ID_SEQ RESTART WITH '#39' |' +
            '| cast(:VMAXID as varchar(16)));'
          '  select coalesce(max(ID), 0) from MDFE_CONDUTORES into :VMAXID;'
          
            '  execute statement('#39'ALTER SEQUENCE MDFE_CONDUTORES_ID_SEQ RESTA' +
            'RT WITH '#39' || cast(:VMAXID as varchar(16)));'
          '  select coalesce(max(ID), 0) from MDFE_EVENTO into :VMAXID;'
          
            '  execute statement('#39'ALTER SEQUENCE MDFE_EVENTO_ID_SEQ RESTART W' +
            'ITH '#39' || cast(:VMAXID as varchar(16)));'
          
            '  select coalesce(max(ID), 0) from MDFE_LOCAL_CARREGAMENTO into ' +
            ':VMAXID;'
          
            '  execute statement('#39'ALTER SEQUENCE MDFE_LOCAL_CARREGAMENTO_ID_S' +
            'EQ RESTART WITH '#39' || cast(:VMAXID as varchar(16)));'
          
            '  select coalesce(max(ID), 0) from MDFE_LOCAL_DESCARREGAMENTO in' +
            'to :VMAXID;'
          
            '  execute statement('#39'ALTER SEQUENCE MDFE_LOCAL_DESCGNTO_ID_SEQ R' +
            'ESTART WITH '#39' || cast(:VMAXID as varchar(16)));'
          '  select coalesce(max(ID), 0) from MDFE_NFE into :VMAXID;'
          
            '  execute statement('#39'ALTER SEQUENCE MDFE_NFE_ID_SEQ RESTART WITH' +
            ' '#39' || cast(:VMAXID as varchar(16)));'
          '  select coalesce(max(ID), 0) from MDFE_REBOQUE into :VMAXID;'
          
            '  execute statement('#39'ALTER SEQUENCE MDFE_REBOQUE_ID_SEQ RESTART ' +
            'WITH '#39' || cast(:VMAXID as varchar(16)));'
          
            '  select coalesce(max(ID), 0) from MDFE_UF_PERCURSO into :VMAXID' +
            ';'
          
            '  execute statement('#39'ALTER SEQUENCE MDFE_UF_PERCURSO_ID_SEQ REST' +
            'ART WITH '#39' || cast(:VMAXID as varchar(16)));'
          '  select coalesce(max(ID), 0) from NFCE into :VMAXID;'
          
            '  execute statement('#39'ALTER SEQUENCE NFCE_ID_SEQ RESTART WITH '#39' |' +
            '| cast(:VMAXID as varchar(16)));'
          '  select coalesce(max(ID), 0) from NFCE_PAGAMENTOS into :VMAXID;'
          
            '  execute statement('#39'ALTER SEQUENCE NFCE_PAGAMENTOS_ID_SEQ RESTA' +
            'RT WITH '#39' || cast(:VMAXID as varchar(16)));'
          '  select coalesce(max(ID), 0) from NFCE_PRODUTOS into :VMAXID;'
          
            '  execute statement('#39'ALTER SEQUENCE NFCE_PRODUTOS_ID_SEQ RESTART' +
            ' WITH '#39' || cast(:VMAXID as varchar(16)));'
          '  select coalesce(max(ID), 0) from NFE into :VMAXID;'
          
            '  execute statement('#39'ALTER SEQUENCE NFE_ID_SEQ RESTART WITH '#39' ||' +
            ' cast(:VMAXID as varchar(16)));'
          '  select coalesce(max(ID), 0) from NOTAS_ENTRADAS into :VMAXID;'
          
            '  execute statement('#39'ALTER SEQUENCE NOTAS_ENTRADAS_ID_SEQ RESTAR' +
            'T WITH '#39' || cast(:VMAXID as varchar(16)));'
          '  select coalesce(max(ID), 0) from REBOQUES into :VMAXID;'
          
            '  execute statement('#39'ALTER SEQUENCE REBOQUES_ID_SEQ RESTART WITH' +
            ' '#39' || cast(:VMAXID as varchar(16)));'
          'end;')
        TabOrder = 0
      end
    end
  end
  object dsSchemas: TDataSource
    AutoEdit = False
    DataSet = fmtSchemas
    Left = 120
    Top = 96
  end
  object fmtSchemas: TFDMemTable
    IndexFieldNames = 'ORDEM'
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired, uvAutoCommitUpdates]
    UpdateOptions.CheckRequired = False
    UpdateOptions.AutoCommitUpdates = True
    Left = 120
    Top = 152
    object fmtSchemasSEL: TIntegerField
      Alignment = taCenter
      DefaultExpression = '0'
      DisplayLabel = '[  ]'
      DisplayWidth = 3
      FieldName = 'SEL'
    end
    object fmtSchemasORDEM: TIntegerField
      DisplayLabel = 'Ordem'
      DisplayWidth = 5
      FieldName = 'ORDEM'
    end
    object fmtSchemasDESCRICAO: TStringField
      DisplayLabel = 'Tabelas'
      FieldName = 'DESCRICAO'
      Size = 100
    end
    object fmtSchemasDIR_ARQUIVO: TStringField
      FieldName = 'DIR_ARQUIVO'
      Visible = False
      Size = 500
    end
  end
  object fodArquivo: TFileOpenDialog
    DefaultExtension = 'Firebird Database|*.fdb'
    FavoriteLinks = <>
    FileTypes = <>
    Options = []
    Left = 300
    Top = 149
  end
end
