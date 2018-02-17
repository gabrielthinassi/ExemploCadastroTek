unit ClassEndereco_Pessoa;

interface

uses Classes, Db, SysUtils, ClassPaiCadastro, Data.SqlExpr;

type
  TClassEndereco_Pessoa = class(TClassPaiCadastro)
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

class function TClassEndereco_Pessoa.Descricao: string;
begin
  Result := '';
end;

class function TClassEndereco_Pessoa.ParametrosSql: TListaDeParametrosSql;
begin
    SetLength(Result, 1);
    Result[0].Nome := 'ID_PESSOA';
    Result[0].Tipo := ftInteger;
end;

class function TClassEndereco_Pessoa.TabelaPrincipal: string;
begin
  Result := 'ENDERECO_PESSOA';
end;

class function TClassEndereco_Pessoa.CampoChave: string;
begin
  Result := 'ID_ENDERECOPES';
end;

class function TClassEndereco_Pessoa.CamposCadastro: string;
begin
  Result :=
    'ENDERECO_PESSOA.ID_ENDERECOPES,      ' + #13 +
    'ENDERECO_PESSOA.TIPO_ENDERECOPES,    ' + #13 +
    'ENDERECO_PESSOA.RUA_ENDERECOPES,     ' + #13 +
    'ENDERECO_PESSOA.NUMERO_ENDERECOPES,  ' + #13 +
    'ENDERECO_PESSOA.BAIRRO_ENDERECOPES,  ' + #13 +
    'ENDERECO_PESSOA.CIDADE_ENDERECOPES,  ' + #13 +
    'ENDERECO_PESSOA.CEP_ENDERECOPES,     ' + #13 +
    'ENDERECO_PESSOA.UF_ENDERECOPES,      ' + #13 +
    'ENDERECO_PESSOA.ID_PESSOA';
end;

class function TClassEndereco_Pessoa.SQLBaseCadastro: string;
begin
     Result :=
    'select ' + CamposCadastro + #13 +
    'from ENDERECO_PESSOA'     + #13 +
    'where ENDERECO_PESSOA.ID_PESSOA = :ID_PESSOA';
end;

class procedure TClassEndereco_Pessoa.ConfigurarPropriedadesDoCampo(CDS: TDataSet);
var
    I: integer;
    Campo: String;
begin
    for I := 0 to CDS.FieldCount - 1 do
    begin
        Campo := CDS.Fields[I].FieldName;

        with CDS.FieldByName(Campo) do
        if (Campo = 'ID_ENDERECOPES') then
        begin
            Visible := False;
        end
        else if (Campo = 'TIPO_ENDERECOPES') then
        begin
            Visible := False;
        end
        else if (Campo = 'RUA_ENDERECOPES') then
        begin
            DisplayLabel := 'Nome da rua';
            DisplayWidth := 80;
            ConstraintErrorMessage := DisplayLabel + ' deve ser preenchido!';
        end
        else if (Campo = 'NUMERO_ENDERECOPES') then
        begin
            DisplayLabel := 'Número';
            EditMask := MASK_NUMEROS;
        end
        else if (Campo = 'CIDADE_ENDERECOPES') then
        begin
            DisplayLabel := 'Cidade';
        end
        else if (Campo = 'BAIRRO_ENDERECOPES') then
        begin
            DisplayLabel := 'Bairro';
        end
        else if (Campo = 'UF_ENDERECOPES') then
        begin
            DisplayLabel := 'Estado';
            EditMask := MASK_DIGITO;
        end
        else if (Campo = 'CEP_ENDERECOPES') then
        begin
            DisplayLabel := 'CEP';
            EditMask := MASK_CEP;
        end
        else if (Campo = 'ID_PESSOA') then
        begin
            Visible := False;
        end;
    end;
end;

initialization
  RegisterClass(TClassEndereco_Pessoa);

end.

