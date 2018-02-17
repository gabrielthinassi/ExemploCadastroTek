unit classCadMestre;

interface

uses
    Vcl.dialogs;

type
    TclassCadMestre = class
    Table_Fields: array of string;

  private
    fTable_Key: string;
    fTable_Name: string;

  public
    function selectSQL: string;
    //property Table_Fields[index: string]: string read fTable_Field;
    property Table_Name: string read fTable_Name write fTable_Name;
    property Table_Key: string read fTable_Key write fTable_Key;

end;

implementation

{ TCadCliente }

function TclassCadMestre.selectSQL: string;
var
    I: integer;
begin
    Result := 'SELECT' + #13;

    for I := 0 to High(Table_Fields) do
    begin
        Result := Result + Table_Fields[I] + #13;
    end;

    Result := Result + 'FROM ' + Table_Name + #13 +
              'WHERE ' + Table_Key + ' = -1';
end;
end.

