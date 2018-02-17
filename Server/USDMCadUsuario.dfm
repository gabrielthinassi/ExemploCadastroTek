inherited SDMCadUsuario: TSDMCadUsuario
  Width = 325
  inherited sqlCadastro: TSQLDataSet
    AfterOpen = sqlCadastroAfterOpen
  end
  object sqlUsuario: TSQLDataSet
    MaxBlobSize = -1
    Params = <>
    Left = 208
    Top = 32
  end
  object dspUsuario: TDataSetProvider
    DataSet = sqlUsuario
    Options = [poCascadeDeletes, poCascadeUpdates, poAllowCommandText, poUseQuoteChar]
    UpdateMode = upWhereKeyOnly
    BeforeGetRecords = dspUsuarioBeforeGetRecords
    Left = 208
    Top = 104
  end
end
