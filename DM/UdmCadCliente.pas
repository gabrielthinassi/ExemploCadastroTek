unit UdmCadCliente;

interface

uses
  System.SysUtils, System.Classes, UdmCadMestre, Data.FMTBcd, Datasnap.Provider,
  Datasnap.DBClient, Data.DB, Data.SqlExpr;

type
  TdmCadCliente = class(TdmCadMestre)
    procedure qrCadastroBeforeOpen(DataSet: TDataSet);
    procedure cdsCadastroBeforePost(DataSet: TDataSet);
  private
    { Private declarations }
  public
    function GetAutoIncremento: integer;
  end;

var
  dmCadCliente: TdmCadCliente;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

uses UdmConexao, classCadCliente, UClassFuncoes;

{$R *.dfm}

{ TdmCadMestre1 }


procedure TdmCadCliente.cdsCadastroBeforePost(DataSet: TDataSet);
begin
  inherited;
    //
end;

function TdmCadCliente.GetAutoIncremento: integer;
var
    ClassCliente: TclassCadCliente;
begin
    ClassCliente := TclassCadCliente.Create;
    cdsCadastro.FieldByName(ClassCliente.Table_Key).AsInteger := AutoIncremento(dmConexao.conConexao, ClassCliente.Table_Name, ClassCliente.Table_Key);
    Result := cdsCadastro.FieldByName(ClassCliente.Table_Key).AsInteger;
    FreeAndNil(ClassCliente);
end;

procedure TdmCadCliente.qrCadastroBeforeOpen(DataSet: TDataSet);
var
    ClassCliente: TclassCadCliente;
begin
  inherited;
    ClassCliente := TclassCadCliente.Create;

    qrCadastro.SQL.Add(ClassCliente.selectSQL);

    FreeAndNil(ClassCliente);
end;
end.

