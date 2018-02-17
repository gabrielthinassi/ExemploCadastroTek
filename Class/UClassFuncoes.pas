unit UClassFuncoes;

interface

uses
    Winapi.Windows, Winapi.Messages, System.SysUtils, Vcl.Dialogs,
    Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client, System.Classes, Vcl.Forms, frxClass, System.Variants;

const
    {
    0 = Não salva o "_" no banco de dados.
    1 = Salva o "_" no banco de dados.
    }
    MASK_CEP: string = '99\.999\-999;0;_';
    MASK_RG: string = '999\.999\.999;1;_';
    MASK_CPF: string = '999\.999\.999\-99;1;_';
    MASK_CNPJ: string = '999\.999\.999\/9999\-99;1;_';
    MASK_TELEFONE: string = '\(99\) 9999\-9999;1;_';
    MASK_CELULAR: string = '\(99\) 9 9999\-9999;1;_';
    MASK_PLACA: string = 'LLL\-9999;1';
    MASK_IE: string = '999999999999;0;';
    MASK_DIGITO: string = 'LL;0;_';
    MASK_NUMEROS: string = '999999999999999;0;';
    MASK_MUNICIPIO: string = '99999999;0;_';
    MASK_NUMEROS_PEQUENOS: string = '999999999;0;';
    MASK_DATA_HORA: string = '99/99/9999 !99:99:99;1;_';
    MASK_TIME: string = '99:99;1;';

//Avisos e Erros
procedure MensagemAviso(Mensagem: string);
procedure MensagemErro(Mensagem: string);
procedure MensagemInformacao(Mensagem: string);

function Tela(Dono, Formulario: TForm; ClassFormulario: TFormClass; Modal: Boolean; Sender: TObject = nil): TFormClass;
procedure PosicionaQuebras(FRX: TfrxReport; NomeQuebra, InicioGrupo: String);
procedure LerRecursoDLL(const NomeRecurso, NomeDLL: string; out Retorno: TMemoryStream);
function PadC(sString: string; iLength: Integer; delimitador: Char = ' '): string;
function PadL(sString: string; iLength: Integer; delimitador: Char = ' '): string;
function PadR(sString: string; iLength: Integer; delimitador: Char = ' '): string;
function replicate(pString: string; xWidth: Integer): string;
function _Left(sString: string; iLength: Integer): string;
function iif(Condicao: Boolean; RetornaTrue, RetornaFalse: Variant): Variant;
function StrZero(xValue: extended; xWidth: Integer; xDecimals: Integer = 0): string;
function Right(pString: string; xWidth: Integer): string;

// Arredondamentos
function ArredondaValorHora(Valor: Double): Double;

// Criptografia
Function Criptografa(texto: string; chave: Integer): String;
Function DesCriptografa(texto: string; chave: Integer): String;

// ASCII
function AsciiToInt(Caracter: Char): Integer;

// Data e hora
function DataExtensoSimples(Data: TDateTime): string;
function MesExtenso(Mes: Byte): string;

type
    ClassFuncoes = class
    private
        class function ProximoCod: string;
        class function PegaInicioQuebra(FRX: TfrxReport; InicioGrupo: String): Double;
    public
        class function AutoIncremento(NomeTab: string): Integer;
        class function SelecionaAutoIncremento(NomeTab: string): Integer;
        class procedure GravaAutoIncremento(NomeTab: string; Codigo: Integer);
        class function DiretorioTempAplicao: string;
        class function MemoryStreamToOleVariant(Strm: TMemoryStream): OleVariant;
        class procedure OleVariantParaStream(const Valor: OleVariant; Stream: TStream);
    end;

implementation

{ TClassFuncoes }

var
    TempStream: TMemoryStream;

    // Seleciona e grava na tabela AUTOINCREMENTO o próximo código.
class function ClassFuncoes.AutoIncremento(NomeTab: string): Integer;
var
    Query: TFDQuery;
    AutoInc: Integer;
