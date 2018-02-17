unit USDMPai;

interface

uses
  System.SysUtils, System.Classes, Datasnap.DSServer,
  Datasnap.DSAuth, Datasnap.DSProviderDataModuleAdapter, Data.DB, Data.SqlExpr,
  Data.DBXFirebird, Data.FMTBcd, Datasnap.Provider;

type
  TSDMPai = class(TDSServerModule)
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  SDMPai: TSDMPai;

implementation

{%CLASSGROUP 'System.Classes.TPersistent'}

{$R *.dfm}

end.
