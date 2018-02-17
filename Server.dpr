program Server;

uses
  Vcl.Forms,
  Web.WebReq,
  IdHTTPWebBrokerBridge,
  UfrmServer in 'Forms\UfrmServer.pas' {frmServidor},
  scServer in 'Server\scServer.pas' {sc_Server: TDataModule},
  UfrmConfigdatabase in 'Forms\UfrmConfigdatabase.pas' {frmConfigDatabase},
  USDMPai in 'Server\USDMPai.pas' {SDMPai: TDataModule},
  USDMMestre in 'Server\USDMMestre.pas' {SDMMestre: TDSServerModule},
  URegistraClassesServidoras in 'Server\URegistraClassesServidoras.pas',
  USDMPaiCadastro in 'Server\USDMPaiCadastro.pas' {SDMPaiCadastro: TDSServerModule},
  ClassPai in 'Class\ClassPai.pas',
  ClassPaiCadastro in 'Class\ClassPaiCadastro.pas',
  ClassPessoa in 'Class\ClassPessoa.pas',
  USDMCadPessoa in 'Server\USDMCadPessoa.pas' {SDMCadPessoa: TDSServerModule},
  UClassFuncoes in 'Class\UClassFuncoes.pas',
  ClassEndereco_Pessoa in 'Class\ClassEndereco_Pessoa.pas',
  ClassTelefone_Pessoa in 'Class\ClassTelefone_Pessoa.pas',
  UfrmMonitorSQL in 'Forms\UfrmMonitorSQL.pas' {frmMonitorSQL},
  USDMPaiConsulta in 'Server\USDMPaiConsulta.pas' {SDMPaiConsulta: TDSServerModule};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(Tsc_Server, sc_Server);
  Application.CreateForm(TfrmServidor, frmServidor);
  Application.Run;
end.

