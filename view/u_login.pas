unit u_login;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ExtCtrls, StdCtrls,
  Buttons, ZDataset, ZAbstractRODataset, utabela;

type

  { Tfrmlogin }

  Tfrmlogin = class(TForm)
    BtnEntrar: TBitBtn;
    BtnLimpar: TBitBtn;
    EdtTentativas: TEdit;
    EdtSenha: TEdit;
    EdtUser: TEdit;
    Image1: TImage;
    Image2: TImage;
    Label1: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Panel1: TPanel;
    Panel2: TPanel;
    Panel3: TPanel;
    Panel4: TPanel;
    pnlLest: TPanel;
    qrUSERemail: TZRawStringField;
    qrUSERid_user: TZCardinalField;
    qrUSERlogin: TZRawStringField;
    qrUSERnome: TZRawStringField;
    qrUSERsenha: TZRawStringField;
    Shape1: TShape;
    Shape2: TShape;
    SpeedButton1: TSpeedButton;
    qrUSER: TZQuery;
    procedure BtnEntrarClick(Sender: TObject);
    procedure BtnLimparClick(Sender: TObject);
    procedure EdtSenhaChange(Sender: TObject);
    procedure EdtUserChange(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: char);
    procedure Label6Click(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure LimparCampos;
  private
    tentativa : Integer;
  public

  end;

var
  frmlogin: Tfrmlogin;

implementation

uses uprincipal;

{$R *.lfm}

{ Tfrmlogin }

procedure Tfrmlogin.SpeedButton1Click(Sender: TObject);
begin

  Application.Terminate;

end;

procedure Tfrmlogin.BtnLimparClick(Sender: TObject);
begin
  LimparCampos;
end;

procedure Tfrmlogin.EdtSenhaChange(Sender: TObject);
begin
  Label10.Caption := IntToStr(Length(EdtSenha.Text));
  if Length(EdtSenha.Text) = 6 then
  ShowMessage('A senha é de apenas 6 digitos');
end;

procedure Tfrmlogin.EdtUserChange(Sender: TObject);
begin

end;

procedure Tfrmlogin.BtnEntrarClick(Sender: TObject);
begin

 if ((EdtUser.Text ='')and(EdtSenha.Text ='')) then
    begin
    ShowMessage('OPS! os campos estão vázios');

    EdtUser.SetFocus;
     Abort;
    end;
    qrUSER.Close;
    qrUSER.SQL.Clear; // Adicionei esta linha para limpar o SQL
    qrUSER.SQL.Add('Select * from usuarios');
    qrUSER.SQL.Add(' WHERE login = ' + QuotedStr(EdtUser.Text) + ' AND senha = ' + QuotedStr(EdtSenha.Text));
    qrUSER.Open;
    frmprincipal.LblUser.Caption := 'Usuário logado no sistema: '+ qrUSER.FieldByName('login').AsString;
    if qrUSER.IsEmpty then
    begin
    ShowMessage('Usuário ou senha inválida(o)');
    EdtUser.SetFocus;
    Abort;
    end;
  begin
   frmprincipal := Tfrmprincipal.Create(Self);
  try
    frmprincipal.ShowModal;
  finally
    FreeAndNil(frmprincipal);
  end;
  end;
end;
procedure Tfrmlogin.FormKeyPress(Sender: TObject; var Key: char);
begin
  if key=#13 then
  begin
    SelectNext(ActiveControl as TWinControl,True,True);
    key:=#0;
  end;
end;

procedure Tfrmlogin.Label6Click(Sender: TObject);
begin

end;

procedure Tfrmlogin.LimparCampos;
begin
  EdtUser  .Clear;
  EdtSenha .Clear;
  EdtUser  .SetFocus;
end;

end.

