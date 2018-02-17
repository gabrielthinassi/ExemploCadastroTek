unit UfrmPaiConsulta;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.Grids, Vcl.DBGrids,
  Vcl.Buttons, Vcl.ExtCtrls, JvExExtCtrls, JvExtComponent, JvPanel, JvExDBGrids,
  JvDBGrid, Vcl.StdCtrls, ClassPaiCadastro, Vcl.Mask, Datasnap.DBClient,
  Datasnap.DSConnect, JvExStdCtrls, JvEdit;

type
  TfrmPaiConsulta = class(TForm)
    dbgrdConsulta: TJvDBGrid;
    JvPanel3: TJvPanel;
    btnConsultar: TSpeedButton;
    dsPrincipal: TDataSource;
    cbbColuna: TComboBox;
    cbbOperador: TComboBox;
    lbl1: TLabel;
    lbl2: TLabel;
    lbl3: TLabel;
    dspConsulta: TDSProviderConnection;
    cdsConsulta: TClientDataSet;
    btnConfirmar: TSpeedButton;
    edtValor: TJvEdit;
    procedure FormShow(Sender: TObject);
    procedure cbbOperadorChange(Sender: TObject);
    procedure btnConsultarClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnConfirmarClick(Sender: TObject);
    procedure dbgrdConsultaDblClick(Sender: TObject);
    procedure cdsConsultaAfterOpen(DataSet: TDataSet);
    procedure dbgrdConsultaTitleClick(Column: TColumn);
  private
    CamposSQL: TStrings;
    function SQLOperador: string;
    function SQLCampos: string;
  public
    FClass: TFClassPaiCadastro;
    ID: integer;
  end;

    FClass = class of TClassPaiCadastro;

var
  frmPaiConsulta: TfrmPaiConsulta;

{
0 - Igual
1 - Maior que
2 - Menor que
3 - Maior ou igual a
4 - Menor ou igual a
5 - Começa com
6 - Termina com
7 - Contém
8 - Preenchido
}

implementation

{$R *.dfm}

uses UClassFuncoes, UdmConexaoPai;


procedure TfrmPaiConsulta.btnCancelarClick(Sender: TObject);
begin
    Close;
end;

procedure TfrmPaiConsulta.btnConfirmarClick(Sender: TObject);
begin
    ID := dsPrincipal.DataSet.Fields[0].AsInteger;
    Close;
end;

procedure TfrmPaiConsulta.btnConsultarClick(Sender: TObject);
var
    SQL: string;
begin
    SQL := FClass.SQLBaseConsulta;
    SQL := SQL + SQLOperador;

    with cdsConsulta do
    begin
        Close;
        CommandText := SQL;
        Open;
    end;
end;

procedure TfrmPaiConsulta.cbbOperadorChange(Sender: TObject);
begin
    with edtValor do
    begin
    case cbbOperador.ItemIndex of
        0: begin
            Clear;
        end;
        1: begin
            Clear;
        end;
        2: begin
            Clear;
        end;
        3: begin
            Clear;
        end;
        4: begin
            Clear;
        end;
        5: begin
            Clear;
        end;
        6: begin
            Clear;
        end;
        7: begin
            Clear;
        end;
        8: begin
            Clear;
        end;
    end;
    end;
end;

procedure TfrmPaiConsulta.cdsConsultaAfterOpen(DataSet: TDataSet);
var
    I: integer;
begin
    for I := 0 to DataSet.FieldCount - 1 do
    begin
        if DataSet.Fields[I] is TDateTimeField then
            TDateTimeField(DataSet.Fields[I]).DisplayFormat := 'dd/mm/yyyy';
    end;

end;

procedure TfrmPaiConsulta.dbgrdConsultaDblClick(Sender: TObject);
begin
    ID := dsPrincipal.DataSet.Fields[0].AsInteger;
    Close;
end;

procedure TfrmPaiConsulta.dbgrdConsultaTitleClick(Column: TColumn);
begin
    cdsConsulta.IndexFieldNames := Column.FieldName;
end;

procedure TfrmPaiConsulta.FormClose(Sender: TObject; var Action: TCloseAction);
begin
    cdsConsulta.Close;
    CamposSQL.Free;
end;

procedure TfrmPaiConsulta.FormCreate(Sender: TObject);
begin
    CamposSQL := TStringList.Create;
    dspConsulta.SQLConnection := dmConexaoPai.conConexao;
    dspConsulta.ServerClassName := 'TSDMPaiConsulta';
    cdsConsulta.ProviderName := 'dspConsulta';
end;

procedure TfrmPaiConsulta.FormShow(Sender: TObject);
var
    Lista: TStrings;
begin
    frmPaiConsulta.Caption := 'Consulta de ' + FClass.Descricao;

    Lista := TStringList.Create;
    try
        cbbColuna.Items.AddStrings(FClass.CamposConsulta(Lista, CamposSQL));
    finally
        Lista.Free;
    end;

    cbbColuna.ItemIndex := 0;
    cbbOperador.ItemIndex := 7;
end;

function TfrmPaiConsulta.SQLCampos: string;
begin
    Result := ' where ' + CamposSQL[cbbColuna.ItemIndex];
end;

function TfrmPaiConsulta.SQLOperador: string;
begin
    if cbbOperador.ItemIndex in [0..7] then
    begin
        if Trim(edtValor.Text) = '' then
        begin
            MensagemInformacao('Para este tipo de opereador, deve informar um valor.');
            Abort;
        end;
    end;

    case cbbOperador.ItemIndex of
        0: Result := SQLCampos + ' = ' + QuotedStr(Trim(edtValor.Text));
        1: Result := SQLCampos + ' > ' + QuotedStr(Trim(edtValor.Text));
        2: Result := SQLCampos + ' < ' + QuotedStr(Trim(edtValor.Text));
        3: Result := SQLCampos + ' >= ' + QuotedStr(Trim(edtValor.Text));
        4: Result := SQLCampos + ' <= ' + QuotedStr(Trim(edtValor.Text));
        5: Result := SQLCampos + ' like ' + QuotedStr(Trim(edtValor.Text) + '%');
        6: Result := SQLCampos + ' like ' + QuotedStr('%' + Trim(edtValor.Text));
        7: Result := SQLCampos + ' like ' + QuotedStr('%' + Trim(edtValor.Text) + '%');
        8: Result := '';
    end;
end;

end.
