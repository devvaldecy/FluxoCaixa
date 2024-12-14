unit ucad_padrao;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ExtCtrls, Buttons,
  ComCtrls, StdCtrls, DBGrids, utabela;

type

  TCliqueBotao = (cbincluir, cbAlterar, cbNome);

  { Tfrmcad_padrao }

  Tfrmcad_padrao = class(TForm)
    BtnAltera: TSpeedButton;
    BtnApaga: TSpeedButton;
    BtnCancela: TSpeedButton;
    BtnIncluir: TSpeedButton;
    BtnPesquisa: TSpeedButton;
    BtnSalva: TSpeedButton;
    edtPESQUISA: TEdit;
    PageControl1: TPageControl;
    Panel1: TPanel;
    Panel2: TPanel;
    pnpRODAPE: TPanel;
    pnpTITULO: TPanel;
    SpeedButton1: TSpeedButton;
    TsCadastro: TTabSheet;
    TsPESQUISA: TTabSheet;
    procedure BtnAlteraClick(Sender: TObject);
    procedure BtnApagaClick(Sender: TObject);
    procedure BtnCancelaClick(Sender: TObject);
    procedure BtnIncluirClick(Sender: TObject);
    procedure BtnSalvaClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
  private
    procedure botao_edicao(lFPLAG:Boolean);
    procedure limpa_campos;
    procedure habilita_edicao(lFLAG:Boolean);
  public

  end;

var
  frmcad_padrao: Tfrmcad_padrao;
  cliquebotao : TCliqueBotao;

implementation

{$R *.lfm}

{ Tfrmcad_padrao }

procedure Tfrmcad_padrao.FormShow(Sender: TObject);
begin
  botao_edicao(false);
end;

procedure Tfrmcad_padrao.SpeedButton1Click(Sender: TObject);
begin
  Close;
end;

procedure Tfrmcad_padrao.BtnIncluirClick(Sender: TObject);
begin
  limpa_campos;
  botao_edicao(true);
  cliquebotao:=cbincluir;
end;

procedure Tfrmcad_padrao.BtnSalvaClick(Sender: TObject);
begin
  botao_edicao(false);
end;

procedure Tfrmcad_padrao.BtnAlteraClick(Sender: TObject);
begin
  botao_edicao(true);
  cliquebotao:=cbAlterar;
end;

procedure Tfrmcad_padrao.BtnApagaClick(Sender: TObject);
begin
  limpa_campos;
  botao_edicao(False);
end;

procedure Tfrmcad_padrao.BtnCancelaClick(Sender: TObject);
begin
  botao_edicao(False);
end;

procedure Tfrmcad_padrao.botao_edicao(lFPLAG: Boolean);
begin
  BtnIncluir.Visible := not lFPLAG;
  BtnAltera.Visible  := not lFPLAG;
  BtnApaga.Visible   := not lFPLAG;
  BtnSalva.Visible   := lFPLAG;
  BtnCancela.Visible := lFPLAG;
  habilita_edicao(lFPLAG);
end;

procedure Tfrmcad_padrao.limpa_campos;
var
  nX : Integer;
begin
  for nX := 0 to ComponentCount -1 do
  begin
    if Components[nX] is TEdit then
       (Components[nX] as TEdit).CLear;
  end;
end;

procedure Tfrmcad_padrao.habilita_edicao(lFLAG: Boolean);
var
  nX : Integer;
begin
  for nX := 0 to ComponentCount -1 do
    begin
      if Components[nX] is TEdit then
         begin
         if (Components[nX] as TEdit).Tag <> 99 then
            (Components[nX] as TEdit).Enabled:=lFLAG;
         end;
      if Components[nX] is TComboBox then
         (Components[nX] as TComboBox).Enabled:=lFLAG;
    end;
  end;
end.

