unit ClassTelefone_Pessoa;

interface

uses Classes, Db, SysUtils, ClassPaiCadastro, Data.SqlExpr;

type
  TClassTelefone_Pessoa = class(TClassPaiCadastro)
  public
    class function Descricao: string; override;
    class function TabelaPrincipal: string; override;
    class function CampoChave: string; override;

    class function CamposCadastro: string; override;
    class function SQLBaseCadastro: string; override;

    class function ParametrosSql: TListaDeParametrosSql; override;
    class procedure ConfigurarPropriedadesDoCampo(CDS: TDataSet); override;
  end;

implementation

uses UClassFuncoes;

class function TClassTelefone_Pessoa.Descricao: string;
begin
  Result := '';
end;

class function TClassTelefone_Pessoa.ParametrosSql: TListaDeParametrosSql;
begin
    SetLength(Result, 1);
    Result[0].Nome := 'ID_PESSOA';
    Result[0].Tipo := ftInteger;
end;

class function TClassTelefone_Pessoa.TabelaPrincipal: string;
begin
  Result := 'TELEFONE_PESSOA';
end;

class function TClassTelefone_Pessoa.CampoChave: string;
begin
  Result := 'ID_TELEFONE';
end;

class function TClassTelefone_Pessoa.CamposCadastro: string;
begin
  Result :=
    'TELEFONE_PESSOA.ID_TELEFONE,      ' + #13 +
    'TELEFONE_PESSOA.NUMERO_TELEFONE,  ' + #13 +
    'TELEFONE_PESSOA.ID_PESSOA';
end;

class function TClassTelefone_Pessoa.SQLBaseCadastro: string;
begin
  Result :=
    'select ' + #13 +
    CamposCadastro + #13 +
    'from TELEFONE_PESSOA' + #13 +
    'where TELEFONE_PESSOA.ID_PESSOA = :ID_PESSOA';
end;

class procedure TClassTelefone_Pessoa.ConfigurarPropriedadesDoCampo(CDS: TDataSet);
var
    I: integer;
    Campo: String;
begin
    for I := 0 to CDS.FieldCount - 1 do
    begin
        Campo := CDS.Fields[I].FieldName;

        with CDS.FieldByName(Campo) do
        if (Campo = 'ID_TELEFONE') then
        begin
            Visible := False;
        end
        else if (Campo = 'NUMERO_TELEFONE') then
        begin
            DisplayLabel := 'Número';
            ConstraintErrorMessage := DisplayLabel + ' deve ser preenchido!';
            EditMask := MASK_CELULAR;
        end
        else if (Campo = 'ID_PESSOA') then
        begin
            Visible := False;
        end;
    end;
end;

initialization
  RegisterClass(TClassTelefone_Pessoa);

end.

