inherited dmCadCliente: TdmCadCliente
  OldCreateOrder = True
  inherited qrCadastro: TSQLQuery
    BeforeOpen = qrCadastroBeforeOpen
    SQL.Strings = (
      '')
    Top = 32
  end
  inherited cdsCadastro: TClientDataSet
    BeforePost = cdsCadastroBeforePost
  end
end
