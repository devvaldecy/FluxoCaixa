unit classe_conta;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Controls, ExtCtrls, Dialogs, utabela, ZDataset;

  Type

    { Tconta }

    Tconta = Class


      private
        Fagencia: String;
        Fbanco: String;
        Fconta: String;
        Fdescricao: String;
        Fid_conta: Integer;

        function retornaAI:Integer;

       public
         function incluir:Boolean;
         function localiza(codigo:Integer):Boolean;
         function altera(codigo:Integer)  :Boolean;
         function exclui(codigo:Integer)  :Boolean;
         published
           property id_conta  : Integer read Fid_conta write Fid_conta;
           property descricao : String read Fdescricao write Fdescricao;
           property banco      : String read Fbanco write Fbanco;
           property agencia      : String read Fagencia write Fagencia;
           property conta      : String read Fconta write Fconta;
    end;

implementation

{ Tconta }

function Tconta.retornaAI: Integer;
Var
  qrAI : TZQuery;
begin

  // Autoincremento do código id_conta

  qrAI := TZQuery.Create(nil);
  qrAI.Connection := TabGlobal.conexao;
  qrAI.SQL.Add('select coalesce(max(id_conta),0)+1 codigo');
  qrAI.SQL.Add('from contas');
  qrAI.Open;
  //ShowMessage(IntToStr(qrAI.FieldByName('codigo').Value));
  Result := qrAI.FieldByName('codigo').Value;
    if Assigned(qrAI) then
    FreeAndNil(qrAI);
end;

function Tconta.incluir: Boolean;
Var
  qrINC : TZQuery;
  cSQL  : String;
begin

  // Incluir dados na tabela conta

  cSQL:= 'INSERT INTO contas'+
         ' (id_conta, descricao, banco, agencia, conta)'+
         'VALUES'+
         '(:id_conta, :descricao, :banco, :agencia, :conta)';


  qrINC := TZQuery.Create(nil);
  qrINC.Connection := TabGlobal.conexao;
  qrINC.SQL.Text:=cSQL;
  qrINC.ParamByName('id_conta').AsInteger :=retornaAI;
  qrINC.ParamByName('descricao').AsString :=descricao;
  qrINC.ParamByName('banco').AsString     :=banco;
  qrINC.ParamByName('agencia').AsString   :=agencia;
  qrINC.ParamByName('conta').AsString     :=conta;
  try
    qrINC.ExecSQL;
    Result := true;
  Except
    on e: Exception do
    Begin
      Result := false;
      ShowMessage('Erro ao incluir a conta'+sLineBreak+
      e.ClassName+sLineBreak+e.Message);
    end;
  end;
  if Assigned(qrINC) then
  FreeAndNil(qrINC);
end;

function Tconta.localiza(codigo: Integer): Boolean;
Var
  qrPESQUISA : TZQuery;
begin

  //Pesquisa de dados na tabela conta

  qrPESQUISA := TZQuery.Create(nil);
  qrPESQUISA.Connection := TabGlobal.conexao;
  qrPESQUISA.SQL.Add('select * from contas');
  qrPESQUISA.SQL.Add('where id_conta = :nCODIGO');
  qrPESQUISA.ParamByName('nCODIGO').AsInteger:=codigo;
  qrPESQUISA.Open;
    if qrPESQUISA.RecordCount >= 1 then
    begin
      Self.id_conta  := qrPESQUISA.FieldByName('id_conta').AsInteger;
      Self.descricao := qrPESQUISA.FieldByName('descricao').AsString;
      Self.banco     := qrPESQUISA.FieldByName('banco').AsString;
      Self.agencia   := qrPESQUISA.FieldByName('agencia').AsString;
      Self.conta     := qrPESQUISA.FieldByName('conta').AsString;
      Result := true;
    end
    else
      Result := false;
    if Assigned(qrPESQUISA) then
    FreeAndNil(qrPESQUISA);
end;

function Tconta.altera(codigo: Integer): Boolean;
Var
  qrALT : TZQuery;
  cSQL  : String;
begin

  // Alterar dados da tabela contas

  cSQL:=  'UPDATE contas SET '+
          '   descricao = :descricao, '+
          '   banco = :banco, '+
          '   agencia = :agencia, '+
          '   conta = :conta '+
          'WHERE'+
          '   id_conta = :OLD_id_conta';

  qrALT := TZQuery.Create(nil);
  qrALT.Connection := TabGlobal.conexao;
  qrALT.SQL.Text:=cSQL;
  qrALT.ParamByName('OLD_id_conta').AsInteger := codigo;
  qrALT.ParamByName('descricao').AsString     := descricao;
  qrALT.ParamByName('banco').AsString         :=banco;
  qrALT.ParamByName('agencia').AsString       :=agencia;
  qrALT.ParamByName('conta').AsString         :=conta;
  try
    qrALT.ExecSQL;
    Result := true;
  Except
    on e: Exception do
    Begin
      Result := false;
      ShowMessage('Erro ao atualizar a conta'+sLineBreak+
      e.ClassName+sLineBreak+e.Message);
    end;
  end;
  if Assigned(qrALT) then
  FreeAndNil(qrALT);
  end;

function Tconta.exclui(codigo: Integer): Boolean;
Var
  qrEXC : TZQuery;
  cSQL  : String;
begin

  // Alterar dados da tabela contas

  cSQL:=  'DELETE FROM contas '+
          'WHERE '+
          'contas.id_conta = :OLD_id_conta';


  qrEXC := TZQuery.Create(nil);
  qrEXC.Connection := TabGlobal.conexao;
  qrEXC.SQL.Text:=cSQL;
  qrEXC.ParamByName('OLD_id_conta').AsInteger:= codigo;
  try
    qrEXC.ExecSQL;
    Result := true;
  Except
    on e: Exception do
    Begin
      Result := false;
      ShowMessage('Erro ao excluir a conta'+sLineBreak+
      e.ClassName+sLineBreak+e.Message);
    end;
  end;
  if Assigned(qrEXC) then
  FreeAndNil(qrEXC);
  end;

end.

