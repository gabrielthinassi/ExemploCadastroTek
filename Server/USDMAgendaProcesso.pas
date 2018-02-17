unit USDMAgendaProcesso;

interface

uses
  System.SysUtils, System.Classes, Datasnap.DSServer, 
  Datasnap.DSAuth, Datasnap.DSProviderDataModuleAdapter, Data.FMTBcd,
  Datasnap.Provider, Data.DB, Data.SqlExpr;

type
  TSDMAgendaProcesso = class(TDSServerModule)
    sqlCadastro: TSQLDataSet;
    dspCadastro: TDataSetProvider;
    procedure DSServerModuleCreate(Sender: TObject);
  private
    function FiltraDataPeriodo: string;
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

uses scServer;

{$R *.dfm}

procedure TSDMAgendaProcesso.DSServerModuleCreate(Sender: TObject);
begin
    sqlCadastro.SQLConnection := sc_Server.GetConnection;

    sqlCadastro.CommandText := FiltraDataPeriodo;

    sqlCadastro.Params.Clear;
       with TParam(sqlCadastro.Params.Add) do
       begin
         Name := 'data1';
         DataType := ftDate;
         ParamType := ptInput;
       end;

       with TParam(sqlCadastro.Params.Add) do
       begin
         Name := 'data2';
         DataType := ftDate;
         ParamType := ptInput;
       end;
end;

function TSDMAgendaProcesso.FiltraDataPeriodo: string;
var
    SQL: string;
begin
    SQL := 'select PROCESSO.ID_PROCESSO,' + #13 +
           'PROCESSO.NUMERO_PROCESSO,' + #13 +
           'PROCESSO.DATA_PROCESSO,' + #13 +
           'PROCESSO.HORA_PROCESSO,' + #13 +
           'CLI.RAZAOSOCIAL_PESSOA,' + #13 +
           'LOCALTRAMITE.DESCRICAO_TRAMITE' + #13 +
           'from PROCESSO' + #13 +
           'left join PESSOA CLI on (CLI.ID_PESSOA = PROCESSO.ID_CLIENTE_PROCESSO)' + #13 +
           'left join LOCALTRAMITE on (LOCALTRAMITE.ID_TRAMITE = PROCESSO.ID_TRAMITE_PROCESSO)' + #13 +
           'where PROCESSO.DATA_PROCESSO between :data1 and :data2';
end;
end.

