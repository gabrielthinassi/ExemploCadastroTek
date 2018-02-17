unit USDMCadTramite;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, USDMPaiCadastro, Data.FMTBcd, Data.DB,
  Data.SqlExpr, Datasnap.Provider, uClassCadTramite;

type
  TSDMCadTramite = class(TSDMPaiCadastro)
    procedure sqlCadastroAfterOpen(DataSet: TDataSet);
  private

  public

  protected
    procedure DSServerCreate_Filha(Sender:TObject); override;

  end;

var
  SDMCadTramite: TSDMCadTramite;

implementation

{$R *.dfm}

{ TSDMCadTramite }

procedure TSDMCadTramite.DSServerCreate_Filha(Sender: TObject);
begin
    FClassFilha := TClassCadTramite;
  inherited;
end;

procedure TSDMCadTramite.sqlCadastroAfterOpen(DataSet: TDataSet);
begin
  inherited;
    SetaProviderFlag(sqlCadastro, FClassFilha.CampoChave);
end;

end.
