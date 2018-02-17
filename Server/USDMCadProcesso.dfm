inherited SDMCadProcesso: TSDMCadProcesso
  OnDestroy = DSServerModuleDestroy
  Height = 353
  Width = 670
  inherited dspCadastro: TDataSetProvider
    Options = [poCascadeDeletes, poCascadeUpdates, poAllowCommandText]
    Left = 32
    Top = 96
  end
  inherited sqlCadastro: TSQLDataSet
    AfterOpen = sqlCadastroAfterOpen
    Left = 32
  end
  object sqlOponente: TSQLDataSet
    MaxBlobSize = -1
    Params = <>
    Left = 184
    Top = 24
  end
  object sqlCliente: TSQLDataSet
    MaxBlobSize = -1
    Params = <>
    Left = 264
    Top = 24
  end
  object sqlProfissional: TSQLDataSet
    MaxBlobSize = -1
    Params = <>
    Left = 344
    Top = 24
  end
  object sqlStatus: TSQLDataSet
    MaxBlobSize = -1
    Params = <>
    Left = 424
    Top = 24
  end
  object sqlArquivo: TSQLDataSet
    AfterOpen = sqlArquivoAfterOpen
    MaxBlobSize = -1
    Params = <>
    Left = 96
    Top = 168
  end
  object sqlProfOponente: TSQLDataSet
    MaxBlobSize = -1
    Params = <>
    Left = 264
    Top = 208
  end
  object sqlTramite: TSQLDataSet
    MaxBlobSize = -1
    Params = <>
    Left = 352
    Top = 208
  end
  object sqlTipoAcao: TSQLDataSet
    MaxBlobSize = -1
    Params = <>
    Left = 432
    Top = 208
  end
  object dspOponente: TDataSetProvider
    DataSet = sqlOponente
    Options = [poCascadeDeletes, poCascadeUpdates, poAllowCommandText, poUseQuoteChar]
    UpdateMode = upWhereKeyOnly
    Left = 184
    Top = 88
  end
  object dspCliente: TDataSetProvider
    DataSet = sqlCliente
    Options = [poCascadeDeletes, poCascadeUpdates, poAllowCommandText, poUseQuoteChar]
    UpdateMode = upWhereKeyOnly
    Left = 264
    Top = 88
  end
  object dspProfissional: TDataSetProvider
    DataSet = sqlProfissional
    Options = [poCascadeDeletes, poCascadeUpdates, poAllowCommandText, poUseQuoteChar]
    UpdateMode = upWhereKeyOnly
    Left = 344
    Top = 88
  end
  object dspStatus: TDataSetProvider
    DataSet = sqlStatus
    Options = [poCascadeDeletes, poCascadeUpdates, poAllowCommandText, poUseQuoteChar]
    UpdateMode = upWhereKeyOnly
    Left = 424
    Top = 88
  end
  object dspProfOponente: TDataSetProvider
    DataSet = sqlProfOponente
    Options = [poCascadeDeletes, poCascadeUpdates, poUseQuoteChar]
    UpdateMode = upWhereKeyOnly
    Left = 264
    Top = 152
  end
  object dspTramite: TDataSetProvider
    DataSet = sqlTramite
    Options = [poCascadeDeletes, poCascadeUpdates, poUseQuoteChar]
    UpdateMode = upWhereKeyOnly
    Left = 352
    Top = 152
  end
  object dspTipoAcao: TDataSetProvider
    DataSet = sqlTipoAcao
    Options = [poCascadeDeletes, poCascadeUpdates, poUseQuoteChar]
    UpdateMode = upWhereKeyOnly
    Left = 432
    Top = 152
  end
  object dsLink: TDataSource
    DataSet = sqlCadastro
    Left = 32
    Top = 168
  end
  object sqlAgenda: TSQLDataSet
    Params = <>
    Left = 504
    Top = 32
  end
  object dspAgenda: TDataSetProvider
    DataSet = sqlAgenda
    Options = [poAllowCommandText, poUseQuoteChar]
    BeforeGetRecords = dspAgendaBeforeGetRecords
    Left = 504
    Top = 96
  end
  object sqlStatusAgenda: TSQLDataSet
    Params = <>
    Left = 600
    Top = 32
  end
  object dspStatusAgenda: TDataSetProvider
    DataSet = sqlStatusAgenda
    Left = 600
    Top = 96
  end
end
