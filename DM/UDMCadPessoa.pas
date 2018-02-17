unit UDMCadPessoa;

interface

uses
  System.SysUtils, System.Classes, UdmCadPai, Data.DB, Datasnap.DBClient,
  Datasnap.DSConnect,

  ClassPessoa,
  ClassEndereco_Pessoa,
  ClassTelefone_Pessoa;

type
  TdmCadPessoa = class(TdmCadPai)
    cdsEndereco: TClientDataSet;
    cdsTelefone: TClientDataSet;
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
    procedure cdsCadastroNewRecord(DataSet: TDataSet);
    procedure cdsEnderecoNewRecord(DataSet: TDataSet);
    procedure cdsTelefoneNewRecord(DataSet: TDataSet);
    procedure cdsEnderecoAfterDelete(DataSet: TDataSet);
    procedure cdsTelefoneAfterDelete(DataSet: TDataSet);
    procedure cdsCadastroAfterOpen(DataSet: TDataSet);
  private
    ClassEndPessoa: TClassEndereco_Pessoa;
    ClassTelPessoa: TClassTelefone_Pessoa;
    FProxCodEnd: integer;
    FProxCodTelefone: integer;
    procedure OnValidateFisJur(Sender: TField);
    property ProxCodEnd: integer read FProxCodEnd write FProxCodEnd;
    property ProxCodTelefone: integer read FProxCodTelefone write FProxCodTelefone;
    function ProximoCodigoTelefone: integer;
    function ProximoCodigoEndereco: integer;
  public
    function AutoInc: integer;
  protected

  end;

var
  dmCadPessoa: TdmCadPessoa;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

uses UdmConexaoPai, UClassFuncoes;

{$R *.dfm}

procedure TdmCadPessoa.cdsCadastroAfterOpen(DataSet: TDataSet);
begin
  inherited;
    cdsEndereco.DataSetField := TDataSetField(cdsCadastro.FieldByName('sqlEndereco'));
    cdsTelefone.DataSetField := TDataSetField(cdsCadastro.FieldByName('sqlTelefone'));

    ClassEndPessoa.ConfigurarPropriedadesDoCampo(cdsEndereco);
    ClassTelPessoa.ConfigurarPropriedadesDoCampo(cdsTelefone);

    cdsCadastro.FieldByName('FIS_JUR_PESSOA').OnChange := OnValidateFisJur;
    //cdsCadastro.FieldByName('CNPJ_CPF_PESSOA').OnGetText := OnValidateValueFisJur;
end;

procedure TdmCadPessoa.cdsCadastroNewRecord(DataSet: TDataSet);
begin
  inherited;
    DataSet.FieldByName('FIS_JUR_PESSOA').AsInteger := 0;
    DataSet.FieldByName('TIPO_PESSOA').AsInteger := cCliente;

    ProximoCodigo := dmConexaoPai.ExecuteMethods('TSDMMestre.ProximoCodigo',
                      [FClassFilha.TabelaPrincipal, FClassFilha.CampoChave]);
    DataSet.FieldByName(FClassFilha.CampoChave).AsInteger := FProximoCodigo;
end;

procedure TdmCadPessoa.cdsEnderecoAfterDelete(DataSet: TDataSet);
begin
  inherited;
    cdsCadastro.Edit;
end;

procedure TdmCadPessoa.cdsEnderecoNewRecord(DataSet: TDataSet);
begin
  inherited;
    DataSet.FieldByName('ID_ENDERECOPES').AsInteger := ProximoCodigoEndereco;
    DataSet.FieldByName('TIPO_ENDERECOPES').AsInteger := 0;
end;

procedure TdmCadPessoa.cdsTelefoneAfterDelete(DataSet: TDataSet);
begin
  inherited;
    cdsCadastro.Edit;
end;

procedure TdmCadPessoa.cdsTelefoneNewRecord(DataSet: TDataSet);
begin
  inherited;
    DataSet.FieldByName('ID_TELEFONE').AsInteger := ProximoCodigoTelefone;
end;

procedure TdmCadPessoa.DataModuleCreate(Sender: TObject);
begin
    FProxCodEnd := 0;
    FProxCodTelefone := 0;
    FClassFilha := TClassPessoa;

    ClassEndPessoa := TClassEndereco_Pessoa.Create;
    ClassTelPessoa := TClassTelefone_Pessoa.Create;

    dspCadastro.ServerClassName := 'TSDMCadPessoa';
    cdsCadastro.ProviderName := 'dspCadastro';

    inherited;
end;

procedure TdmCadPessoa.DataModuleDestroy(Sender: TObject);
begin
  inherited;
    ClassEndPessoa.Free;
    ClassTelPessoa.Free;
    cdsCadastro.Close;
end;

procedure TdmCadPessoa.OnValidateFisJur(Sender: TField);
begin
    with cdsCadastro do
    begin
        if Sender.Value = 0 then
            FieldByName('CNPJ_CPF_PESSOA').EditMask := MASK_CPF
        else
            FieldByName('CNPJ_CPF_PESSOA').EditMask := MASK_CNPJ;
    end;
end;

function TdmCadPessoa.AutoInc: integer;
begin
    Result := ProximoCodigo;
end;

function TdmCadPessoa.ProximoCodigoEndereco: integer;
begin
    if FProxCodEnd = 0 then
        ProxCodEnd := dmConexaoPai.ExecuteMethods('TSDMMestre.ProximoCodigo',
                       [ClassEndPessoa.TabelaPrincipal, ClassEndPessoa.CampoChave])
    else
        Inc(FProxCodEnd);
    Result := FProxCodEnd;
end;

function TdmCadPessoa.ProximoCodigoTelefone: integer;
begin
    if FProxCodTelefone = 0 then
        ProxCodTelefone := dmConexaoPai.ExecuteMethods('TSDMMestre.ProximoCodigo',
                            [ClassTelPessoa.TabelaPrincipal, ClassTelPessoa.CampoChave])
    else
        Inc(FProxCodTelefone);
    Result := FProxCodTelefone;
end;
end.
