unit USDMCadProcesso;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, USDMPaiCadastro, Data.FMTBcd, Data.DB,
  Data.SqlExpr, Datasnap.Provider,

  ClassProcesso, ClassArquivoProcesso, ClassPessoa, UClassCadStatus,
  UClassCadTipoAcao, uClassCadTramite, Datasnap.DBClient;

type
  TSDMCadProcesso = class(TSDMPaiCadastro)
    sqlOponente: TSQLDataSet;
    sqlCliente: TSQLDataSet;
    sqlProfissional: TSQLDataSet;
    sqlStatus: TSQLDataSet;
    sqlArquivo: TSQLDataSet;
    sqlProfOponente: TSQLDataSet;
    sqlTramite: TSQLDataSet;
    sqlTipoAcao: TSQLDataSet;
    dspOponente: TDataSetProvider;
    dspCliente: TDataSetProvider;
    dspProfissional: TDataSetProvider;
    dspStatus: TDataSetProvider;
    dspProfOponente: TDataSetProvider;
    dspTramite: TDataSetProvider;
    dspTipoAcao: TDataSetProvider;
    dsLink: TDataSource;
    sqlAgenda: TSQLDataSet;
    dspAgenda: TDataSetProvider;
    sqlStatusAgenda: TSQLDataSet;
    dspStatusAgenda: TDataSetProvider;
    procedure sqlCadastroAfterOpen(DataSet: TDataSet);
    procedure DSServerModuleDestroy(Sender: TObject);
    procedure sqlArquivoAfterOpen(DataSet: TDataSet);
    procedure dspAgendaBeforeGetRecords(Sender: TObject;
      var OwnerData: OleVariant);
  private
    ClassArquivoProcesso: TClassArquivoProcesso;
    ClassPessoa: TClassPessoa;
    ClassCadTramite: TClassCadTramite;
    ClassCadTipoAcao: TClassCadTipoAcao;
    ClassCadStatus: TClassCadStatus;
    function FiltraDataPeriodo: string;

  public
    function ListaRelatorioMobile(Valor: string): OleVariant;
    function BuscaTodosProcessoAberto(Cliente: string; TipoPessoa: integer): OleVariant;
  protected
    procedure DSServerCreate_Filha(Sender:TObject); override;
  end;

var
  SDMCadProcesso: TSDMCadProcesso;

implementation

{%CLASSGROUP 'System.Classes.TPersistent'}

{$R *.dfm}

uses UClassFuncoes, classRelatorioPDFPronto, USDMMestre;

{ TSDMPaiCadastro1 }


// Parametro da SQL é criado automaticamente por esse processo através da variável OwnerData.
// É feito a mesma coisa no CDS.
function TSDMCadProcesso.BuscaTodosProcessoAberto(Cliente: string; TipoPessoa: integer): OleVariant;
var
  S: string;
begin
  S := 'select PROCESSO.ID_PROCESSO,' + #13 +
       'PROCESSO.NUMERO_PROCESSO,' + #13 +
       'PESSOA.RAZAOSOCIAL_PESSOA' + #13 +
       'from PESSOA' + #13;

    case TipoPessoa of
      0: S := S + 'inner join PROCESSO on (PROCESSO.ID_CLIENTE_PROCESSO = PESSOA.ID_PESSOA)' + #13 +
                  'where PESSOA.RAZAOSOCIAL_PESSOA like ' + QuotedStr('%' + Cliente + '%');

      1: S := S + 'inner join PROCESSO on (PROCESSO.ID_OPONENTE_PROCESSO = PESSOA.ID_PESSOA)' + #13 +
                  'where PESSOA.RAZAOSOCIAL_PESSOA like ' + QuotedStr('%' + Cliente + '%');

      2: S := S + 'inner join PROCESSO on (PROCESSO.ID_PROF_PROCESSO = PESSOA.ID_PESSOA)' + #13 +
                  'where PESSOA.RAZAOSOCIAL_PESSOA like ' + QuotedStr('%' + Cliente + '%');

      3: S := S + 'inner join PROCESSO on (PROCESSO.ID_PROF_OPO_PROCESSO = PESSOA.ID_PESSOA)' + #13 +
                  'where PESSOA.RAZAOSOCIAL_PESSOA like ' + QuotedStr('%' + Cliente + '%');
    end;

    Result := SDMMestre.ExecuteReader(S, True);

end;

procedure TSDMCadProcesso.dspAgendaBeforeGetRecords(Sender: TObject;
  var OwnerData: OleVariant);
var
    SQL: string;
    Data1, Data2: TDate;
    Status: integer;
begin
    if VarIsArray(OwnerData) and (VarArrayHighBound(OwnerData, 1) = 2) then
    begin
        Data1 := OwnerData[0];
        Data2 := OwnerData[1];
        Status := OwnerData[2];

        SQL := ' where AGENDA_PROCESSO.DATA_AGENDAPRO between ' + QuotedStr(FormatDateTime('mm/dd/yyyy', Data1)) + ' and ' + QuotedStr(FormatDateTime('mm/dd/yyyy', Data2));

        if Status <> 0 then
            SQL := SQL + #13 + 'and STATUS.ID_STATUS = ' + Format('%d', [Status]);

        SQL := SQL + 'order by AGENDA_PROCESSO.DATA_AGENDAPRO, PROCESSO.NUMERO_PROCESSO';

        sqlAgenda.CommandText := FiltraDataPeriodo + SQL;
    end;
end;

