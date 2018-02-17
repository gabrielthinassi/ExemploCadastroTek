unit UfrmConfigServer;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Buttons, IniFiles;

type
  TfrmConfigServer = class(TForm)
    edtServidor: TEdit;
    btnGravar: TSpeedButton;
    btnTestar: TSpeedButton;
    Label1: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnTestarClick(Sender: TObject);
  private
    const NomeArquivoConfig = 'ClientConfig.ini';
  public
    { Public declarations }
  end;

var
  frmConfigServer: TfrmConfigServer;

implementation

{$R *.dfm}

uses UdmConexaoPai, UClassFuncoes;

procedure TfrmConfigServer.btnGravarClick(Sender: TObject);
var
    INI: TiniFile;
begin
    INI := TIniFile.Create(ExtractFilePath(Application.ExeName) + NomeArquivoConfig);
    INI.WriteString('Configuracao', 'Servidor', edtServidor.Text);
    INI.Free;
    Close;
end;

procedure TfrmConfigServer.btnTestarClick(Sender: TObject);
begin
    if dmConexaoPai.TestaConexao(edtServidor.Text) then
        MensagemInformacao('Conexão efetuada com sucesso!');
end;

procedure TfrmConfigServer.FormClose(Sender: TObject; var Action: TCloseAction);
begin
    Action := caFree;
end;

procedure TfrmConfigServer.FormCreate(Sender: TObject);
var
    INI: TiniFile;
begin
    INI := TIniFile.Create(ExtractFilePath(Application.ExeName) + NomeArquivoConfig);
    edtServidor.Text := INI.ReadString('Configuracao', 'Servidor', 'localhost');
    INI.Free;
end;
end.
