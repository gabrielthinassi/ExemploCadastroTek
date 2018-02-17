inherited SDMCadPessoa: TSDMCadPessoa
  OnDestroy = DSServerModuleDestroy
  Height = 180
  Width = 378
  inherited dspCadastro: TDataSetProvider
    Left = 56
    Top = 88
  end
  inherited sqlCadastro: TSQLDataSet
    AfterOpen = sqlCadastroAfterOpen
    Left = 56
    Top = 24
  end
  object sqlEndereco: TSQLDataSet
    AfterOpen = sqlEnderecoAfterOpen
    MaxBlobSize = -1
    Params = <>
    Left = 200
    Top = 40
  end
  object dsLink: TDataSource
    DataSet = sqlCadastro
    Left = 128
    Top = 72
  end
  object sqlTelefone: TSQLDataSet
    AfterOpen = sqlTelefoneAfterOpen
    MaxBlobSize = -1
    Params = <>
    Left = 280
    Top = 40
  end
end
