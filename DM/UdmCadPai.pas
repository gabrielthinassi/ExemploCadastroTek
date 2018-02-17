unit UdmCadPai;

interface

uses
  System.SysUtils, System.Classes, Data.FMTBcd, Datasnap.Provider,
  Datasnap.DBClient, Data.DB, Data.SqlExpr, Datasnap.DSConnect,
  ClassPaiCadastro, System.Variants, recError;

type
  TdmCadPai = class(TDataModule)
    cdsCadastro: TClientDataSet;
    dspCadastro: TDSProviderConnection;
    procedure DataModuleCreate(Sender: TObject);
    procedure cdsCadastroAfterPost(DataSet: TDataSet);
    procedure cdsCadastroAfterDelete(DataSet: TDataSet);
    procedure cdsCadastroReconcileError(DataSet: TCustomClientDataSet;
      E: EReconcileError; UpdateKind: TUpdateKind;
      var Action: TReconcileAction);
    procedure cdsCadastroBeforeInsert(DataSet: TDataSet);
    procedure cdsCadastroAfterOpen(DataSet: TDataSet);
  private
  public

    function AchouRegistro(Codigo: integer):boolean;
  protected
    FClassFilha: TFClassPaiCadastro;
    FProximoCodigo: integer;
    property ProximoCodigo: integer read FProximoCodigo write FProximoCodigo;

  end;

var
  dmCadPai: TdmCadPai;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

uses UClassFuncoes, UdmConexaoPai;

{$R *.dfm}

function TdmCadPai.AchouRegistro(Codigo: integer): boolean;
begin
    Result := False;

    cdsCadastro.Close;
    cdsCadastro.FetchParams;
    cdsCadastro.ParamByName('cod').AsInteger := Codigo;
    cdsCadastro.Open;

    if not cdsCadastro.IsEmpty then
        Result := True;
end;

procedure TdmCadPai.cdsCadastroAfterDelete(DataSet: TDataSet);
begin
    cdsCadastro.ApplyUpdates(0);
end;

procedure TdmCadPai.cdsCadastroAfterOpen(DataSet: TDataSet);
begin
    FClassFilha.ConfigurarPropriedadesDoCampo(cdsCadastro);
end;

procedure TdmCadPai.cdsCadastroAfterPost(DataSet: TDataSet);
begin
    cdsCadastro.ApplyUpdates(0);
end;

procedure TdmCadPai.cdsCadastroBeforeInsert(DataSet: TDataSet);
begin
    cdsCadastro.EmptyDataSet;
end;

procedure TdmCadPai.cdsCadastroReconcileError(DataSet: TCustomClientDataSet;
  E: EReconcileError; UpdateKind: TUpdateKind; var Action: TReconcileAction);
begin
    Action := raAbort;
end;

procedure TdmCadPai.DataModuleCreate(Sender: TObject);
begin
    FProximoCodigo := 0;
    dspCadastro.SQLConnection := dmConexaoPai.conConexao;
    cdsCadastro.FetchParams;
    cdsCadastro.ParamByName('Cod').AsInteger := -1;
    cdsCadastro.Open;
end;
end.
