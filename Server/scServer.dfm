object sc_Server: Tsc_Server
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  OnDestroy = DataModuleDestroy
  Height = 206
  Width = 318
  object DSServer: TDSServer
    OnConnect = DSServerConnect
    OnDisconnect = DSServerDisconnect
    AutoStart = False
    Left = 96
    Top = 27
  end
  object DSTCPServerTransport: TDSTCPServerTransport
    Server = DSServer
    Filters = <>
    Left = 96
    Top = 89
  end
  object DSServerClass: TDSServerClass
    OnGetClass = DSServerClassGetClass
    Server = DSServer
    Left = 200
    Top = 27
  end
end
