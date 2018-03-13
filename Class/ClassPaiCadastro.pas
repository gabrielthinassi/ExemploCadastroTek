unit ClassPaiCadastro;

interface

uses Classes, DB, SysUtils, DBClient, StrUtils, Variants, FMTBcd, Controls, SqlTimSt, SqlExpr, TypInfo, Rtti,
  ClassPai;

type
  //TRotuloDescricao = record
  //  Name: String;
  //  Index: Integer;
  //end;
  //TListaDeRotuloDescricao = array of TRotuloDescricao;

  TParametrosSql = record
    Nome: String;
    Tipo: TFieldType;
    Valor: Integer;
  end;
  TListaDeParametrosSql = array of TParametrosSql;

type
  TClassPaiCadastro = class(TClassPai)
  public
    class function Descricao: string; virtual;
    class function TabelaPrincipal: string; virtual;

    class function CampoChave: string; virtual;

    class function CamposCadastro: string; virtual;
    class function SQLBaseCadastro: string; virtual;
    class function SQLBaseConsulta: string; virtual;

    class function ParametrosSql: TListaDeParametrosSql; virtual;

    class function CamposConsulta(Lista, Campos: TStrings): TStrings; virtual;

    class function CriarParametros(ASQLDataSet: TSQLDataSet): string;

    class procedure ConfigurarPropriedadesDoCampo(CDS: TDataSet); virtual;
  end;

  TFClassPaiCadastro = class of TClassPaiCadastro;

implementation

class function TClassPaiCadastro.Descricao: string;
begin
  Result := '';
end;

class function TClassPaiCadastro.ParametrosSql: TListaDeParametrosSql;
begin
  SetLength(Result, 0);

  { Exemplo de como passar parametro. É realizado na classe filha.

    SetLength(Result, 1);
    Result[0].Nome := 'cod';
    Result[0].Tipo := ftInteger}
end;

class function TClassPaiCadastro.TabelaPrincipal: string;
begin
  Result := '';
end;

class function TClassPaiCadastro.CriarParametros(ASQLDataSet: TSQLDataSet): string;
var
  Parametros: TListaDeParametrosSql;
  i: integer;
begin
  Parametros := Self.ParametrosSql;
  if Length(Parametros) > 0 then
  begin
     ASQLDataSet.Params.Clear;
     for i := Low(Parametros) to High(Parametros) do
     begin
       with TParam(ASQLDataSet.Params.Add) do
       begin
         Name := Parametros[i].Nome;
         DataType := Parametros[i].Tipo;
         ParamType := ptInput;
       end;
     end;
  end;
end;

class function TClassPaiCadastro.CamposCadastro: string;
begin
  Result := '';
end;

class function TClassPaiCadastro.CamposConsulta(Lista, Campos: TStrings): TStrings;
begin
    //
end;

class procedure TClassPaiCadastro.ConfigurarPropriedadesDoCampo(CDS: TDataSet);
begin
    //
end;

class function TClassPaiCadastro.CampoChave: string;
begin
  Result := '';
end;

class function TClassPaiCadastro.SQLBaseCadastro: string;
begin
    Result := '';
end;

class function TClassPaiCadastro.SQLBaseConsulta: string;
begin
  Result := '';
end;
end.

