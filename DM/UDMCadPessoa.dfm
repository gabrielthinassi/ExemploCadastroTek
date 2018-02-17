inherited dmCadPessoa: TdmCadPessoa
  OldCreateOrder = True
  OnDestroy = DataModuleDestroy
  Height = 160
  Width = 381
  inherited cdsCadastro: TClientDataSet
    OnNewRecord = cdsCadastroNewRecord
    Left = 96
    Top = 56
  end
  inherited dspCadastro: TDSProviderConnection
    Left = 24
    Top = 16
  end
  object cdsEndereco: TClientDataSet
    Aggregates = <>
    Params = <>
    AfterDelete = cdsEnderecoAfterDelete
    OnNewRecord = cdsEnderecoNewRecord
    Left = 176
    Top = 56
  end
  object cdsTelefone: TClientDataSet
    Aggregates = <>
    Params = <>
    AfterDelete = cdsTelefoneAfterDelete
    OnNewRecord = cdsTelefoneNewRecord
    Left = 256
    Top = 56
  end
end
