unit USDMPaiConsulta;

interface

uses
  System.SysUtils, System.Classes, Datasnap.DSServer, 
  Datasnap.DSAuth, Datasnap.DSProviderDataModuleAdapter, Data.FMTBcd, Data.DB,
  Data.SqlExpr, Datasnap.Provider;

type
  TSDMPaiConsulta = class(TDSServerModule)
    dspConsulta: TDataSetProvider;
    sqlConsulta: TSQLDataSet;
    procedure DSServerModuleCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

uses scServer;

{$R *.dfm}

procedure TSDMPaiConsulta.DSServerModuleCreate(Sender: TObject);
begin
    sqlConsulta.SQLConnection := sc_Server.GetConnection;
end;

end.

