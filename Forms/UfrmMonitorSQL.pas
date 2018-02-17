unit UfrmMonitorSQL;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Data.SqlExpr,
  Data.DBXCommon, Data.DB, Vcl.Grids, Vcl.DBGrids, Vcl.ComCtrls,
  Datasnap.DBClient, IBX.IBSQLMonitor;

type
  TfrmMonitorSQL = class(TForm)
    sqlMonitor: TSQLMonitor;
    mmoSQL: TMemo;
    pgcPrincipal: TPageControl;
    tsID: TTabSheet;
    tsMonitor: TTabSheet;
    dbgrdID: TDBGrid;
    ds1: TDataSource;
    cds1: TClientDataSet;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure dbgrdIDDblClick(Sender: TObject);
    procedure sqlMonitorTrace(Sender: TObject; TraceInfo: TDBXTraceInfo;
      var LogTrace: Boolean);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private

  public
    { Public declarations }
  end;

var
  frmMonitorSQL: TfrmMonitorSQL;

implementation

{$R *.dfm}

uses scServer;


procedure TfrmMonitorSQL.dbgrdIDDblClick(Sender: TObject);
begin
    pgcPrincipal.ActivePage := tsMOnitor;

    with sqlMonitor do
    begin
        Active := False;
        SQLConnection := sc_Server.ListOfConnection[dbgrdID.Fields[0].AsInteger];
        Active := True;
    end;
    mmoSQL.Lines.Clear;
end;

procedure TfrmMonitorSQL.FormClose(Sender: TObject; var Action: TCloseAction);
begin
    Action := caFree;
end;

procedure TfrmMonitorSQL.FormCreate(Sender: TObject);
begin
    //Cria estrutura CDS
    with cds1 do
    begin
        Close;
        FieldDefs.Clear;
        FieldDefs.Add('IdThreadConection', ftInteger, 0, False);
        CreateDataSet;
        LogChanges := False;
        Fields[0].DisplayLabel := '';
    end;

    sc_Server.ListConnection(cds1);
    cds1.ReadOnly := True;
    cds1.Open;
end;

procedure TfrmMonitorSQL.FormDestroy(Sender: TObject);
begin
    sqlMonitor.Active := False;
    cds1.Close;
end;

procedure TfrmMonitorSQL.sqlMonitorTrace(Sender: TObject;
  TraceInfo: TDBXTraceInfo; var LogTrace: Boolean);
begin
    mmoSQL.Lines.Add('-----------------------------------');
    mmoSQL.Lines.Add(TraceInfo.Message);
    mmoSQL.Lines.Add('-----------------------------------');
end;

end.
