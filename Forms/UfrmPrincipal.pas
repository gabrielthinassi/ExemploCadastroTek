unit UfrmPrincipal;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Menus, JvComponentBase,
  Vcl.ExtCtrls, JvExExtCtrls, JvExtComponent, JvPanel, Vcl.Imaging.pngimage,
  JvImage, JvBalloonHint, System.DateUtils, Vcl.ComCtrls, JvExComCtrls,
  JvStatusBar;

type
  TfrmPrincipal = class(TForm)
    MainMenu1: TMainMenu;
    Cadastros1: TMenuItem;
    Configuraes1: TMenuItem;
    Servidordeaplicao1: TMenuItem;
    Cliente1: TMenuItem;
    jvpnl1: TJvPanel;
    Sair1: TMenuItem;
    N1: TMenuItem;
    jvblnhnt1: TJvBalloonHint;
    jvstsbr: TJvStatusBar;
    procedure Servidordeaplicao1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Cliente1Click(Sender: TObject);
    procedure Sair1Click(Sender: TObject);
  private

  public
    { Public declarations }
  end;

var
  frmPrincipal: TfrmPrincipal;

implementation

{$R *.dfm}

uses UClassFuncoes, UfrmConfigServer, UdmConexaoPai , UfrmCadPessoa;

procedure TfrmPrincipal.Cliente1Click(Sender: TObject);
begin
    frmCadPessoa := TfrmCadPessoa(Tela(Self, frmCadPessoa, TfrmCadPessoa, False, Sender));
end;

procedure TfrmPrincipal.FormClose(Sender: TObject; var Action: TCloseAction);
begin
    FreeAndNil(dmConexaoPai);
    Action := caFree;
end;

procedure TfrmPrincipal.FormCreate(Sender: TObject);
begin
    dmConexaoPai := TdmConexaoPai.Create(Self);
end;

procedure TfrmPrincipal.Sair1Click(Sender: TObject);
begin
    frmPrincipal.Close;
end;

procedure TfrmPrincipal.Servidordeaplicao1Click(Sender: TObject);
begin
    frmConfigServer := TfrmConfigServer(Tela(Self, frmConfigServer, TfrmConfigServer, False, Sender));
end;

end.
