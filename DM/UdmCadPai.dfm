object dmCadPai: TdmCadPai
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Height = 163
  Width = 238
  object cdsCadastro: TClientDataSet
    Aggregates = <>
    Params = <>
    RemoteServer = dspCadastro
    AfterOpen = cdsCadastroAfterOpen
    BeforeInsert = cdsCadastroBeforeInsert
    AfterPost = cdsCadastroAfterPost
    AfterDelete = cdsCadastroAfterDelete
    OnReconcileError = cdsCadastroReconcileError
    Left = 144
    Top = 48
  end
  object dspCadastro: TDSProviderConnection
    Left = 56
    Top = 48
  end
end
