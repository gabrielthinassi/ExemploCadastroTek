unit USDMCadPessoa;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, USDMPaiCadastro, Data.FMTBcd, Data.DB,
  Data.SqlExpr, Datasnap.Provider, Data.DBXFirebird, Datasnap.DBClient,

  ClassPessoa,
  ClassEndereco_Pessoa,
  ClassTelefone_Pessoa;

type
  TSDMCadPessoa = class(TSDMPaiCadastro)
    sqlEndereco: TSQLDataSet;
    dsLink: TDataSource;
    sqlTelefone: TSQLDataSet;
    procedure sqlCadastroAfterOpen(DataSet: TDataSet);
    procedure sqlEnderecoAfterOpen(DataSet: TDataSet);
    procedure sqlTelefoneAfterOpen(DataSet: TDataSet);
    procedure DSServerModuleDestroy(Sender: TObject);
  private
    {ClassEndPessoa: TClassEndereco_Pessoa;
        ClassTelefonePessoa: TClassTelefone_Pessoa;}
  public
    { Public declarations }
  protected
    procedure DSServerCreate_Filha(Sender:TObject); override;
  end;

var
  SDMCadPessoa: TSDMCadPessoa;

implementation

{$R *.dfm}

{ TSDMCadPessoa }

procedure TSDMCadPessoa.DSServerCreate_Filha(Sender: TObject);
begin
    inherited;
    FClassFilha := TClassPessoa;
    {ClassEndPessoa := TClassEndereco_Pessoa.Create;
        ClassTelefonePessoa := TClassTelefone_Pessoa.Create;}

    sqlEndereco.CommandText := TClassEndereco_Pessoa.SQLBaseCadastro;
    TClassEndereco_Pessoa.CriarParametros(sqlEndereco);
    sqlEndereco.DataSource := dsLink;

    sqlTelefone.CommandText := TClassTelefone_Pessoa.SQLBaseCadastro;
    TClassTelefone_Pessoa.CriarParametros(sqlTelefone);
    sqlTelefone.DataSource := dsLink;

end;

procedure TSDMCadPessoa.DSServerModuleDestroy(Sender: TObject);
begin
  inherited;
    {ClassEndPessoa.Free;
        ClassTelefonePessoa.Free;}
end;

procedure TSDMCadPessoa.sqlCadastroAfterOpen(DataSet: TDataSet);
begin
  inherited;
    SetaProviderFlag(sqlCadastro, FClassFilha.CampoChave);
end;

procedure TSDMCadPessoa.sqlEnderecoAfterOpen(DataSet: TDataSet);
begin
  inherited;
    SetaProviderFlag(sqlEndereco, TClassEndereco_Pessoa.CampoChave);
end;

procedure TSDMCadPessoa.sqlTelefoneAfterOpen(DataSet: TDataSet);
begin
  inherited;
    SetaProviderFlag(sqlTelefone, TClassTelefone_Pessoa.CampoChave);
end;

end.