procedure TSDMCadProcesso.DSServerCreate_Filha(Sender: TObject);
begin
  inherited;
    FClassFilha := TClassProcesso;
    ClassArquivoProcesso := TClassArquivoProcesso.Create;
    ClassPessoa := TClassPessoa.Create;
    ClassCadTramite := TClassCadTramite.Create;
    ClassCadTipoAcao := TClassCadTipoAcao.Create;
    ClassCadStatus := TClassCadStatus.Create;

    sqlOponente.CommandText := ClassPessoa.SQLBaseGeral;
    ClassPessoa.CriarParametros(sqlOponente);

    sqlCliente.CommandText := ClassPessoa.SQLBaseGeral;
    ClassPessoa.CriarParametros(sqlCliente);

    sqlProfissional.CommandText := ClassPessoa.SQLBaseGeral;
    ClassPessoa.CriarParametros(sqlProfissional);

    sqlProfOponente.CommandText := ClassPessoa.SQLBaseGeral;
    ClassPessoa.CriarParametros(sqlProfOponente);

    sqlStatus.CommandText := ClassCadStatus.SQLBaseGeral;
    ClassCadStatus.CriarParametros(sqlStatus);

    sqlTramite.CommandText := ClassCadTramite.SQLBaseGeral;
    ClassCadTramite.CriarParametros(sqlTramite);

    sqlTipoAcao.CommandText := ClassCadTipoAcao.SQLBaseGeral;
    ClassCadTipoAcao.CriarParametros(sqlTipoAcao);

    sqlArquivo.CommandText := ClassArquivoProcesso.SQLBaseCadastro;
    ClassArquivoProcesso.CriarParametros(sqlArquivo);
    sqlArquivo.DataSource := dsLink;

    sqlStatusAgenda.CommandText := ClassCadStatus.SQLBaseGeral;
    ClassCadStatus.CriarParametros(sqlStatusAgenda);

    //sqlAgenda.CommandText := FiltraDataPeriodo;
end;

procedure TSDMCadProcesso.DSServerModuleDestroy(Sender: TObject);
begin
  inherited;
    ClassArquivoProcesso.Free;
    ClassPessoa.Free;
    ClassCadTramite.Free;
    ClassCadTipoAcao.Free;
    ClassCadStatus.Free;
end;

procedure TSDMCadProcesso.sqlArquivoAfterOpen(DataSet: TDataSet);
begin
  inherited;
    SetaProviderFlag(sqlArquivo, ClassArquivoProcesso.CampoChave);
end;

procedure TSDMCadProcesso.sqlCadastroAfterOpen(DataSet: TDataSet);
begin
  inherited;
    SetaProviderFlag(sqlCadastro, FClassFilha.CampoChave);
end;

function TSDMCadProcesso.FiltraDataPeriodo: string;
var
    SQL: string;
begin
    SQL := 'select PROCESSO.ID_PROCESSO as "Código",' + #13 +
           'PROCESSO.NUMERO_PROCESSO as "Número processo",' + #13 +
           'AGENDA_PROCESSO.DATA_AGENDAPRO as "Data",' + #13 +
           'AGENDA_PROCESSO.HORA_AGENDAPRO as "Hora",' + #13 +
           'STATUS.DESCRICAO_STATUS as "Status",' + #13 +
           'PROCESSO.AREA_PROCESSO as "Area",' + #13 +
           'PROF.RAZAOSOCIAL_PESSOA as "Profissional",' + #13 +
           'CLI.RAZAOSOCIAL_PESSOA as "Cliente",' + #13 +
           'OPO.RAZAOSOCIAL_PESSOA as "Oponente",' + #13 +
           'LOCALTRAMITE.DESCRICAO_TRAMITE as "Tramite",' + #13 +
           'AGENDA_PROCESSO.COMPROMISSO_AGENDAPRO as "Compromisso"' + #13 +
           'from PROCESSO' + #13 +
           'left join PESSOA CLI on (CLI.ID_PESSOA = PROCESSO.ID_CLIENTE_PROCESSO)' + #13 +
           'left join PESSOA PROF on (PROF.ID_PESSOA = PROCESSO.ID_PROF_PROCESSO)' + #13 +
           'left join PESSOA OPO on (OPO.ID_PESSOA = PROCESSO.ID_OPONENTE_PROCESSO)' + #13 +
           'left join LOCALTRAMITE on (LOCALTRAMITE.ID_TRAMITE = PROCESSO.ID_TRAMITE_PROCESSO)' + #13 +
           'left join STATUS on (STATUS.ID_STATUS = PROCESSO.ID_STATUS_PROCESSO)' + #13 +
           'left join AGENDA_PROCESSO on (AGENDA_PROCESSO.ID_PROCESSO = PROCESSO.ID_PROCESSO)' + #13;

    Result := SQL;
end;

//Função chamada somente pelo aplicativo mobile
function TSDMCadProcesso.ListaRelatorioMobile(Valor: string): OleVariant;
var
    RelatorioPronto: TClassRelatorioPDFPronto;
    cdsAgendaProcesso: TClientDataSet;
begin
    cdsAgendaProcesso := TClientDataSet.Create(nil);
    RelatorioPronto := TClassRelatorioPDFPronto.Create;
    try
        cdsAgendaProcesso.Data := SDMMestre.ExecuteReader(FiltraDataPeriodo +
                                  ' where AGENDA_PROCESSO.DATA_AGENDAPRO between ' +
                                  QuotedStr(FormatDateTime('mm/dd/yyyy', StrToDate(Valor))) +
                                  ' and ' + QuotedStr(FormatDateTime('mm/dd/yyyy', StrToDate(Valor))) + ' order by DATA_AGENDAPRO, HORA_AGENDAPRO', True);
        Result := GeraRelatorio(cdsAgendaProcesso.Data);
    finally
        cdsAgendaProcesso.Free;
        RelatorioPronto.Free;
    end;
end;
end.
