unit UfrmCadPessoa;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, UfrmPaiCadastro, Vcl.StdCtrls,
  JvExStdCtrls, JvCombobox, JvDBCombobox, Vcl.DBCtrls, Vcl.ComCtrls,
  JvExComCtrls, JvComCtrls, Data.DB, Vcl.Buttons, Vcl.Mask, JvExMask,
  JvToolEdit, JvBaseEdits, Vcl.ExtCtrls, JvExExtCtrls, JvExtComponent, JvPanel,
  Vcl.Grids, Vcl.DBGrids, JvExDBGrids, JvDBGrid, JvDBControls, Data.DBXCommon,
  Data.SqlExpr, JvDataSource, UDMCadPessoa;

type
  TfrmCadPessoa = class(TfrmPaiCadastro)
    JvPanel4: TJvPanel;
    JvPageControl1: TJvPageControl;
    tsEndereco: TTabSheet;
    TabSheet2: TTabSheet;
    Label1: TLabel;
    Label2: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    dbgrdEndereco: TJvDBGrid;
    edtRua: TDBEdit;
    edtNumero: TDBEdit;
    edtBairro: TDBEdit;
    edtEmailComercial: TDBEdit;
    edtEmailPessoal: TDBEdit;
    edtProfissao: TDBEdit;
    edtCNPJCPF: TDBEdit;
    edtNome: TDBEdit;
    edtDescCidade: TDBEdit;
    edtCEP: TDBEdit;
    edtUF: TDBEdit;
    dbgrdTelefone_Obs: TJvDBGrid;
    mmoObservacoes: TDBMemo;
    Label7: TLabel;
    rgTipoEndereco: TDBRadioGroup;
    rgTipoPessoa: TDBRadioGroup;
    dsTelefone: TDataSource;
    lbl1: TLabel;
    lbl2: TLabel;
    lbl3: TLabel;
    lbl4: TLabel;
    lbl5: TLabel;
    lbl6: TLabel;
    dsEndereco: TDataSource;
    procedure FormCreate(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure edtCodigoButtonClick(Sender: TObject);
    procedure mmoObservacoesEnter(Sender: TObject);
    procedure mmoObservacoesExit(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private

  public
    { Public declarations }
  protected

  end;

var
  frmCadPessoa: TfrmCadPessoa;

implementation

{$R *.dfm}

uses ClassPessoa, UClassFuncoes, UfrmPaiConsulta;

procedure TfrmCadPessoa.btnGravarClick(Sender: TObject);
begin
    inherited;
    if edtCodigo.AsInteger = 0 then
        edtCodigo.AsInteger := dmCadPessoa.AutoInc;
end;

procedure TfrmCadPessoa.edtCodigoButtonClick(Sender: TObject);
begin
    frmPaiConsulta := TfrmPaiConsulta.Create(Self);
    frmPaiConsulta.FClass := TClassPessoa;
    frmPaiConsulta.ShowModal;
    dmCadPessoa.AchouRegistro(frmPaiConsulta.ID);
    edtCodigo.AsInteger := frmPaiConsulta.ID;
    FreeAndNil(frmPaiConsulta);
    inherited;
end;

procedure TfrmCadPessoa.FormCreate(Sender: TObject);
var
    I: integer;
begin
  inherited;
    dmCadPessoa := TdmCadPessoa.Create(Self);
    FDM := dmCadPessoa;

    for I := 0 to High(ClassPessoa.DescricaoPessoa) do
    begin
        rgTipoPessoa.Items.Add(ClassPessoa.DescricaoPessoa[I].Name);
        rgTipoPessoa.Values.Add(IntToStr(I));
    end;
end;

procedure TfrmCadPessoa.FormDestroy(Sender: TObject);
begin
  inherited;
    FreeAndNil(dmCadPessoa);
end;

procedure TfrmCadPessoa.mmoObservacoesEnter(Sender: TObject);
begin
  inherited;
    frmCadPessoa.KeyPreview := False;
end;

procedure TfrmCadPessoa.mmoObservacoesExit(Sender: TObject);
begin
  inherited;
    frmCadPessoa.KeyPreview := True;
end;

end.
