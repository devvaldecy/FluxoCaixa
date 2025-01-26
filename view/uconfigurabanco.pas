unit uconfigurabanco;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, ExtCtrls,
  Buttons, IniFiles;

type

  { Tfrmconfigurarbanco }

  Tfrmconfigurarbanco = class(TForm)
    btnCANCELA: TBitBtn;
    btnSALVAR: TBitBtn;
    EdtBANCO: TEdit;
    EdtPASSWORD: TEdit;
    edtPORTA: TEdit;
    EdtSERVER: TEdit;
    EdtUSUARIO: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Panel1: TPanel;
    Panel2: TPanel;
    Shape1: TShape;
    SpeedButton3: TSpeedButton;
    procedure btnCANCELAClick(Sender: TObject);
    procedure btnSALVARClick(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: char);
    procedure FormShow(Sender: TObject);
    procedure SpeedButton3Click(Sender: TObject);
  private
    procedure salva_ini;
    procedure ler_ini;
  public

  end;

var
  frmconfigurarbanco: Tfrmconfigurarbanco;

implementation
uses uprincipal;

{$R *.lfm}

{ Tfrmconfigurarbanco }

procedure Tfrmconfigurarbanco.btnSALVARClick(Sender: TObject);
begin
  salva_ini;
  ShowMessage('Gravado com sucesso....');
  Close;
end;

procedure Tfrmconfigurarbanco.FormKeyPress(Sender: TObject; var Key: char);
begin
  if key=#13 then begin
  SelectNext(ActiveControl as TWinControl,True,True);
  key:=#0;
  end;
end;

procedure Tfrmconfigurarbanco.btnCANCELAClick(Sender: TObject);
begin
  Close;
end;

procedure Tfrmconfigurarbanco.FormShow(Sender: TObject);
begin
  ler_ini;
end;

procedure Tfrmconfigurarbanco.SpeedButton3Click(Sender: TObject);
begin
  Close;
end;

procedure Tfrmconfigurarbanco.salva_ini;
 var
 Arq_INI : TIniFile;
begin
 Arq_INI := TIniFile.Create(cfg_arqINI);
 TRY
   Arq_INI.WriteString('ConexaoDB', 'Banco',  EdtBANCO.Text);
   Arq_INI.WriteString('ConexaoDB', 'Server', EdtSERVER.Text);
   Arq_INI.WriteInteger('ConexaoDB', 'Porta', StrToIntDef(edtPORTA.Text, 3307));
   Arq_INI.WriteString('ConexaoDB', 'Usuario',   EdtUSUARIO.Text);
   Arq_INI.WriteString('ConexaoDB', 'Senha',  EdtPASSWORD.Text);
 finally
   Arq_INI.Free;
 end;
end;

procedure Tfrmconfigurarbanco.ler_ini;
var
Arq_INI : TIniFile;
begin
Arq_INI := TIniFile.Create(cfg_arqINI);
try
EdtBANCO.Text    := Arq_INI.ReadString('ConexaoDB', 'Banco','');
EdtSERVER.Text   := Arq_INI.ReadString('ConexaoDB', 'Server','');
edtPORTA.Text    := IntToStr(Arq_INI.ReadInteger('ConexaoDB', 'porta', 3307));
EdtUSUARIO.Text  := Arq_INI.ReadString('ConexaoDB', 'Usuario','');
EdtPASSWORD.Text := Arq_INI.ReadString('ConexaoDB', 'senha','');
finally
  Arq_INI.Free;
end;
end;
end.

