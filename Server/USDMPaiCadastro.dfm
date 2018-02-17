inherited SDMPaiCadastro: TSDMPaiCadastro
  OldCreateOrder = True
  OnCreate = DSServerModuleCreate
  Height = 199
  Width = 188
  object dspCadastro: TDataSetProvider
    DataSet = sqlCadastro
    Options = [poCascadeDeletes, poCascadeUpdates]
    UpdateMode = upWhereKeyOnly
    OnUpdateError = dspCadastroUpdateError
    Left = 80
    Top = 104
  end
  object sqlCadastro: TSQLDataSet
    MaxBlobSize = -1
    Params = <>
    Left = 80
    Top = 32
  end
end