begin
    AutoInc := 1;

    Query := TFDQuery.Create(nil);
    //Query.Connection := dm_ConexaoBD.conConexao;
    Query.Close;
    Query.SQL.Add(ProximoCod);
    Query.Params.ParamByName('NOMETAB').DataType := ftString;
    Query.ParamByName('NOMETAB').Value := NomeTab;
    Query.open;

    if Query.FieldByName('AUTOINC').AsInteger = 0 then
    begin
        Query.Append;
        Query.FieldByName('NOMETABELA').Value := NomeTab;
        Query.FieldByName('AUTOINC').Value := AutoInc;
        Query.Post;
    end
    else
    begin
        AutoInc := Query.FieldByName('AUTOINC').AsInteger;
        Inc(AutoInc);
        Query.Edit;
        Query.FieldByName('NOMETABELA').Value := NomeTab;
        Query.FieldByName('AUTOINC').Value := AutoInc;
        Query.Post;
    end;
    Query.Free;
    Result := AutoInc;
end;

// Selecionar próximo código.
class function ClassFuncoes.SelecionaAutoIncremento(NomeTab: string): Integer;
var
    Query: TFDQuery;
begin
    Query := TFDQuery.Create(nil);
    //Query.Connection := dm_ConexaoBD.conConexao;
    Query.Close;
    Query.SQL.Add(ProximoCod);
    Query.Params.ParamByName('NOMETAB').DataType := ftString;
    Query.ParamByName('NOMETAB').Value := NomeTab;
    Query.open;

    Result := Query.FieldByName('AUTOINC').AsInteger + 1;
    Query.Free;

end;

// Grava o autoincremento
class procedure ClassFuncoes.GravaAutoIncremento(NomeTab: string; Codigo: Integer);
var
    Query: TFDQuery;
begin

    Query := TFDQuery.Create(nil);
    //Query.Connection := dm_ConexaoBD.conConexao;
    Query.Close;
    Query.SQL.Add(ProximoCod);
    Query.Params.ParamByName('NOMETAB').DataType := ftString;
    Query.ParamByName('NOMETAB').Value := NomeTab;
    Query.open;

    if Query.FieldByName('AUTOINC').AsInteger = 0 then
    begin
        Query.Append;
        Query.FieldByName('NOMETABELA').AsString := NomeTab;
        Query.FieldByName('AUTOINC').AsInteger := Codigo;
        Query.Post;
    end
    else
    begin
        Query.Edit;
        Query.FieldByName('AUTOINC').Value := Codigo;
        Query.Post;
    end;

    Query.Close;
    Query.Free;
end;

class function ClassFuncoes.ProximoCod: string;
begin
    Result := 'SELECT' + ' NOMETABELA,' + ' AUTOINC' + ' FROM AUTOINCREMENTO' + ' WHERE NOMETABELA = :NOMETAB';
end;

procedure MensagemAviso(Mensagem: string);
begin
    MessageDlg(Mensagem, mtWarning, [mbOK], 0);
end;

procedure MensagemInformacao(Mensagem: string);
begin
    MessageDlg(Mensagem, mtInformation, [mbOK], 0);
end;

procedure MensagemErro(Mensagem: string);
begin
    MessageDlg(Mensagem, mtError, [mbOK], 0);
end;

// Faz tratamento das telas quando minimizar a maximizar.
// ---------------------------------------------------------------------------------
function Tela(Dono, Formulario: TForm; ClassFormulario: TFormClass; Modal: Boolean; Sender: TObject = nil): TFormClass;
begin
    Formulario := nil;

    if not Assigned(Formulario) then
        Formulario := TFormClass(ClassFormulario).Create(Dono);

    with Formulario do
    begin
        if WindowState = wsMinimized then
            WindowState := wsNormal;
        if Modal then
        begin
            FormStyle := fsNormal;
            ShowModal;
            Result := nil;
        end
        else
        begin
            if DebugHook = 0 then
                Formulario.FormStyle := fsStayOnTop;
            Show;
            Result := TFormClass(Formulario);
        end;
    end;
end;

