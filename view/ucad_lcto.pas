unit ucad_lcto;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ExtCtrls, StdCtrls,
  Buttons, classe_plano, classe_lancamento, rxcurredit, DateTimePicker, LCLType,
  upesquisa;

type

  { Tfrm_cad_lcto }

  Tfrm_cad_lcto = class(TForm)
    btnLIMPAR: TSpeedButton;
    edtCodPlano: TEdit;
    edtConta: TEdit;
    edtData: TDateTimePicker;
    edtDescConta: TEdit;
    edtDescLcto: TEdit;
    edtDescPlano: TEdit;
    edtTipo: TEdit;
    edtValor: TCurrencyEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Panel1: TPanel;
    Panel2: TPanel;
    Panel3: TPanel;
    pnpTITULO: TPanel;
    SpeedButton1: TSpeedButton;
    SpeedButton3: TSpeedButton;
    procedure btnLIMPARClick(Sender: TObject);
    procedure edtCodPlanoExit(Sender: TObject);
    procedure edtCodPlanoKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: char);
    procedure FormShow(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure SpeedButton3Click(Sender: TObject);
  private
    procedure limpa_campos;

  public

  end;

var
  frm_cad_lcto: Tfrm_cad_lcto;
  plano       : Tplano;
  lancamentos : Tlancamento;


implementation

{$R *.lfm}

{ Tfrm_cad_lcto }

procedure Tfrm_cad_lcto.FormKeyPress(Sender: TObject; var Key: char);
begin
  if key=#13 then
    begin
      SelectNext(ActiveControl as TWinControl,True,True);
      key:=#0;
    end;
end;

procedure Tfrm_cad_lcto.FormShow(Sender: TObject);
begin
  edtData.Date:=date;
end;

procedure Tfrm_cad_lcto.SpeedButton1Click(Sender: TObject);
begin
  lancamentos.conta     := StrToIntDef(edtConta.Text,0);
  lancamentos.cod_plano := StrToIntDef(edtCodPlano.Text,0);
  lancamentos.data_mvto := edtData.Date;
  lancamentos.descricao := edtDescLcto.Text;
  ShowMessage('Dados salvos com sucesso');
  edtCodPlano.SetFocus;
    if plano.tipo = 'C' then
        lancamentos.valor     := edtValor.Value
     else
      lancamentos.valor     := (edtValor.Value*-1);
     if lancamentos.inclui then
       limpa_campos
       else
        ShowMessage('Erro ao incluir');
end;

procedure Tfrm_cad_lcto.SpeedButton3Click(Sender: TObject);
begin
  Close;
end;

procedure Tfrm_cad_lcto.edtCodPlanoExit(Sender: TObject);
begin
  if StrToIntDef(edtCodPlano.Text,0)>0 then
    begin
      if plano.localiza(StrToIntDef(edtCodPlano.Text,0)) then
        begin
          edtDescPlano.Text:=plano.descricao;
          edtTipo.Text     :=plano.tipo;
        end;
    end
  Else
  BEgin
    ShowMessage('Código Inválido !..');
    edtCodPlano.SetFocus;
  end;
end;

procedure Tfrm_cad_lcto.btnLIMPARClick(Sender: TObject);
begin
  limpa_campos;
end;

procedure Tfrm_cad_lcto.edtCodPlanoKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
    if key = VK_F4 then
     begin
     frmPesquisa := TfrmPesquisa.Create(self,['ID_PLANO','DESCRICAO','TIPO'],
                                              'PLANOS',
                                              'ID_PLANO');
     TRY
       frmPesquisa.ShowModal;
       edtCodPlano.Text:= frmPesquisa.edtResultado.Text;
     finally
     end;
     end;
end;

procedure Tfrm_cad_lcto.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin
 if Assigned(plano) then
   FreeAndNil(plano);
    if Assigned(lancamentos) then
   FreeAndNil(lancamentos);
end;

procedure Tfrm_cad_lcto.FormCreate(Sender: TObject);
begin
  plano       := Tplano.Create;
  lancamentos := Tlancamento.Create;
end;
procedure Tfrm_cad_lcto.limpa_campos;
var
nX : Integer;
begin
for nX := 0 to ComponentCount -1 do
begin
  if (Components[nX] is TEdit) and ((Components[nX] as TEdit).Tag <> 99) then
     (Components[nX] as TEdit).CLear;
   if Components[nX] is TCurrencyEdit then
     (Components[nX] as TCurrencyEdit).Value:=0;
end;
end;
end.

