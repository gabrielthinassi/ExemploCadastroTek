unit UfrmPaiCadastro;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls,
  JvExStdCtrls, JvCombobox, JvDBCombobox, Vcl.DBCtrls, Vcl.ComCtrls,
  JvExComCtrls, JvComCtrls, Data.DB, Vcl.Buttons, Vcl.Mask, JvExMask,
  JvToolEdit, JvBaseEdits, Vcl.ExtCtrls, JvExExtCtrls, JvExtComponent, JvPanel,
  Vcl.Grids, Vcl.DBGrids, JvExDBGrids, JvDBGrid, JvDBControls, UdmCadPai;

type
  TfrmPaiCadastro = class(TForm)
    JvPanel1: TJvPanel;
    JvPanel2: TJvPanel;
    JvPanel3: TJvPanel;
    btnIncluir: TSpeedButton;
    btnGravar: TSpeedButton;
    btnExcluir: TSpeedButton;
    btnCancelar: TSpeedButton;
    dsMestre: TDataSource;
    edtCodigo: TJvCalcEdit;
    procedure btnIncluirClick(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure JvPanel2Exit(Sender: TObject);
    procedure dsMestreStateChange(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure edtCodigoButtonClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    procedure AlteraLetraMaiscula(Sender: TObject);
    { Private declarations }
  public
    { Public declarations }
  protected
     FDM: TdmCadPai;
  end;

    FDM = class of TdmCadPai;

var
  frmPaiCadastro: TfrmPaiCadastro;

implementation

{$R *.dfm}

uses UClassFuncoes;

procedure TfrmPaiCadastro.btnCancelarClick(Sender: TObject);
begin
    dsMestre.DataSet.Cancel;
    edtCodigo.SetFocus;
end;

procedure TfrmPaiCadastro.btnExcluirClick(Sender: TObject);
begin
    if not dsMestre.DataSet.IsEmpty then
        dsMestre.DataSet.Delete;

    edtCodigo.AsInteger := 0;
    edtCodigo.SetFocus;
end;

procedure TfrmPaiCadastro.btnGravarClick(Sender: TObject);
begin
    dsMestre.DataSet.Post;
    edtCodigo.SetFocus;
end;

procedure TfrmPaiCadastro.btnIncluirClick(Sender: TObject);
begin
    dsMestre.DataSet.Append;
    edtCodigo.AsInteger := 0;
    Perform(WM_NEXTDLGCTL, 0, 0);
end;

procedure TfrmPaiCadastro.dsMestreStateChange(Sender: TObject);
begin
    with dsMestre do
    begin
        btnIncluir.Enabled := State in [dsBrowse, dsInactive];
        btnGravar.Enabled := State in [dsInsert, dsEdit];
        JvPanel2.Enabled := not (State in [dsInsert, dsEdit]);
        btnExcluir.Enabled := State in [dsBrowse, dsInactive];
        btnCancelar.Enabled := State in [dsInsert, dsEdit];
    end;
end;

procedure TfrmPaiCadastro.edtCodigoButtonClick(Sender: TObject);
begin
    Abort;
end;

procedure TfrmPaiCadastro.FormClose(Sender: TObject; var Action: TCloseAction);
begin
    Action := caFree;
end;

procedure TfrmPaiCadastro.FormCreate(Sender: TObject);
begin
    AlteraLetraMaiscula(Sender);
end;

procedure TfrmPaiCadastro.FormKeyPress(Sender: TObject; var Key: Char);
begin
    if Key = #13 then
    begin
        Key := #0;
        Perform(WM_NEXTDLGCTL, 0, 0);
    end;
end;

procedure TfrmPaiCadastro.FormShow(Sender: TObject);
begin
    edtCodigo.SetFocus;
end;

procedure TfrmPaiCadastro.JvPanel2Exit(Sender: TObject);
begin
    if not (dsMestre.State in [dsInsert]) then
    begin
    if (edtCodigo.AsInteger <= 0) then
    begin
        if edtCodigo.CanFocus then
            edtCodigo.SetFocus;
        Abort;
    end;

    with FDM do
    begin
        if not AchouRegistro(edtCodigo.AsInteger) then
        begin
            MensagemAviso('Código ' + edtCodigo.Text + ' não encontrado.');
            if edtCodigo.CanFocus then
                edtCodigo.SetFocus;

            Abort;
        end
        else
            Perform(WM_NEXTDLGCTL, 0, 0);
    end;
    end;
end;

procedure TfrmPaiCadastro.AlteraLetraMaiscula(Sender: TObject);
var
    I: integer;
begin
  { Percorre a matriz de componentes do form }
    for I := 0 to ComponentCount - 1 do
        if (Components[I] is TDBEdit) then
            (Components[I] as TDBEdit).CharCase := ecUpperCase;
end;

end.
