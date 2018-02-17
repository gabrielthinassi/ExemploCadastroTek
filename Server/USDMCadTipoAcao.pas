unit USDMCadTipoAcao;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, USDMPaiCadastro, Data.FMTBcd, Data.DB,
  Data.SqlExpr, Datasnap.Provider;

type
  TSDMCadTipoAcao = class(TSDMPaiCadastro)
    procedure sqlCadastroAfterOpen(DataSet: TDataSet);
  private
    { Private declarations }
  public
    { Public declarations }
  protected
    procedure DSServerCreate_Filha(Sender:TObject); override;
  end;

var
  SDMCadTipoAcao: TSDMCadTipoAcao;

implementation

{$R *.dfm}

uses UClassCadTipoAcao;

{ TSDMCadTipoAcao }

procedure TSDMCadTipoAcao.DSServerCreate_Filha(Sender: TObject);
begin
    FClassFilha := TClassCadTipoAcao;
  inherited;
end;

procedure TSDMCadTipoAcao.sqlCadastroAfterOpen(DataSet: TDataSet);
begin
  inherited;
    SetaProviderFlag(sqlCadastro, FClassFilha.CampoChave);
end;

end.