procedure PosicionaQuebras(FRX: TfrxReport; NomeQuebra, InicioGrupo: String);
var
    X: Integer;
    PosQuebra: Double;
    ComponenteFRX: TfrxComponent;

    procedure DefinePosicao(AddVisible: Boolean = True);
    begin
        if (ComponenteFRX <> nil) then
            if (ComponenteFRX is TfrxGroupHeader) then
            begin
                if (AddVisible) then
                    (ComponenteFRX as TfrxGroupHeader).Visible := True;
                (ComponenteFRX as TfrxGroupHeader).Top := PosQuebra - 0.01;
            end;
    end;

begin
    PosQuebra := ClassFuncoes.PegaInicioQuebra(FRX, InicioGrupo);
    with FRX do
    begin
        ComponenteFRX := FRX.FindObject(NomeQuebra);
        DefinePosicao;
    end;
end;

class function ClassFuncoes.PegaInicioQuebra(FRX: TfrxReport; InicioGrupo: String): Double;
var
    ComponenteFRX: TfrxComponent;

begin
    ComponenteFRX := FRX.FindObject(InicioGrupo);
    Result := (ComponenteFRX as TfrxGroupHeader).Top;
end;

// Ler DLL
procedure LerRecursoDLL(const NomeRecurso, NomeDLL: string; out Retorno: TMemoryStream);
var
    RS: TResourceStream;
    S: string;
    DLL_Handle: THandle;
    Aberta: Boolean;
begin
    // Lê recursos armazenados na DLL
    if (not Assigned(Retorno)) or (Retorno = nil) then
        raise Exception.Create('Retorno para procedimento LerRecursoDLL não definido ou não criado.');

    S := ChangeFileExt(NomeDLL, '.DLL');
    DLL_Handle := LoadLibrary({$IFDEF VER185}PAnsiChar{$ELSE}PWideChar{$ENDIF}(S));
    try
        Aberta := DLL_Handle <> HINSTANCE_ERROR;
        if (not Aberta) or (DLL_Handle = 0) then
        begin
            MensagemAviso('DLL ' + S + ' não encontrada, favor verificar.');
            Exit;
        end;
        RS := TResourceStream.Create(DLL_Handle, NomeRecurso, RT_RCDATA);
        try
            if RS.Size <> 0 then
                Retorno.LoadFromStream(RS);
        finally
            FreeAndNil(RS);
        end;
    finally
        FreeLibrary(DLL_Handle);
    end;
end;

function PadL(sString: string; iLength: Integer; delimitador: Char = ' '): string;
begin
    Result := iif(iLength > Length(sString), replicate(delimitador, (iLength - Length(sString))), '') + Copy(sString, 1, iLength);
end;

function PadR(sString: string; iLength: Integer; delimitador: Char = ' '): string;
begin
    Result := Copy(sString, 1, iLength) + replicate(delimitador, (iLength - Length(sString)));
end;

function PadC(sString: string; iLength: Integer; delimitador: Char = ' '): string;
begin
    Result := _Left(replicate(delimitador, (iLength - Length(sString)) div 2) + sString + replicate(delimitador, (iLength - Length(sString)) div 2 + 2), iLength);
end;

function replicate(pString: string; xWidth: Integer): string;
var
    nCount: Integer;
    pStr: string;
begin
    pStr := '';
    for nCount := 1 to xWidth do
        pStr := pStr + pString;
    Result := pStr;
end;

function _Left(sString: string; iLength: Integer): string;
begin
    Result := Copy(sString, 1, iLength);
end;

function iif(Condicao: Boolean; RetornaTrue, RetornaFalse: Variant): Variant;
begin
    if Condicao then
        Result := RetornaTrue
    else
        Result := RetornaFalse;
end;

function AsciiToInt(Caracter: Char): Integer;
var
    i: Integer;
begin
    i := 32;
    while i < 255 do
    begin
        if Chr(i) = Caracter then
            Break;
        i := i + 1;
    end;
    Result := i;
end;

Function Criptografa(texto: string; chave: Integer): String;
var
    cont: Integer;
    Retorno: string;
begin
    if (trim(texto) = EmptyStr) or (chave = 0) then
    begin
        Result := texto;
    end
    else
    begin
        Retorno := '';
        for cont := 1 to Length(texto) do
        begin
            Retorno := Retorno + Chr(AsciiToInt(texto[cont]) + chave);
        end;
        Result := Retorno;
    end;
