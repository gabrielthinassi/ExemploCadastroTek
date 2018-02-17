unit USDMCadStatus;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, USDMPaiCadastro, Data.FMTBcd, Data.DB,
  Data.SqlExpr, Datasnap.Provider;

type
  TSDMCadStatus = class(TSDMPaiCadastro)
    procedure sqlCadastroAfterOpen(DataSet: TDataSet);
  private

  public
    { Public declarations }
  protected
    procedure DSServerCreate_Filha(Sender:TObject); override;
  end;

var
  SDMCadStatus: TSDMCadStatus;

implementation

{$R *.dfm}

uses UClassCadStatus;

{ TSDMCadStatus }

procedure TSDMCadStatus.DSServerCreate_Filha(Sender: TObject);
begin
    FClassFilha := TClassCadStatus;
  inherited;
end;

procedure TSDMCadStatus.sqlCadastroAfterOpen(DataSet: TDataSet);
begin
  inherited;
    SetaProviderFlag(sqlCadastro, FClassFilha.CampoChave);
end;

end.
