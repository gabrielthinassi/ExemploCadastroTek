object SDMMestre: TSDMMestre
  OldCreateOrder = False
  OnCreate = DSServerModuleCreate
  Height = 181
  Width = 162
  object sqlProxCodigo: TSQLDataSet
    MaxBlobSize = -1
    Params = <>
    Left = 64
    Top = 24
  end
  object dspProxCodigo: TDataSetProvider
    DataSet = sqlProxCodigo
    Options = [poAllowCommandText, poUseQuoteChar]
    Left = 64
    Top = 96
  end
end