end;

Function DesCriptografa(texto: string; chave: Integer): String;
var
    cont: Integer;
    Retorno: string;
begin
    if (trim(texto) = EmptyStr) or (chave = 0) then
    begin
        Result := texto;
    end
    else
    begin
        Retorno := '';
        for cont := 1 to Length(texto) do
        begin
            Retorno := Retorno + Chr(AsciiToInt(texto[cont]) - chave);
        end;
        Result := Retorno;
    end;
end;

function ArredondaValorHora(Valor: Double): Double;
var
    Inteiro: Integer;
    Decimais: Double;
begin
    Inteiro := Trunc(Valor);
    Decimais := Valor - Inteiro;

    if (Decimais > 0.00) and (Decimais < 0.50) then
        Result := Inteiro + 0.50
    else if (Decimais >= 0.50) and (Decimais < 1.00) then
        Result := Inteiro + 1
    else
        Result := Valor;
end;

function DataExtensoSimples(Data: TDateTime): string;
var
    Dia, Mes, Ano: Word;
begin
    DecodeDate(Data, Ano, Mes, Dia);
    Result := IntToStr(Dia) + ' de ' + MesExtenso(Mes) + ' de ' + StrZero(Ano, 4, 0);
end;

function MesExtenso(Mes: Byte): string;
const
    Meses: array [1 .. 12] of string = ('Janeiro', 'Fevereiro', 'Março', 'Abril', 'Maio', 'Junho', 'Julho', 'Agosto', 'Setembro', 'Outubro', 'Novembro', 'Dezembro');
begin
    if (Mes < 1) or (Mes > 12) then
        raise Exception.Create('Mês informado para a função MesExtenso fora da faixa: ' + IntToStr(Mes));
    if (Mes in [1 .. 12]) then
        Result := Meses[Mes]
    else
        Result := '';
end;

function StrZero(xValue: extended; xWidth: Integer; xDecimals: Integer = 0): string;
var
    SValue: ShortString;
begin
    Result := FloatToStr(xValue);
    if Length(Result) > xWidth then
        Exit;
    System.str(xValue: xWidth: xDecimals, SValue);
    Result := trim(string(SValue));
    if xValue < 0 then
    begin
        xWidth := xWidth - 1;
        Delete(Result, Pos('-', Result), 1);
        Result := '-' + Right(replicate('0', xWidth) + Result, xWidth);
    end
    else
        Result := Right(replicate('0', xWidth) + Result, xWidth);
end;

function Right(pString: string; xWidth: Integer): string;
begin
  Result := Copy(pString, Length(pString) - xWidth + 1, xWidth);
end;

class function ClassFuncoes.DiretorioTempAplicao: string;
var
    Diretorio: string;
begin
    Diretorio := ExtractFilePath(Application.ExeName) + 'TEMP\';

    try
        if not DirectoryExists(Diretorio) then
            CreateDir(Diretorio);

        Result := Diretorio;
    except
          raise Exception.Create('Diretório temporário não pode ser criado.');
    end;

end;

class function ClassFuncoes.MemoryStreamToOleVariant(Strm: TMemoryStream): OleVariant;
var
    Data: PByteArray;
begin
    Result := VarArrayCreate ([0, Strm.Size - 1], varByte);
    Data := VarArrayLock(Result);
    try
        Strm.Position := 0;
        Strm.ReadBuffer(Data^, Strm.Size);
    finally
        VarArrayUnlock(Result);
    end;
end;

class procedure ClassFuncoes.OleVariantParaStream(const Valor: OleVariant; Stream: TStream);
var
  P: Pointer;
  L: Integer;
begin
  L               := VarArrayHighBound(Valor, 1) - VarArrayLowBound(Valor, 1) + 1;
  Stream.Size     := L;
  Stream.Position := 0;
  P               := VarArrayLock(Valor);
  try
    Stream.Write(P^, Stream.Size);
  finally
    VarArrayUnlock(Valor);
    Stream.Position := 0;
  end;
end;
end.
