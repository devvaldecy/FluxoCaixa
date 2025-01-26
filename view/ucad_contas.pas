unit ucad_contas;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, ComCtrls,
  DBGrids, ZDataset, ZAbstractRODataset, ucad_padrao, Types, DB, classe_conta;

type

  { Tfrmcad_contas }

  Tfrmcad_contas = class(Tfrmcad_padrao)
    DBGrid1: TDBGrid;
    dsPESQ: TDataSource;
    EdtCODIGO: TEdit;
    EdtDescricao: TEdit;
    EdtBANCO: TEdit;
    EdtAGENCIA: TEdit;
    EdtCONTA: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    qrPESQ: TZQuery;
    qrPESQagencia: TZRawStringField;
    qrPESQbanco: TZRawStringField;
    qrPESQconta: TZRawStringField;
    qrPESQdescricao: TZRawStringField;
    qrPESQid_conta: TZIntegerField;
    procedure BtnAlteraClick(Sender: TObject);
    procedure BtnApagaClick(Sender: TObject);
    procedure BtnCancelaClick(Sender: TObject);
    procedure BtnIncluirClick(Sender: TObject);
    procedure BtnPesquisaClick(Sender: TObject);
    procedure BtnSalvaClick(Sender: TObject);
    procedure DBGrid1DblClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: char);
    procedure TsCadastroContextPopup(Sender: TObject; MousePos: TPoint;
      var Handled: Boolean);
  private

  public

  end;

var
  frmcad_contas: Tfrmcad_contas;
  conta : tconta;

implementation

{$R *.lfm}

{ Tfrmcad_contas }

procedure Tfrmcad_contas.TsCadastroContextPopup(Sender: TObject;
  MousePos: TPoint; var Handled: Boolean);
begin

end;

procedure Tfrmcad_contas.BtnPesquisaClick(Sender: TObject);
begin
    if qrPESQ.Active then qrPESQ.Close;
    qrPESQ.SQL.Clear;
    qrPESQ.SQL.Add('Select * from contas');
    qrPESQ.SQL.Add('where descricao like :cPESQ');
    qrPESQ.ParamByName('cPESQ').AsString:= '%'+Trim(edtPESQUISA.Text+'%');
    try
      qrPESQ.Open;
    except
      on e: exception do
      ShowMessage('Erro ao Realizar Consulta..'+sLineBreak+
      e.ClassName+sLineBreak+ e.Message);
    end;
      if qrPESQ.RecordCount <= 0 then
      ShowMessage('Nenhum Regsitro encontrado...');
      edtPESQUISA.SetFocus;

end;

procedure Tfrmcad_contas.BtnSalvaClick(Sender: TObject);
begin
  inherited;

  conta.id_conta  :=StrToIntDef(EdtCODIGO.Text,0);
  conta.descricao :=EdtDescricao.Text;
  conta.banco     :=EdtBANCO.Text;
  conta.agencia   :=EdtAGENCIA.Text;
  conta.conta     :=EdtCONTA.Text;
  if cliquebotao = cbAlterar then
     conta.altera(conta.id_conta)
  else if cliquebotao = cbincluir then
  conta.incluir;
  cliquebotao:=cbNome;
  ShowMessage('Dados salvo com sucesso...');
  EdtDescricao.SetFocus;
end;

procedure Tfrmcad_contas.BtnIncluirClick(Sender: TObject);
begin
  inherited;
end;

procedure Tfrmcad_contas.BtnAlteraClick(Sender: TObject);
begin
  if StrToIntDef(EdtCODIGO.Text, 0) = 0 then
  begin
       ShowMessage('Nenhum registro encontrado...');
       cliquebotao:=cbNome;
       Abort;
   end;
  inherited;
end;

procedure Tfrmcad_contas.BtnApagaClick(Sender: TObject);
begin
    if StrToIntDef(EdtCODIGO.Text, 0) = 0 then
  begin
       ShowMessage('Nenhum registro encontrado...');
       cliquebotao:=cbNome;
       Abort;
   end;
  if QuestionDlg('Confirmação','Excluir o Registro',mtConfirmation,
       [mrYes,'Sim', mrNo, 'Não'],0) = mrYes then
       conta.exclui(conta.id_conta);
    inherited;
       qrPESQ.Refresh;
       PageControl1.PageIndex:=0;
       cliquebotao:=cbNome;
end;

procedure Tfrmcad_contas.BtnCancelaClick(Sender: TObject);
begin
  inherited;
  cliquebotao:=cbNome;
end;

procedure Tfrmcad_contas.DBGrid1DblClick(Sender: TObject);
begin
    if conta.localiza(qrPESQid_conta.Value) then
    begin
    PageControl1.PageIndex:=1;
    EdtCODIGO.Text    := IntToStr(conta.id_conta);
    EdtDescricao.Text := conta.descricao;
    EdtBANCO.Text     := conta.banco;
    EdtAGENCIA.Text   := conta.agencia;
    EdtCONTA.Text     := conta.conta;
    end;
end;

procedure Tfrmcad_contas.FormClose(Sender: TObject;
  var CloseAction: TCloseAction);
begin
  if Assigned(conta) then
    FreeAndNil(conta);
end;

procedure Tfrmcad_contas.FormCreate(Sender: TObject);
begin
  conta := Tconta.Create;
end;

procedure Tfrmcad_contas.FormKeyPress(Sender: TObject; var Key: char);
begin
  if key=#13 then begin
    SelectNext(ActiveControl as TWinControl,True,True);
    key:=#0;
  end;
end;

end.

