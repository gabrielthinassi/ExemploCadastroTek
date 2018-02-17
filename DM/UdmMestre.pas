unit UdmMestre;

interface

uses
  System.SysUtils, System.Classes, Data.DBXFirebird, Data.DB, Data.SqlExpr,
  Datasnap.DBClient, Datasnap.DSConnect, Data.DBXDataSnap, IPPeerClient,
  Data.DBXCommon;

type
  TdmMestre = class(TDataModule)
    dspMestre: TDSProviderConnection;
    cdsMestre: TClientDataSet;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  dmMestre: TdmMestre;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

end.
