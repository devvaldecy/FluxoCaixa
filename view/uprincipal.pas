unit uprincipal;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ExtCtrls, StdCtrls,
  Buttons, ComCtrls, ucad_padrao, ucad_planoconta, umovimento, ucadusuarios,
  usobre, IniFiles;

type

  { Tfrmprincipal }

  Tfrmprincipal = class(TForm)
    btnCFG: TSpeedButton;
    Image1: TImage;
    Image2: TImage;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    lbData: TLabel;
    lbLhora: TLabel;
    Panel1: TPanel;
    Panel2: TPanel;
    Panel3: TPanel;
    pnlUSER: TPanel;
    pnltop: TPanel;
    pnpEsquerda: TPanel;
    Shape1: TShape;
    btnCONTAS: TSpeedButton;
    btnPLANOS: TSpeedButton;
    btnLCTO: TSpeedButton;
    btnSAIR: TSpeedButton;
    SpeedButton1: TSpeedButton;
    SpeedButton2: TSpeedButton;
    SpeedButton3: TSpeedButton;
    SpeedButton4: TSpeedButton;
    SpeedButton5: TSpeedButton;
    TsBar: TStatusBar;
    tstimer: TTimer;
    procedure btnCFGClick(Sender: TObject);
    procedure btnCONTASClick(Sender: TObject);
    procedure btnLCTOClick(Sender: TObject);
    procedure btnPLANOSClick(Sender: TObject);
    procedure btnSAIRClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure SpeedButton2Click(Sender: TObject);
    procedure SpeedButton3Click(Sender: TObject);
    procedure SpeedButton4Click(Sender: TObject);
    procedure SpeedButton5Click(Sender: TObject);
    procedure tstimerTimer(Sender: TObject);
  private
    procedure ler_ini;

  public

  end;

var
  frmprincipal: Tfrmprincipal;
  cfg_arqINI, cfg_pathApp  : String;
  cfg_banco,  cfg_servidor, cfg_usuario, cfg_senha: String;
  cfg_porta : Integer;

implementation
  uses uconfigurabanco, ucad_contas, utabela;
{$R *.lfm}

{ Tfrmprincipal }

procedure Tfrmprincipal.btnSAIRClick(Sender: TObject);
begin
  if MessageDlg ( ' Até breve .......... ' , 'Informação do Sistema ?' , mtConfirmation ,
                 [ mbYes , mbNo ] , 0 )  = mrYes
    then  {Execute resto do programa}
  Application.Terminate;
end;

procedure Tfrmprincipal.FormCreate(Sender: TObject);
begin
  cfg_arqINI  := ChangeFileExt(ParamStr(0),'.ini');
  cfg_pathApp := ExtractFilePath(ParamStr(0));
end;

procedure Tfrmprincipal.FormShow(Sender: TObject);
begin
  if not FileExists(cfg_arqINI) then
  btnCFG.Click;
  ler_ini;
  try
  TabGlobal.conexao.Connect;
  //ShowMessage('Conectado ao banco');
  except
    on e: Exception do
    ShowMessage('Erro ao conecta com banco'+sLineBreak+
    e.ClassName+sLineBreak+e.Message);
  end;
end;

procedure Tfrmprincipal.SpeedButton1Click(Sender: TObject);
begin
  frmcad_usuarios := Tfrmcad_usuarios.Create(Self);
  try
    frmcad_usuarios.ShowModal;
  finally
    FreeAndNil(frmcad_usuarios);
  end;
end;

procedure Tfrmprincipal.SpeedButton2Click(Sender: TObject);
begin
  frmSobre := TfrmSobre.Create(Self);
  try
    frmSobre.ShowModal;
  finally
    FreeAndNil(frmSobre);
  end;
end;

procedure Tfrmprincipal.SpeedButton3Click(Sender: TObject);
begin
 if MessageDlg ( ' Até breve .......... ' , 'Informação do Sistema ?' , mtConfirmation ,
                 [ mbYes , mbNo ] , 0 )  = mrYes
    then  {Execute resto do programa}
 Application.Terminate;
end;

procedure Tfrmprincipal.SpeedButton4Click(Sender: TObject);
begin
  Application.Minimize;
end;

procedure Tfrmprincipal.SpeedButton5Click(Sender: TObject);
begin

end;

procedure Tfrmprincipal.tstimerTimer(Sender: TObject);
begin
 lbData.Caption        := FormatDateTime('DD/MM/YY', Now);// para data
 lbLhora.Caption       := ' '+timetostr(now);//para hora
 TsBar.Panels [1].Text :=  'Sistema Fluxo de Caixa';
 TsBar.Panels [2].Text :=  'IP .: 192.168.1.103';
 TsBar.Panels [3].Text :=  'Reg. para.: Valdecy Infor LTDA';
end;

procedure Tfrmprincipal.ler_ini;
var
Arq_INI : TIniFile;
begin
Arq_INI := TIniFile.Create(cfg_arqINI);
try
cfg_banco    := Arq_INI.ReadString('ConexaoDB', 'Banco','');
cfg_servidor := Arq_INI.ReadString('ConexaoDB', 'Server','');
cfg_porta    := Arq_INI.ReadInteger('ConexaoDB', 'porta', 3307);
cfg_usuario  := Arq_INI.ReadString('ConexaoDB', 'usuario','root');
cfg_senha    := Arq_INI.ReadString('ConexaoDB', 'senha','');
finally
  Arq_INI.Free;
end;
end;

procedure Tfrmprincipal.btnCFGClick(Sender: TObject);
begin
  frmconfigurarbanco := Tfrmconfigurarbanco.Create(Self);
  try
    frmconfigurarbanco.ShowModal;
  finally
    FreeAndNil(frmconfigurarbanco);
  end;
end;

procedure Tfrmprincipal.btnCONTASClick(Sender: TObject);
begin
  frmcad_contas := Tfrmcad_contas.Create(Self);
  try
    frmcad_contas.ShowModal;
  finally
    FreeAndNil(frmcad_contas);
  end;
end;

procedure Tfrmprincipal.btnLCTOClick(Sender: TObject);
begin
  frmmovimento := Tfrmmovimento.Create(Self);
  try
    frmmovimento.ShowModal;
  finally
    FreeAndNil(frmmovimento);
  end;
end;

procedure Tfrmprincipal.btnPLANOSClick(Sender: TObject);
begin
  frmcad_planoconta := Tfrmcad_planoconta.Create(Self);
  try
    frmcad_planoconta.ShowModal;
  finally
    FreeAndNil(frmcad_planoconta);
  end;
end;

end.

