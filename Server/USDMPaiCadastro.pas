unit USDMPaiCadastro;

interface

uses
  System.SysUtils, System.Classes, USDMPai, Data.FMTBcd, Data.DB, Data.SqlExpr,
  Datasnap.Provider, ClassPaiCadastro, Datasnap.DBClient;

type
  TSDMPaiCadastro = class(TSDMPai)
    dspCadastro: TDataSetProvider;
    sqlCadastro: TSQLDataSet;
    procedure DSServerModuleCreate(Sender: TObject);
    procedure dspCadastroUpdateError(Sender: TObject;
      DataSet: TCustomClientDataSet; E: EUpdateError; UpdateKind: TUpdateKind;
      var Response: TResolverResponse);
  private

  public

  protected
    FClassFilha: TFClassPaiCadastro;
    procedure DSServerCreate_Filha(Sender:TObject); virtual;
    procedure SetaProviderFlag(CDS: TSqlDataSet; Chave: string); virtual;

  end;

var
  SDMPaiCadastro: TSDMPaiCadastro;

implementation

{%CLASSGROUP 'System.Classes.TPersistent'}

uses scServer;

{$R *.dfm}

procedure TSDMPaiCadastro.DSServerModuleCreate(Sender: TObject);
begin
  inherited;
    DSServerCreate_Filha(Sender);
    sqlCadastro.CommandText := FClassFilha.SQLBaseCadastro;
    FClassFilha.CriarParametros(sqlCadastro);
end;

procedure TSDMPaiCadastro.SetaProviderFlag(CDS: TSqlDataSet; Chave: string);
var
    I: integer;
begin
    for I := 0 to CDS.FieldCount - 1 do
        if CDS.Fields[I].FieldName = Chave then
            CDS.Fields[I].ProviderFlags := [pfInKey, pfInWhere, pfInUpdate]
        else
            CDS.Fields[I].ProviderFlags := [pfInUpdate];
end;

{
Passando a chave primaria para ser usada para update nos outros registros.

procedure TSDMPaiCadastro.SetProviderFlag(DataSet: TCustomClientDataSet);
var
    I: integer;
begin
  inherited;
    for I := 0 to DataSet.Fields.Count - 1 do
        if DataSet.Fields[I].FieldName = FClassFilha.CampoChave then
            DataSet.Fields[I].ProviderFlags := [pfInKey, pfInUpdate, pfInWhere]
        else
            DataSet.Fields[I].ProviderFlags := [pfInUpdate];
end;
}

// Mostrar o erro no cliente
procedure TSDMPaiCadastro.dspCadastroUpdateError(Sender: TObject;
  DataSet: TCustomClientDataSet; E: EUpdateError; UpdateKind: TUpdateKind;
  var Response: TResolverResponse);
begin
  inherited;
    raise Exception.Create(E.Message);
end;

procedure TSDMPaiCadastro.DSServerCreate_Filha(Sender:TObject);
var
    I: integer;
begin
  inherited;
    for I := 0 to ComponentCount -1 do
        if Components[I] is TSQLDataSet then
            (Components[I] as TSQLDataSet).SQLConnection := sc_Server.GetConnection;
end;

end.

