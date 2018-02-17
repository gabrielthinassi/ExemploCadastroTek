unit URegistraClassesServidoras;

{
http://www.andreanolanusse.com/pt/registrando-datasnap-server-class-em-tempo-de-execucao-no-delphi/
}

interface

uses
  System.Classes, Datasnap.DSServer, Datasnap.DSNames, Datasnap.DSReflect, DSCommonServer,
  Datasnap.DSProviderDataModuleAdapter;

type
    TRegistraServerClass = class(TDSServerClass)
    private
        FPersistentClass: TPersistentClass;
        FExpoeProvider: Boolean;
    protected
        function GetDSClass: TDSClass; override;
    public
        constructor Create(AOwner: TComponent; AServer: TDSCustomServer; AClass: TPersistentClass;
                          ExpoeProvider: Boolean; ALifeCycle: string); reintroduce; overload;
    end;

    procedure RegistrarClassesServidoras(AOwner: TComponent; AServer: TDSServer);

implementation

uses
{$REGION 'Lista de Units Server Módules'}
    USDMCadPessoa,
    USDMPaiConsulta;

{$ENDREGION}

{ TRegistraServerClass }

constructor TRegistraServerClass.Create(AOwner: TComponent;
  AServer: TDSCustomServer; AClass: TPersistentClass; ExpoeProvider: Boolean; ALifeCycle: string);
begin
    inherited Create(AOwner);
    FPersistentClass := AClass;
    Self.Server := AServer;
    FExpoeProvider := ExpoeProvider;
    Self.LifeCycle := ALifeCycle;
end;

function TRegistraServerClass.GetDSClass: TDSClass;
begin
    Result := TDSClass.Create(FPersistentClass, False);
    Result := TDSClass.Create(TDSProviderDataModuleAdapter, Result);
end;

procedure RegistrarClassesServidoras(AOwner: TComponent; AServer: TDSServer);
begin
    Assert(AServer.Started = false, 'Não é possível adicionar classes com o servidor ativo');

{$REGION 'Lista de Classes que Serão Exportadas para a Aplicação Cliente'}
    TRegistraServerClass.Create(AOwner, AServer, TSDMCadPessoa, True, TDSLifeCycle.Session);
    TRegistraServerClass.Create(AOwner, AServer, TSDMPaiConsulta, True, TDSLifeCycle.Session);
{$ENDREGION}
end;
end.
