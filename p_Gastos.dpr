program p_Gastos;

uses
  Vcl.Forms,
  u_Login in 'u_Login.pas' {formLogin},
  u_Cadastro in 'u_Cadastro.pas' {formCadastro};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TformLogin, formLogin);
  Application.CreateForm(TformCadastro, formCadastro);
  Application.Run;
end.
