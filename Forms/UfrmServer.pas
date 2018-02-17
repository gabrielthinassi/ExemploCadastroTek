unit UfrmServer;

interface

uses Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.Buttons, Vcl.Imaging.pngimage, Vcl.AppEvnts,
  Data.SqlExpr, Data.DBXCommon, Vcl.Menus;

type
  TfrmServidor = class(TForm)
    TrayIcon: TTrayIcon;
    ApplicationEvents: TApplicationEvents;
    imgMonitor: TImage;
    Image2: TImage;
    pmServer: TPopupMenu;
    Restaurar1: TMenuItem;
    Fechar1: TMenuItem;
    lblConexoes: TLabel;
    procedure Image2Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure TrayIconDblClick(Sender: TObject);
    procedure ApplicationEventsMinimize(Sender: TObject);
    procedure btnMOnitorClick(Sender: TObject);
    procedure Restaurar1Click(Sender: TObject);
    procedure Fechar1Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmServidor: TfrmServidor;

implementation

{$R *.dfm}

uses UfrmConfigdatabase, scServer, UfrmMonitorSQL;

procedure TfrmServidor.ApplicationEventsMinimize(Sender: TObject);
begin
    Self.Hide;
    Self.WindowState := wsMinimized;
end;

procedure TfrmServidor.btnMOnitorClick(Sender: TObject);
begin
    frmMonitorSQL := TfrmMonitorSQL.Create(Self);
    frmMonitorSQL.Show;
end;

procedure TfrmServidor.Fechar1Click(Sender: TObject);
begin
    Close;
end;

procedure TfrmServidor.FormClose(Sender: TObject; var Action: TCloseAction);
begin
    Action := caFree;
end;

procedure TfrmServidor.FormCreate(Sender: TObject);
begin
    Self.Hide;
    Self.WindowState := wsMinimized;
    lblConexoes.Caption := 'Conexoões: 0';
end;

procedure TfrmServidor.Image2Click(Sender: TObject);
begin
    frmConfigDatabase := TfrmConfigDatabase.Create(Self);
    frmConfigDatabase.ShowModal;
    frmConfigDatabase.FreeOnRelease;
end;


procedure TfrmServidor.Restaurar1Click(Sender: TObject);
begin
    Show;
    Self.WindowState := wsNormal;
    Self.FormStyle := fsNormal;
end;

procedure TfrmServidor.TrayIconDblClick(Sender: TObject);
begin
    Show;
    Self.WindowState := wsNormal;
    Self.FormStyle := fsNormal;
end;

end.

