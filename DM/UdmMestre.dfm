object dmMestre: TdmMestre
  OldCreateOrder = False
  Height = 137
  Width = 246
  object dspMestre: TDSProviderConnection
    ServerClassName = 'TSDM_Server'
    Left = 72
    Top = 48
  end
  object cdsMestre: TClientDataSet
    Aggregates = <>
    Params = <>
    RemoteServer = dspMestre
    Left = 160
    Top = 48
  end
end
