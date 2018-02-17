unit USDMMestre;

interface

uses
  System.SysUtils, System.Classes, Data.FMTBcd, Data.DBXFirebird,
  Datasnap.Provider, Data.DB, Data.SqlExpr, Vcl.Forms,
  Datasnap.DSServer, Datasnap.DSAuth, Datasnap.DSProviderDataModuleAdapter, scServer;

type
  TSDMMestre = class(TDSServerModule)
    sqlProxCodigo: TSQLDataSet;
    dspProxCodigo: TDataSetProvider;
    procedure DSServerModuleCreate(Sender: TObject);
  private
  public
    function ProximoCodigo(Tabela, Campo: string): OleVariant;
    function ExecuteReader(SQL: string; CriarTransacao: Boolean): OleVariant;
  end;

var
  SDMMestre: TSDMMestre;

implementation

{%CLASSGROUP 'System.Classes.TPersistent'}

{$R *.dfm}

// Pega próximo código.
procedure TSDMMestre.DSServerModuleCreate(Sender: TObject);
begin
    sqlProxCodigo.SQLConnection := sc_Server.GetConnection;
end;

function TSDMMestre.ProximoCodigo(Tabela, Campo: string): OleVariant;
begin
    with sqlProxCodigo do
    begin
        Close;
        CommandText := 'select max(' + Campo + ') from ' + Tabela;
        Open;
        Result := Fields[0].AsInteger + 1;
    end;
end;

function TSDMMestre.ExecuteReader(SQL: string; CriarTransacao: Boolean): OleVariant;
var
  DataSetPesq: TSQLDataSet;
  DSP: TDataSetProvider;
begin
  try
    {if CriarTransacao then
      TransacaoLocal := MeuSQLConection.GetConnection.BeginTransaction(TDBXIsolations.ReadCommitted)
    else if (not MeuSQLConection.GetConnection.InTransaction) then
      raise Exception.Create('Toda execução da função ExecuteReader deve estar dentro de um contexto transacional');
    }
    DSP := TDataSetProvider.Create(nil);
    DataSetPesq := TSQLDataSet.Create(nil);
    try
      with DataSetPesq do
      begin
        SQLConnection := sc_Server.GetConnection;
        ParamCheck  := False;
        CommandText := SQL;
        GetMetadata := False;
      end;
      with DSP do
      begin
        Exported := False;
        Constraints := False;
        DataSet := DataSetPesq;
        Result := DSP.Data;
      end;
    finally
      FreeAndNil(DSP);
      FreeAndNil(DataSetPesq);
    end;
  except
    on E: Exception do
    begin
       raise Exception.Create(E.Message);
    end;
  end;
end;

end.
