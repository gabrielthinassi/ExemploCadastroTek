object SDMAgendaProcesso: TSDMAgendaProcesso
  OldCreateOrder = False
  OnCreate = DSServerModuleCreate
  Height = 188
  Width = 248
  object sqlCadastro: TSQLDataSet
    Params = <>
    Left = 80
    Top = 32
  end
  object dspCadastro: TDataSetProvider
    DataSet = sqlCadastro
    Options = [poAllowCommandText, poUseQuoteChar]
    Left = 80
    Top = 104
  end
end
