unit scServer;

{
http://www.andreanolanusse.com/pt/datasnap-compartilhando-conexao-com-o-banco-entre-diferentes-server-classes-a-partir-do-mesmo-cliente-session/
}

interface

uses System.SysUtils, System.Classes,
  Datasnap.DSTCPServerTransport,
  Datasnap.DSServer, Datasnap.DSCommonServer,
  Datasnap.DSAuth, IPPeerServer, System.Generics.Collections, Data.SqlExpr,
  Datasnap.DSSession, VCL.Forms, Dialogs, Datasnap.dbclient;

type
  Tsc_Server = class(TDataModule)
    DSServer: TDSServer;
    DSTCPServerTransport: TDSTCPServerTransport;
    DSServerClass: TDSServerClass;
    procedure DSServerClassGetClass(DSServerClass: TDSServerClass;
      var PersistentClass: TPersistentClass);
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
    procedure DSServerDisconnect(DSConnectEventObject: TDSConnectEventObject);
    procedure DSServerConnect(DSConnectEventObject: TDSConnectEventObject);
  public
    // Não pode ficar aqui
    ListOfConnection: TDictionary<NativeInt, TSQLConnection>;
    function GetConnection: TSQLConnection;
    procedure ListConnection(CDS: TclientDataSet); 
  end;

var
  sc_Server: Tsc_Server;

implementation

{%CLASSGROUP 'System.Classes.TPersistent'}


{$R *.dfm}

uses Winapi.Windows, USDMMestre, URegistraClassesServidoras, UfrmServer;

var
    TotalConexoes: integer;

// Crio e inicio a conexão
procedure Tsc_Server.DataModuleCreate(Sender: TObject);
begin
    TotalConexoes := 0;

    //Registrando as classes para disponibilizar ao cliente
    URegistraClassesServidoras.RegistrarClassesServidoras(Self, DSServer);

    DSServer.Start;

    ListOfConnection := TDictionary<NativeInt, TSQLConnection>.Create;
end;

procedure Tsc_Server.DataModuleDestroy(Sender: TObject);
begin
    ListOfConnection.Free;
    DSServer.Stop;
end;

procedure Tsc_Server.DSServerClassGetClass(
  DSServerClass: TDSServerClass; var PersistentClass: TPersistentClass);
begin
  PersistentClass := USDMMestre.TSDMMestre;
end;

procedure Tsc_Server.DSServerConnect(
  DSConnectEventObject: TDSConnectEventObject);
begin
    Inc(TotalConexoes);
    with frmServidor do
    begin
        lblConexoes.Caption := 'Conexoões: ' + IntToStr(TotalConexoes);
    end;
end;

procedure Tsc_Server.DSServerDisconnect(
  DSConnectEventObject: TDSConnectEventObject);
begin
    if GetConnection <> nil then
    begin
        GetConnection.Close;
        GetConnection.Connected := False;
        ListOfConnection.Remove(TDSSessionManager.GetThreadSession.Id);
    end;

    Dec(TotalConexoes);
    with frmServidor do
    begin
        lblConexoes.Caption := 'Conexoões: ' + IntToStr(TotalConexoes);
    end;
end;

// Fecha conexão assim que a aplicação cliente desconectar.
function Tsc_Server.GetConnection: TSQLConnection;
var
    dbcon: TSQLConnection;
begin
    //Verifica se existe uma conexão já ativa. Se não, cria-se uma.
    if ListOfConnection.ContainsKey(TDSSessionManager.GetThreadSession.Id) then
        Result := ListOfConnection[TDSSessionManager.GetThreadSession.Id]
    else
    begin
        dbcon := TSQLConnection.Create(nil);
        dbcon.Params.Clear;
        //dbcon.LoadParamsOnConnect := True;
        dbcon.LoginPrompt := False;
        dbcon.DriverName := 'Firebird';
        dbcon.Params.LoadFromFile((ExtractFilePath(Application.ExeName) + 'ServerConfig.ini'));

        ListOfConnection.Add(TDSSessionManager.GetThreadSession.Id, dbcon);
        Result := dbcon;
    end;
end;
procedure Tsc_Server.ListConnection(CDS: TclientDataSet);
var
    I: integer;
begin
    for I in ListOfConnection.Keys do
    begin
        CDS.Append;
        CDS.Fields[0].AsInteger := I;
        CDS.Post;
    end;
end;
end.
