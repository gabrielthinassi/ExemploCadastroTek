unit classCadCliente;

interface

uses classCadMestre;

type
    TclassCadCliente = class(TclassCadMestre)

    public
        // Usado para atribuir fields antes do construtor da classe.
        procedure AfterConstruction; override;
end;

implementation

{ TclassCadCliente }

procedure TclassCadCliente.AfterConstruction;
begin
  inherited;
    Table_Name := 'CLIENTE';
    Table_Key := 'ID_CLI';

    SetLength(Table_Fields, 2);
    Table_Fields[0] := 'ID_CLI,';
    Table_Fields[1] := 'NOME_CLI';
end;
end.

