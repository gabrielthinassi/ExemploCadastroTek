unit UfrmConfigdatabase;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Grids, Vcl.ValEdit, Vcl.ExtCtrls,
  Vcl.Buttons;

type
  TfrmConfigDatabase = class(TForm)
    lstDatabase: TValueListEditor;
    Panel1: TPanel;
    btnGravar: TSpeedButton;
    procedure FormCreate(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
  private
    const NomeConfigIni = 'ServerConfig.ini';
    var CaminhoConfigIni: string;
    procedure CriarArquivoPadrao;
  public
    { Public declarations }
  end;

var
  frmConfigDatabase: TfrmConfigDatabase;

implementation

{$R *.dfm}

procedure TfrmConfigDatabase.CriarArquivoPadrao;
var
    arq: TextFile;
begin
    AssignFile(arq, CaminhoConfigIni + NomeConfigIni);
    Rewrite(arq);
    Writeln(arq, 'DriverUnit=Data.DBXFirebird');
    Writeln(arq, 'DriverPackageLoader=TDBXDynalinkDriverLoader,DbxCommonDriver220.bpl');
    Writeln(arq, 'DriverAssemblyLoader=Borland.Data.TDBXDynalinkDriverLoader,Borland.Data.DbxCommonDriver,Version=22.0.0.0,Culture=neutral,PublicKeyToken=91d62ebb5b0d1b1b');
    Writeln(arq, 'MetaDataPackageLoader=TDBXFirebirdMetaDataCommandFactory,DbxFirebirdDriver220.bpl');
    Writeln(arq, 'MetaDataAssemblyLoader=Borland.Data.TDBXFirebirdMetaDataCommandFactory,Borland.Data.DbxFirebirdDriver,Version=22.0.0.0,Culture=neutral,PublicKeyToken=91d62ebb5b0d1b1b');
    Writeln(arq, 'Database=database');
    Writeln(arq, 'User_Name=sysdba');
    Writeln(arq, 'Password=masterkey');
    Writeln(arq, 'GetDriverFunc=getSQLDriverINTERBASE');
    Writeln(arq, 'LibraryName=dbxfb.dll');
    Writeln(arq, 'LibraryNameOsx=libsqlfb.dylib');
    Writeln(arq, 'VendorLib=fbclient.dll');
    Writeln(arq, 'VendorLibWin64=fbclient.dll');
    Writeln(arq, 'Role=RoleName');
    Writeln(arq, 'MaxBlobSize=-1');
    Writeln(arq, 'LocaleCode=0000');
    Writeln(arq, 'IsolationLevel=ReadCommitted');
    Writeln(arq, 'SQLDialect=3');
    Writeln(arq, 'CommitRetain=False');
    Writeln(arq, 'WaitOnLocks=True');
    Writeln(arq, 'TrimChar=False');
    Writeln(arq, 'BlobSize=-1');
    Writeln(arq, 'RoleName=RoleName');
    Writeln(arq, 'Trim Char=False');
    CloseFile(arq);
end;


procedure TfrmConfigDatabase.FormCreate(Sender: TObject);
begin
    CaminhoConfigIni := ExtractFilePath(Application.ExeName);
    if not FileExists(CaminhoConfigIni + NomeConfigIni) then
        CriarArquivoPadrao;

    lstDatabase.Strings.LoadFromFile(CaminhoConfigIni + NomeConfigIni);
end;


procedure TfrmConfigDatabase.btnGravarClick(Sender: TObject);
var
    Caminho: string;
begin
    Caminho := ExtractFilePath(Application.ExeName);
    lstDatabase.Strings.SaveToFile(Caminho + NomeConfigIni)
end;

end.
