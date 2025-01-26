unit ucad_planoconta;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, DB, Forms, utabela, Graphics, Dialogs, StdCtrls, DBGrids,
  ZDataset, ZAbstractRODataset, ZSqlUpdate, ucad_padrao, Controls, classe_plano;

type

  { Tfrmcad_planoconta }

  Tfrmcad_planoconta = class(Tfrmcad_padrao)
    cmbTipo: TComboBox;
    dsPESQ: TDataSource;
    DBGrid1: TDBGrid;
    EdtCODIGO: TEdit;
    EdtDescricao: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    qrPESQ: TZQuery;
    qrPESQdescricao: TZRawStringField;
    qrPESQid_plano: TZIntegerField;
    qrPESQtipo: TZRawStringField;
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
    procedure FormShow(Sender: TObject);
  private

  public

  end;

var
  frmcad_planoconta: Tfrmcad_planoconta;
  plano : Tplano;

implementation

{$R *.lfm}

{ Tfrmcad_planoconta }

procedure Tfrmcad_planoconta.FormKeyPress(Sender: TObject; var Key: char);
begin
  if key=#13 then begin
  SelectNext(ActiveControl as TWinControl,True,True);
  key:=#0;
  end;
end;

procedure Tfrmcad_planoconta.FormShow(Sender: TObject);
begin
  inherited;
  if not qrPESQ.Active then
  qrPESQ.Open;
end;

procedure Tfrmcad_planoconta.BtnPesquisaClick(Sender: TObject);
begin
  if qrPESQ.Active then qrPESQ.Close;
  qrPESQ.SQL.Clear;
  qrPESQ.SQL.Add('Select * from planos');
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

procedure Tfrmcad_planoconta.BtnApagaClick(Sender: TObject);
begin
  if StrToIntDef(EdtCODIGO.Text, 0) = 0 then
  begin
       ShowMessage('Nenhum registro encontrado...');
       cliquebotao:=cbNome;
       Abort;
   end;
  inherited;
    if QuestionDlg('Confirmação','Excluir o Registro',mtConfirmation,
       [mrYes,'Sim', mrNo, 'Não'],0) = mrYes then
       plano.exclui(plano.id_plano);
       cliquebotao:=cbNome;
end;

procedure Tfrmcad_planoconta.BtnAlteraClick(Sender: TObject);
begin
  if StrToIntDef(EdtCODIGO.Text, 0) = 0 then
  begin
       ShowMessage('Nenhum registro encontrado...');
       cliquebotao:=cbNome;
       Abort;
   end;
  inherited;
end;

procedure Tfrmcad_planoconta.BtnCancelaClick(Sender: TObject);
begin
  inherited;
  cliquebotao:=cbNome;
end;

procedure Tfrmcad_planoconta.BtnIncluirClick(Sender: TObject);
begin
  inherited;
  EdtCODIGO.Clear;
  EdtDescricao.Clear;
end;

procedure Tfrmcad_planoconta.BtnSalvaClick(Sender: TObject);
begin
  inherited;

  plano.id_plano  :=StrToIntDef(EdtCODIGO.Text,0);
  plano.descricao :=EdtDescricao.Text;
  plano.tipo      :=cmbTipo.Text;
  if cliquebotao = cbAlterar then
     plano.altera(plano.id_plano)
  else if cliquebotao = cbincluir then
  plano.incluir;
  cliquebotao:=cbNome;
  ShowMessage('Registro salvo com sucesso...');
  EdtDescricao.SetFocus;
end;

procedure Tfrmcad_planoconta.DBGrid1DblClick(Sender: TObject);
begin
  if plano.localiza(qrPESQid_plano.Value) then
    begin
    PageControl1.PageIndex:=1;
    EdtCODIGO.Text    := IntToStr(plano.id_plano);
    EdtDescricao.Text := plano.descricao;
    cmbTipo.Text      := plano.tipo;
    end;
end;

procedure Tfrmcad_planoconta.FormClose(Sender: TObject;
  var CloseAction: TCloseAction);
begin
  if Assigned(plano) then
  FreeAndNil(plano);
end;

procedure Tfrmcad_planoconta.FormCreate(Sender: TObject);
begin
  plano := Tplano.Create;
end;

end.

