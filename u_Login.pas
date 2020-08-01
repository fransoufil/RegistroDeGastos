unit u_Login;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, u_Cadastro, Vcl.Buttons,
  Vcl.Imaging.pngimage, Vcl.ExtCtrls;

type
  TformLogin = class(TForm)
    Label1: TLabel;
    Label2: TLabel;
    editUsuario: TEdit;
    editSenha: TEdit;
    Image1: TImage;
    btnLogin: TSpeedButton;
    procedure btnLoginClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  formLogin: TformLogin;

implementation

{$R *.dfm}

procedure TformLogin.btnLoginClick(Sender: TObject);
begin
     if ((editUsuario.Text = 'franz') and (editSenha.Text = 'souza')) then
       begin
        formCadastro.Show;
        editUsuario.Text:='';
        editSenha.Text:='';
       end

      else
        begin
           Application.MessageBox('Usuário ou Senha inválidos!','Erro de Login',MB_ICONEXCLAMATION+MB_OK+MB_SYSTEMMODAL);
           editUsuario.SetFocus;
        end;




end;

end.
