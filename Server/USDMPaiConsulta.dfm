object SDMPaiConsulta: TSDMPaiConsulta
  OldCreateOrder = False
  OnCreate = DSServerModuleCreate
  Height = 150
  Width = 206
  object dspConsulta: TDataSetProvider
    DataSet = sqlConsulta
    Options = [poCascadeDeletes, poCascadeUpdates, poAllowCommandText, poUseQuoteChar]
    UpdateMode = upWhereKeyOnly
    Left = 88
    Top = 88
  end
  object sqlConsulta: TSQLDataSet
    MaxBlobSize = -1
    Params = <>
    Left = 88
    Top = 24
  end
end
