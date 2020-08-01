unit u_Cadastro;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.Mask, StrUtils,
  Vcl.Buttons, Vcl.Imaging.pngimage;

type
  TformCadastro = class(TForm)
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Panel1: TPanel;
    Memo1: TMemo;
    editObservacao: TEdit;
    editValor: TEdit;
    maskData: TMaskEdit;
    comboCodigo: TComboBox;
    comboCategoria: TComboBox;
    SaveDialog1: TSaveDialog;
    Image1: TImage;
    btnSalvar: TSpeedButton;
    Image2: TImage;
    btnConcluir: TSpeedButton;
    Label6: TLabel;
    Label7: TLabel;
    Image3: TImage;
    btnLimpar: TSpeedButton;
    Label8: TLabel;
    procedure editValorChange(Sender: TObject);
    procedure btnConcluirClick(Sender: TObject);
    procedure btnLimparClick(Sender: TObject);
    procedure btnSalvarClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  formCadastro: TformCadastro;
  data: String;
  valor: String;

implementation



{$R *.dfm}

 function FormatarMoeda(valor: string): string;
var
  decimais, centena, milhar, milhoes, bilhoes, trilhoes, quadrilhoes: string;
  i: Integer;
begin
  Result := EmptyStr;

  for i := 0 to Length(valor) - 1 do
    if not(valor[i] in ['0' .. '9']) then
      delete(valor, i, 1);

  if copy(valor, 1, 1) = '0' then
    valor := copy(valor, 2, Length(valor));

  decimais := RightStr(valor, 2);
  centena := copy(RightStr(valor, 5), 1, 3);
  milhar := copy(RightStr(valor, 8), 1, 3);
  milhoes := copy(RightStr(valor, 11), 1, 3);
  bilhoes := copy(RightStr(valor, 14), 1, 3);
  trilhoes := copy(RightStr(valor, 17), 1, 3);
  quadrilhoes := LeftStr(valor, Length(valor) - 17);

  case Length(valor) of
    1:
      Result := '0,0' + valor;
    2:
      Result := '0,' + valor;
    6 .. 8:
      begin
        milhar := LeftStr(valor, Length(valor) - 5);
        Result := milhar + '.' + centena + ',' + decimais;
      end;
    9 .. 11:
      begin
        milhoes := LeftStr(valor, Length(valor) - 8);
        Result := milhoes + '.' + milhar + '.' + centena + ',' + decimais;
      end;
    12 .. 14:
      begin
        bilhoes := LeftStr(valor, Length(valor) - 11);
        Result := bilhoes + '.' + milhoes + '.' + milhar + '.' + centena + ',' + decimais;
      end;
    15 .. 17:
      begin
        trilhoes := LeftStr(valor, Length(valor) - 14);
        Result := trilhoes + '.' + bilhoes + '.' + milhoes + '.' + milhar + '.' + centena + ','
          + decimais;
      end;
    18 .. 20:
      begin
        quadrilhoes := LeftStr(valor, Length(valor) - 17);
        Result := quadrilhoes + '.' + trilhoes + '.' + bilhoes + '.' + milhoes + '.' + milhar + '.'
          + centena + ',' + decimais;
      end
  else
    Result := LeftStr(valor, Length(valor) - 2) + ',' + decimais;
  end;
end;

procedure TformCadastro.btnConcluirClick(Sender: TObject);
begin
data:= maskData.Text;
valor:= editValor.Text;

Memo1.Lines.Add('Data: ' + Uppercase(data));
Memo1.Lines.Add(' ');
Memo1.Lines.Add('Valor: ' + Uppercase(valor));
Memo1.Lines.Add(' ');
Memo1.Lines.Add('C�digo: ' + Uppercase(comboCodigo.Text));
Memo1.Lines.Add(' ');
Memo1.Lines.Add('Categoria: ' + Uppercase(comboCategoria.Text));
Memo1.Lines.Add(' ');
Memo1.Lines.Add('Observa��o: ' + Uppercase(editObservacao.Text));

end;

procedure TformCadastro.btnLimparClick(Sender: TObject);
begin
maskData.Text:='';
editValor.Text:='';
comboCodigo.Text:='';
comboCategoria.Text:='';
editObservacao.Text:='';
Memo1.Text:='';
maskData.SetFocus;

end;

procedure TformCadastro.btnSalvarClick(Sender: TObject);
var
dataarquivo: String;
valorarquivo:String;
begin

dataarquivo := StringReplace(maskData.Text,'/','',[rfReplaceall, rfIgnoreCase]);
valorarquivo := StringReplace(editValor.Text,',','',[rfReplaceall, rfIgnoreCase]);
SaveDialog1.FileName:= dataarquivo + ' ' + valorarquivo + '.txt';
SaveDialog1.Execute;

if SaveDialog1.FileName <> '' then

Memo1.Lines.SaveToFile(SaveDialog1.FileName);



end;

procedure TformCadastro.editValorChange(Sender: TObject);
begin
editValor.Text := FormatarMoeda(editValor.Text);
editValor.SelStart := Length(editValor.Text);
end;

end.
