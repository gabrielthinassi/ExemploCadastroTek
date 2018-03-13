unit ClassPessoa;

interface

uses Classes, Db, SysUtils, ClassPaiCadastro, Data.SqlExpr, Data.DBConsts;

const
    cCliente = 0;
    cOponente = 1;
    cAdvogado = 2;
    cadvogadoOponente = 3;

    {DescricaoTipo: array [0 .. 3] of TRotuloDescricao = ((Name: 'Cliente';
      Index: cCliente), (Name: 'Oponente'; Index: cOponente), (Name: 'Advogado';
      Index: cAdvogado), (Name: 'Advogado Oponente'; Index: cadvogadoOponente));

    DescricaoPessoa: array [0 .. 1] of TRotuloDescricao = ((Name: 'Física';
      Index: 0), (Name: 'Jurídica'; Index: 1));
     }
type
    TClassPessoa = class(TClassPaiCadastro)
    public
        class function Descricao: string; override;
        class function TabelaPrincipal: string; override;
        class function CampoChave: string; override;

        class function CamposCadastro: string; override;
        class function SQLBaseConsulta: string; override;
        class function SQLBaseCadastro: string; override;

        class function SQLBaseGeral: string;

        class function ParametrosSql: TListaDeParametrosSql; override;
        class function CamposConsulta(Lista, Campos: TStrings): TStrings; override;
        class procedure ConfigurarPropriedadesDoCampo(CDS: TDataSet); override;
    end;

implementation

uses UClassFuncoes;

class function TClassPessoa.Descricao: string;
begin
    Result := 'Pessoa';
end;

class function TClassPessoa.ParametrosSql: TListaDeParametrosSql;
var
  Parametros: TListaDeParametrosSql;
begin
    SetLength(Parametros, 1);
    Parametros[0].Nome := 'cod';
    Parametros[0].Tipo := ftInteger;

    Result := Parametros;
end;

class function TClassPessoa.TabelaPrincipal: string;
begin
    Result := 'PESSOA';
end;

class function TClassPessoa.CampoChave: string;
begin
    Result := 'ID_PESSOA';
end;

class function TClassPessoa.CamposCadastro: string;
begin
    Result := 'PESSOA.ID_PESSOA,        ' + #13 +
      'PESSOA.RAZAOSOCIAL_PESSOA,       ' + #13 +
      'PESSOA.CNPJ_CPF_PESSOA,          ' + #13 +
      'PESSOA.FIS_JUR_PESSOA,           ' + #13 +
      'PESSOA.TIPO_PESSOA,              ' + #13 +
      'PESSOA.PROFISSAO_PESSOA,         ' + #13 +
      'PESSOA.EMAIL_PESSOAL_PESSOA,     ' + #13 +
      'PESSOA.EMAIL_COMERCIAL_PESSOA,   ' + #13 +
      'PESSOA.OBSERVACOES_PESSOA';
end;

class function TClassPessoa.CamposConsulta(Lista, Campos: TStrings): TStrings;
begin
    Lista.Add('Código');
    Lista.Add('Nome/Razão Social');
    Lista.Add('CNPJ/CPF');
    Lista.Add('Profissão');

    Campos.Add('ID_PESSOA');
    Campos.Add('RAZAOSOCIAL_PESSOA');
    Campos.Add('CNPJ_CPF_PESSOA');
    Campos.Add('PROFISSAO_PESSOA');

    Result := Lista;
end;

class function TClassPessoa.SQLBaseCadastro: string;
begin
    Result := 'select' + #13 +
               CamposCadastro + #13 +
              'from PESSOA' + #13 +
              'where PESSOA.ID_PESSOA = :cod';
end;

class function TClassPessoa.SQLBaseConsulta: string;
begin
    Result := 'select' + #13 +
      'PESSOA.ID_PESSOA as "Código",' + #13 +
      'PESSOA.RAZAOSOCIAL_PESSOA as "Nome/Razão Social",' + #13 +
      'PESSOA.CNPJ_CPF_PESSOA as "CNPJ/CPF",' + #13 +
      'PESSOA.PROFISSAO_PESSOA as "Profissão",' + #13 +
      'PESSOA.EMAIL_PESSOAL_PESSOA as "E-mail"' + #13 +
      'from PESSOA';
end;

class function TClassPessoa.SQLBaseGeral: string;
begin
    Result := 'select' + #13 +
        'PESSOA.RAZAOSOCIAL_PESSOA' + #13 +
        'from PESSOA' + #13 +
        'where PESSOA.ID_PESSOA = :cod';
end;

class procedure TClassPessoa.ConfigurarPropriedadesDoCampo(CDS: TDataSet);
var
    I: integer;
    Campo: String;
begin
    for I := 0 to CDS.FieldCount - 1 do
    begin
        Campo := CDS.Fields[I].FieldName;

        with CDS.FieldByName(Campo) do
            if (Campo = 'RAZAOSOCIAL_PESSOA') then
            begin
                DisplayLabel := 'Nome/Razão social';
            end
            else if (Campo = 'CNPJ_CPF_PESSOA') then
            begin
                DisplayLabel := 'CNPJ ou CPF';
            end
            else if (Campo = 'TIPO_PESSOA') then
            begin
                DisplayLabel := 'Tipo de pessoa';
            end;
    end;
end;

initialization

  RegisterClass(TClassPessoa);

end.
