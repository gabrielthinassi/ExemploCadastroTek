inherited frmCadPessoa: TfrmCadPessoa
  Caption = 'Cadastro de pessoas'
  ClientHeight = 432
  ClientWidth = 750
  OnDestroy = FormDestroy
  ExplicitWidth = 756
  ExplicitHeight = 461
  PixelsPerInch = 96
  TextHeight = 15
  inherited JvPanel1: TJvPanel
    Width = 641
    Height = 383
    TabOrder = 2
    ExplicitWidth = 641
    ExplicitHeight = 383
    object JvPanel4: TJvPanel
      Left = 1
      Top = 1
      Width = 639
      Height = 146
      Align = alTop
      TabOrder = 0
      object Label1: TLabel
        Left = 5
        Top = 7
        Width = 109
        Height = 15
        Caption = 'Nome/Raz'#227'o Social'
      end
      object Label2: TLabel
        Left = 471
        Top = 7
        Width = 59
        Height = 15
        Caption = 'CNPJ/CPF'
      end
      object Label4: TLabel
        Left = 5
        Top = 53
        Width = 53
        Height = 15
        Caption = 'Profiss'#227'o'
      end
      object Label5: TLabel
        Left = 5
        Top = 98
        Width = 80
        Height = 15
        Caption = 'Email pessoal'
      end
      object Label6: TLabel
        Left = 316
        Top = 98
        Width = 89
        Height = 15
        Caption = 'Email comercial'
      end
      object edtEmailComercial: TDBEdit
        Left = 317
        Top = 116
        Width = 308
        Height = 23
        DataField = 'EMAIL_COMERCIAL_PESSOA'
        DataSource = dsMestre
        TabOrder = 5
      end
      object edtEmailPessoal: TDBEdit
        Left = 6
        Top = 116
        Width = 305
        Height = 23
        DataField = 'EMAIL_PESSOAL_PESSOA'
        DataSource = dsMestre
        TabOrder = 4
      end
      object edtProfissao: TDBEdit
        Left = 6
        Top = 71
        Width = 342
        Height = 23
        DataField = 'PROFISSAO_PESSOA'
        DataSource = dsMestre
        TabOrder = 3
      end
      object edtCNPJCPF: TDBEdit
        Left = 471
        Top = 24
        Width = 156
        Height = 23
        DataField = 'CNPJ_CPF_PESSOA'
        DataSource = dsMestre
        TabOrder = 2
      end
      object edtNome: TDBEdit
        Left = 6
        Top = 24
        Width = 370
        Height = 23
        DataField = 'RAZAOSOCIAL_PESSOA'
        DataSource = dsMestre
        TabOrder = 1
      end
      object rgTipoPessoa: TDBRadioGroup
        Left = 382
        Top = 5
        Width = 83
        Height = 59
        Caption = 'Pessoa'
        DataField = 'FIS_JUR_PESSOA'
        DataSource = dsMestre
        TabOrder = 0
      end
    end
    object JvPageControl1: TJvPageControl
      Left = 1
      Top = 147
      Width = 639
      Height = 235
      ActivePage = tsEndereco
      Align = alClient
      DoubleBuffered = False
      MultiLine = True
      ParentDoubleBuffered = False
      ParentShowHint = False
      ShowHint = False
      Style = tsFlatButtons
      TabOrder = 1
      ParentColor = False
      Color = clBtnFace
      object tsEndereco: TTabSheet
        Caption = 'Endere'#231'o'
        object lbl1: TLabel
          Left = 20
          Top = 116
          Width = 26
          Height = 15
          Caption = 'Rua:'
        end
        object lbl2: TLabel
          Left = 30
          Top = 145
          Width = 16
          Height = 15
          Caption = 'N'#186':'
        end
        object lbl3: TLabel
          Left = 123
          Top = 144
          Width = 36
          Height = 15
          Caption = 'Bairro:'
        end
        object lbl4: TLabel
          Left = 3
          Top = 173
          Width = 43
          Height = 15
          Caption = 'Cidade:'
        end
        object lbl5: TLabel
          Left = 310
          Top = 173
          Width = 28
          Height = 15
          Caption = 'CEP:'
        end
        object lbl6: TLabel
          Left = 452
          Top = 173
          Width = 19
          Height = 15
          Caption = 'UF:'
        end
        object dbgrdEndereco: TJvDBGrid
          Left = 0
          Top = 0
          Width = 631
          Height = 99
          Align = alTop
          DataSource = dsEndereco
          DrawingStyle = gdsGradient
          FixedColor = 13752807
          GradientEndColor = clBtnFace
          Options = [dgEditing, dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgTitleClick, dgTitleHotTrack]
          TabOrder = 0
          TitleFont.Charset = ANSI_CHARSET
          TitleFont.Color = clWindowText
          TitleFont.Height = -12
          TitleFont.Name = 'Arial'
          TitleFont.Style = []
          AlternateRowColor = 14869218
          SelectColumnsDialogStrings.Caption = 'Select columns'
          SelectColumnsDialogStrings.OK = '&OK'
          SelectColumnsDialogStrings.NoSelectionWarning = 'At least one column must be visible!'
          EditControls = <>
          RowsHeight = 19
          TitleRowHeight = 19
        end
        object edtRua: TDBEdit
          Left = 52
          Top = 112
          Width = 464
          Height = 23
          DataField = 'RUA_ENDERECOPES'
          DataSource = dsEndereco
          TabOrder = 2
        end
        object edtNumero: TDBEdit
          Left = 52
          Top = 141
          Width = 65
          Height = 23
          DataField = 'NUMERO_ENDERECOPES'
          DataSource = dsEndereco
          TabOrder = 3
        end
        object edtBairro: TDBEdit
          Left = 165
          Top = 141
          Width = 351
          Height = 23
          DataField = 'BAIRRO_ENDERECOPES'
          DataSource = dsEndereco
          TabOrder = 4
        end
        object edtDescCidade: TDBEdit
          Left = 52
          Top = 170
          Width = 252
          Height = 23
          DataField = 'CIDADE_ENDERECOPES'
          DataSource = dsEndereco
          TabOrder = 5
        end
        object edtCEP: TDBEdit
          Left = 344
          Top = 170
          Width = 102
          Height = 23
          DataField = 'CEP_ENDERECOPES'
          DataSource = dsEndereco
          TabOrder = 6
        end
        object edtUF: TDBEdit
          Left = 477
          Top = 170
          Width = 39
          Height = 23
          DataField = 'UF_ENDERECOPES'
          DataSource = dsEndereco
          TabOrder = 7
        end
        object rgTipoEndereco: TDBRadioGroup
          Left = 524
          Top = 119
          Width = 106
          Height = 71
          Caption = 'Tipo endere'#231'o'
          DataField = 'TIPO_ENDERECOPES'
          DataSource = dsEndereco
          Items.Strings = (
            'Residencial'
            'Comercial')
          TabOrder = 1
          Values.Strings = (
            '0'
            '1')
        end
      end
      object TabSheet2: TTabSheet
        Caption = 'Telefone/Observa'#231#245'es'
        ImageIndex = 1
        object Label7: TLabel
          Left = 2
          Top = 102
          Width = 73
          Height = 15
          Caption = 'Observa'#231#245'es'
        end
        object dbgrdTelefone_Obs: TJvDBGrid
          Left = 0
          Top = 0
          Width = 631
          Height = 89
          Align = alTop
          DataSource = dsTelefone
          DrawingStyle = gdsGradient
          GradientEndColor = clBtnFace
          TabOrder = 0
          TitleFont.Charset = ANSI_CHARSET
          TitleFont.Color = clWindowText
          TitleFont.Height = -12
          TitleFont.Name = 'Arial'
          TitleFont.Style = []
          AlternateRowColor = clMoneyGreen
          SelectColumnsDialogStrings.Caption = 'Select columns'
          SelectColumnsDialogStrings.OK = '&OK'
          SelectColumnsDialogStrings.NoSelectionWarning = 'At least one column must be visible!'
          EditControls = <>
          RowsHeight = 19
          TitleRowHeight = 19
        end
        object mmoObservacoes: TDBMemo
          Left = 0
          Top = 119
          Width = 631
          Height = 83
          Align = alBottom
          DataField = 'OBSERVACOES_PESSOA'
          DataSource = dsMestre
          TabOrder = 1
          OnEnter = mmoObservacoesEnter
          OnExit = mmoObservacoesExit
        end
      end
    end
  end
  inherited JvPanel2: TJvPanel
    Width = 750
    TabOrder = 0
    ExplicitWidth = 750
    inherited edtCodigo: TJvCalcEdit
      MaxValue = 999999.000000000000000000
    end
  end
  inherited JvPanel3: TJvPanel
    Height = 383
    TabOrder = 1
    ExplicitHeight = 383
  end
  inherited dsMestre: TDataSource
    DataSet = dmCadPessoa.cdsCadastro
    Left = 37
    Top = 233
  end
  object dsTelefone: TDataSource
    DataSet = dmCadPessoa.cdsTelefone
    Left = 40
    Top = 345
  end
  object dsEndereco: TDataSource
    DataSet = dmCadPessoa.cdsEndereco
    Left = 40
    Top = 289
  end
end
