unit USDMCadAgenda;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, USDMPaiCadastro, Data.FMTBcd, Data.DB,
  Data.SqlExpr, Datasnap.Provider,

  ClassProcesso, Datasnap.DBClient, frxClass, frxDBSet;

type
  TSDMCadAgenda = class(TSDMPaiCadastro)
    sqlProcesso: TSQLDataSet;
    dspProcesso: TDataSetProvider;
    procedure sqlCadastroAfterOpen(DataSet: TDataSet);
    procedure DSServerModuleDestroy(Sender: TObject);
  private
    ClassProcesso: TClassProcesso;
  Public

  protected
    procedure DSServerCreate_Filha(Sender:TObject); override;

  end;

var
  SDMCadAgenda: TSDMCadAgenda;

implementation

{$R *.dfm}

uses ClassCadAgenda;

{ TSDMCadAgenda }

procedure TSDMCadAgenda.DSServerCreate_Filha(Sender: TObject);
begin
  inherited;
    FClassFilha := TClassCadAgenda;

    ClassProcesso := TClassProcesso.Create;
    sqlProcesso.CommandText := ClassProcesso.SQLBaseGeral;
    ClassProcesso.CriarParametros(sqlProcesso);

end;

procedure TSDMCadAgenda.DSServerModuleDestroy(Sender: TObject);
begin
  inherited;
    ClassProcesso.Free;
end;

procedure TSDMCadAgenda.sqlCadastroAfterOpen(DataSet: TDataSet);
begin
  inherited;
    SetaProviderFlag(sqlCadastro, FClassFilha.CampoChave);
end;
end.
