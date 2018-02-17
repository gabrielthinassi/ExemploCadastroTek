inherited SDMCadAgenda: TSDMCadAgenda
  OnDestroy = DSServerModuleDestroy
  Width = 278
  inherited sqlCadastro: TSQLDataSet
    AfterOpen = sqlCadastroAfterOpen
  end
  object sqlProcesso: TSQLDataSet
    MaxBlobSize = -1
    Params = <>
    Left = 192
    Top = 32
  end
  object dspProcesso: TDataSetProvider
    DataSet = sqlProcesso
    Options = [poCascadeDeletes, poCascadeUpdates, poAllowCommandText, poUseQuoteChar]
    UpdateMode = upWhereKeyOnly
    Left = 192
    Top = 104
  end
end
