object dmConexaoPai: TdmConexaoPai
  OldCreateOrder = False
  OnDestroy = DataModuleDestroy
  Height = 107
  Width = 153
  object conConexao: TSQLConnection
    DriverName = 'DataSnap'
    LoginPrompt = False
    Params.Strings = (
      'DriverUnit=Data.DBXDataSnap'
      'HostName=localhost'
      'Port=211'
      'CommunicationProtocol=tcp/ip'
      'DatasnapContext=datasnap/'
      
        'DriverAssemblyLoader=Borland.Data.TDBXClientDriverLoader,Borland' +
        '.Data.DbxClientDriver,Version=22.0.0.0,Culture=neutral,PublicKey' +
        'Token=91d62ebb5b0d1b1b')
    Left = 48
    Top = 24
    UniqueId = '{278332A1-9357-4020-B48A-B81CC0D673F0}'
  end
end
