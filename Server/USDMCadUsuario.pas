unit USDMCadUsuario;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, USDMPaiCadastro, Data.FMTBcd, Data.DB,
  Data.SqlExpr, Datasnap.Provider;

type
  TSDMCadUsuario = class(TSDMPaiCadastro)
    sqlUsuario: TSQLDataSet;
    dspUsuario: TDataSetProvider;
    procedure sqlCadastroAfterOpen(DataSet: TDataSet);
    procedure dspUsuarioBeforeGetRecords(Sender: TObject;
      var OwnerData: OleVariant);
  private
    { Private declarations }
  public
    { Public declarations }
  protected
    procedure DSServerCreate_Filha(Sender:TObject); override;
  end;

var
  SDMCadUsuario: TSDMCadUsuario;

implementation

{$R *.dfm}

uses ClassUsuario;

{ TSDMPaiCadastro1 }

procedure TSDMCadUsuario.dspUsuarioBeforeGetRecords(Sender: TObject;
  var OwnerData: OleVariant);
var
    SQL, Usuario, Senha: string;
begin
    if VarIsArray(OwnerData) and (VarArrayHighBound(OwnerData, 1) = 1) then
    begin
        Usuario := OwnerData[0];
        Senha := OwnerData[1];

        SQL := 'select DESCRICAO_USER, SENHA_USER from USUARIO where DESCRICAO_USER = ' + QuotedStr(Usuario) +
               ' and SENHA_USER = ' + QuotedStr(Senha);

        sqlUsuario.CommandText := SQL;
    end;
end;

procedure TSDMCadUsuario.DSServerCreate_Filha(Sender: TObject);
begin
    FClassFilha := TClassUsuario;
  inherited;
end;

procedure TSDMCadUsuario.sqlCadastroAfterOpen(DataSet: TDataSet);
begin
  inherited;
    SetaProviderFlag(sqlCadastro, FClassFilha.CampoChave);
end;

end.
