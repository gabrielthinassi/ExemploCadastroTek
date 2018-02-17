program Cliente;

uses
  Vcl.Forms,
  SysUtils,
  UfrmConfigServer in 'Forms\UfrmConfigServer.pas' {frmConfigServer},
  UdmConexaoPai in 'DM\UdmConexaoPai.pas' {dmConexaoPai: TDataModule},
  UfrmPrincipal in 'Forms\UfrmPrincipal.pas' {frmPrincipal},
  UClassFuncoes in 'Class\UClassFuncoes.pas',
  UdmCadPai in 'DM\UdmCadPai.pas' {dmCadPai: TDataModule},
  UfrmPaiCadastro in 'Forms\UfrmPaiCadastro.pas' {frmPaiCadastro},
  UfrmCadPessoa in 'Forms\UfrmCadPessoa.pas' {frmCadPessoa},
  ClassPai in 'Class\ClassPai.pas',
  ClassPaiCadastro in 'Class\ClassPaiCadastro.pas',
  ClassPessoa in 'Class\ClassPessoa.pas',
  UDMCadPessoa in 'DM\UDMCadPessoa.pas' {dmCadPessoa: TDataModule},
  ClassEndereco_Pessoa in 'Class\ClassEndereco_Pessoa.pas',
  ClassTelefone_Pessoa in 'Class\ClassTelefone_Pessoa.pas',
  UfrmPaiConsulta in 'Forms\UfrmPaiConsulta.pas' {frmPaiConsulta};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfrmPrincipal, frmPrincipal);
  Application.Run;
end.
