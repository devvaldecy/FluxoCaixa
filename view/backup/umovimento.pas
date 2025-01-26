unit umovimento;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, DB, Forms, Controls, Graphics, Dialogs, ExtCtrls, StdCtrls,
  DBExtCtrls, Buttons, DBGrids, LR_Class, LR_DBSet, ZDataset,
  ZAbstractRODataset, rxcurredit, utabela, ucad_lcto, classe_conta, LCLType, upesquisa;

type

  { Tfrmmovimento }

  Tfrmmovimento = class(TForm)
    btnINCLUI: TSpeedButton;
    dsMov: TDataSource;
    frDBDataSet1: TfrDBDataSet;
    frReport1: TfrReport;
    qrMovdata_mvto: TZDateField;
    qrMovdescricao: TZRawStringField;
    qrMovid_lcto: TZIntegerField;
    qrMovplano: TZRawStringField;
    qrMovvalor: TZBCDField;
    SaldoAnterior: TCurrencyEdit;
    DBGrid1: TDBGrid;
    dtINICIO: TDBDateEdit;
    dtFIM: TDBDateEdit;
    edtCOD: TEdit;
    edtDESC: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Panel1: TPanel;
    Panel2: TPanel;
    Panel3: TPanel;
    Panel4: TPanel;
    Panel5: TPanel;
    Panel6: TPanel;
    Panel7: TPanel;
    Panel8: TPanel;
    pnpTITULO: TPanel;
    btnOk: TSpeedButton;
    qrMov: TZQuery;
    SaldoPeriodo: TCurrencyEdit;
    btnIMPRIMI: TSpeedButton;
    SpeedButton3: TSpeedButton;
    procedure btnIMPRIMIClick(Sender: TObject);
    procedure btnINCLUIClick(Sender: TObject);
    procedure btnOkClick(Sender: TObject);
    procedure edtCODExit(Sender: TObject);
    procedure edtCODKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: char);
    procedure FormShow(Sender: TObject);
    procedure frReport1GetValue(const ParName: String; var ParValue: Variant);
    procedure SpeedButton3Click(Sender: TObject);
  private

    procedure Movimento(nCOD:Integer; dIinicio, dFinal:Tdate);

  public

  end;

var
  frmmovimento: Tfrmmovimento;
  conta : Tconta;

implementation

{$R *.lfm}

{ Tfrmmovimento }

procedure Tfrmmovimento.btnINCLUIClick(Sender: TObject);
begin
  frm_cad_lcto := Tfrm_cad_lcto.Create(Self);
  try
  frm_cad_lcto.edtConta.Text:=edtCOD.Text;
  frm_cad_lcto.edtDescConta.Text:=edtDESC.Text;
  frm_cad_lcto.ShowModal;
  finally
    FreeAndNil(frm_cad_lcto);
  end;
end;

procedure Tfrmmovimento.btnIMPRIMIClick(Sender: TObject);
begin
  if FileExists('rel_fluxo.lrf') then
    Begin
      frReport1.LoadFromFile('rel_fluxo.lrf');
      frReport1.ShowReport;
    end
  else
  ShowMessage('Arquivo do relatório não existe !');
end;

procedure Tfrmmovimento.btnOkClick(Sender: TObject);
begin
  IF dtINICIO.Date > dtFIM.Date then
    begin
      ShowMessage('A data final não pode ser MAIOR que a data final');
      Exit;
    end;
  SaldoAnterior.Value := lancamentos.SaldoAnterior(StrToIntDef(edtCOD.Text,0),dtINICIO.Date);
  SaldoPeriodo.Value  := lancamentos.SaldoAnterior(StrToIntDef(edtCOD.Text,0),dtINICIO.Date)+
                         lancamentos.SaldoPeriodo(StrToIntDef(edtCOD.Text,0), dtINICIO.Date, dtFIM.Date);
  Movimento(StrToIntDef(edtCOD.Text,0),dtINICIO.Date, dtFIM.Date);
end;

procedure Tfrmmovimento.edtCODExit(Sender: TObject);
begin
  if StrToIntDef(edtCOD.Text,0) > 0 then
     begin
       if conta.localiza(StrToIntDef(edtCOD.Text,0)) then
          edtDESC.Text:=conta.descricao
          else
            begin
            edtDESC.Text:='';
            edtCOD.SetFocus;
       end;
  end;
end;

procedure Tfrmmovimento.edtCODKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if key = VK_F4 then
     begin
     frmPesquisa := TfrmPesquisa.Create(self,['ID_CONTA','DESCRICAO','BANCO','CONTA'],
                                              'CONTAS',
                                              'ID_CONTA');
     TRY
       frmPesquisa.ShowModal;
       edtCOD.Text:= frmPesquisa.edtResultado.Text;
     finally
     end;
     end;
end;

procedure Tfrmmovimento.FormClose(Sender: TObject; var CloseAction: TCloseAction
  );
begin
  if Assigned(conta) then
  FreeAndNil(conta);
end;

procedure Tfrmmovimento.FormCreate(Sender: TObject);
begin
  conta := Tconta.Create;
end;

procedure Tfrmmovimento.FormKeyPress(Sender: TObject; var Key: char);
begin
  if key=#13 then
    begin
      SelectNext(ActiveControl as TWinControl,True,True);
      key:=#0;
    end;
end;

procedure Tfrmmovimento.FormShow(Sender: TObject);
begin
  dtINICIO.Date :=date -30;
  dtFIM.Date    :=date;
end;

procedure Tfrmmovimento.frReport1GetValue(const ParName: String;
  var ParValue: Variant);
begin
  if ParName = 'conta' then
     ParValue:=edtCOD.Text+' - '+edtDESC.Text;
    if ParName = 'periodo' then
       ParValue := ' de '+DateToStr(dtINICIO.Date)+' Até '+DateToStr(dtFIM.Date);
      if ParName = 'Saldo Inicial' then
        ParValue:= FloatToStr(SaldoAnterior.Value);
        if ParName = 'Saldofinal' then
         ParValue:= FloatToStr(SaldoPeriodo.Value);
end;

procedure Tfrmmovimento.SpeedButton3Click(Sender: TObject);
begin
  close;
end;

procedure Tfrmmovimento.Movimento(nCOD: Integer; dIinicio, dFinal: Tdate);
var
  cSQL : String;
begin
     cSQL:= 'Select l.id_lcto, l.data_mvto,p.descricao plano, '+
            'l.descricao , l.valor '+
            'from lancamentos l '+
            'join planos p on p.id_plano = l.plano '+
            'where l.conta = :nCOD '+
            'and l.data_mvto between :dIinicio and :dFINAL';
       if qrMov.Active then
          qrMov.Close;
          qrMov.SQL.Text:=cSQL;
          qrMov.ParamByName('nCOD').AsInteger  := nCOD;
          qrMov.ParamByName('dIinicio').AsDate := dIinicio;
          qrMov.ParamByName('dFinal').AsDate   := dFinal;
          qrMov.Open;
end;

end.

