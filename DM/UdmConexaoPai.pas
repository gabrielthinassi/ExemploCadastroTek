unit UdmConexaoPai;

interface

uses
  System.SysUtils, System.Classes, Data.DB, Data.SqlExpr, Vcl.Forms,
  Data.DBXDataSnap, IPPeerClient, Data.DBXCommon, IniFiles, Data.FMTBcd,
  Datasnap.DBClient, Datasnap.DSConnect;

type
  TdmConexaoPai = class(TDataModule)
    conConexao: TSQLConnection;
    procedure DataModuleDestroy(Sender: TObject);
  private
    ExecuteComand: TDBXCommand;
    FDBXConnection: TDBXConnection;
  public
    function TestaConexao(Servidor: string = ''): Boolean;
    procedure FazConexao;
    function ExecuteMethods(ClassServer_e_Metodo: string;
      Parametro: array of Variant): OleVariant;
  end;

var
  dmConexaoPai: TdmConexaoPai;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

uses UClassFuncoes;

{$R *.dfm}

{
    Exemplo:
    ExecuteMethods_ComRetorno('TDSMServer.ProximoCodigo', [<Tabela>, <Campos>])

    [<Tabela>, <Campos>] são os parâmetros. Pode incluir quantos forém necessário.
}
procedure TdmConexaoPai.DataModuleDestroy(Sender: TObject);
begin
    conConexao.Connected := False;
end;

function TdmConexaoPai.ExecuteMethods(ClassServer_e_Metodo: string; Parametro: Array of Variant): OleVariant;
var
    I: integer;
begin
    if ExecuteComand = nil then
    begin
        FDBXConnection := conConexao.DBXConnection;
        ExecuteComand := FDBXConnection.CreateCommand;
        ExecuteComand.CommandType := TDBXCommandTypes.DSServerMethod;
        ExecuteComand.Text := ClassServer_e_Metodo;
        ExecuteComand.Prepare;
    end;

    for I := low(Parametro) to high(Parametro) do
        case ExecuteComand.Parameters[I].DataType of
          TDBXDataTypes.BooleanType:
            ExecuteComand.Parameters[I].Value.SetBoolean(Parametro[I]);
          TDBXDataTypes.CurrencyType:
            ExecuteComand.Parameters[I].Value.AsCurrency := StrToCurr(Parametro[I]);
          TDBXDataTypes.DateType,
            TDBXDataTypes.DateTimeType,
            TDBXDataTypes.TimeStampType:
            ExecuteComand.Parameters[I].Value.AsDateTime := StrToDateTime(Parametro[I]);
          TDBXDataTypes.DoubleType,
            TDBXDataTypes.BcdType:
            ExecuteComand.Parameters[I].Value.SetDouble(StrToCurr(Parametro[I]));
          TDBXDataTypes.UInt8Type,
            TDBXDataTypes.Int8Type:
            ExecuteComand.Parameters[I].Value.SetInt8(StrToInt(Parametro[I]));
          TDBXDataTypes.Int16Type:
            ExecuteComand.Parameters[I].Value.SetInt16(StrToInt(Parametro[I]));
          TDBXDataTypes.Int32Type:
            ExecuteComand.Parameters[I].Value.SetInt32(StrToInt(Parametro[I]));
          TDBXDataTypes.Int64Type,
            TDBXDataTypes.Uint64Type:
            ExecuteComand.Parameters[I].Value.SetInt64(StrToInt64(Parametro[I]));
          TDBXDataTypes.VariantType:
            ExecuteComand.Parameters[I].Value.AsVariant := Parametro[I];
          TDBXDataTypes.AnsiStringType:
            ExecuteComand.Parameters[I].Value.AsString := Parametro[I];
          TDBXDataTypes.WideStringType:
            ExecuteComand.Parameters[I].Value.SetWideString(Parametro[I]);
          TDBXDataTypes.BlobType:
            ExecuteComand.Parameters[I].Value.SetWideString(Parametro[I]);
        end;

    ExecuteComand.ExecuteUpdate;
    Result := ExecuteComand.Parameters[I].Value.AsVariant;
end;

procedure TdmConexaoPai.FazConexao;
var
    INI: TiniFile;
begin
    INI := TIniFile.Create(ExtractFilePath(Application.ExeName) + 'ClientConfig.ini');
    with conConexao do
    begin
        Params.Clear;
        Params.Add('DriverUnit=Data.DBXDataSnap');
        Params.Add('HostName=' + INI.ReadString('Configuracao', 'Servidor', 'localhost'));
        Params.Add('Port=211');
        Params.Add('CommunicationProtocol=tcp/ip');
        Params.Add('DatasnapContext=datasnap/');
        Params.Add('Borland.Data.TDBXClientDriverLoader,Borland.Data.DbxClientDriver,Version=22.0.0.0,Culture=neutral,PublicKeyToken=91d62ebb5b0d1b1b');

        try
            Connected := True;
        except
            MensagemErro('Servidor de aplicação não está rodando, verifique suas configurações.');
            FreeAndNil(dmConexaoPai);
            Application.Terminate;
        end;
    end;
end;

function TdmConexaoPai.TestaConexao(Servidor: string): Boolean;
var
    INI: TiniFile;
begin
    INI := TIniFile.Create(ExtractFilePath(Application.ExeName) + 'ClientConfig.ini');

    if Servidor = '' then
        Servidor := INI.ReadString('Configuracao', 'Servidor', 'localhost');

        try
            with conConexao do
            begin
                if Connected = True then
                    Result := True
                else
                begin
                    try
                        Close;
                        Params.Clear;
                        Params.Add('DriverUnit=Data.DBXDataSnap');
                        Params.Add('HostName=' + Servidor);
                        Params.Add('Port=211');
                        Params.Add('CommunicationProtocol=tcp/ip');
                        Params.Add('DatasnapContext=datasnap/');
                        Params.Add('Borland.Data.TDBXClientDriverLoader,Borland.Data.DbxClientDriver,Version=22.0.0.0,Culture=neutral,PublicKeyToken=91d62ebb5b0d1b1b');
                        Connected := True;
                        Result := True;
                    finally
                        Connected := False;
                    end;
                end;
            end;
        except
        On E: Exception do
        begin
            Result := False;
            MensagemErro('Servidor de aplicação não está rodando.' + E.Message);
        end;
        end;
end;

end.
