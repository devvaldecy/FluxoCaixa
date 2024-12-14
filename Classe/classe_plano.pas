unit classe_plano;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Controls, ExtCtrls, Dialogs, utabela, ZDataset;

  Type

    { Tplano }

    Tplano = Class


      private
        Fdescricao: String;
        Fid_plano: Integer;
        Ftipo: String;
        function retornaAI:Integer;

       public
         function incluir:Boolean;
         function localiza(codigo:Integer):Boolean;
         function altera(codigo:Integer)  :Boolean;
         function exclui(codigo:Integer)  :Boolean;
         published
           property id_plano  : Integer read Fid_plano write Fid_plano;
           property descricao : String read Fdescricao write Fdescricao;
           property tipo      : String read Ftipo write Ftipo;
    end;

implementation

{ Tplano }

function Tplano.retornaAI: Integer;
Var
  qrAI : TZQuery;
begin

  // Autoincremento do código id_plano

  qrAI := TZQuery.Create(nil);
  qrAI.Connection := TabGlobal.conexao;
  qrAI.SQL.Add('select coalesce(max(id_plano),0)+1 codigo');
  qrAI.SQL.Add('from planos');
  qrAI.Open;
  //ShowMessage(IntToStr(qrAI.FieldByName('codigo').Value));
  Result := qrAI.FieldByName('codigo').Value;
    if Assigned(qrAI) then
    FreeAndNil(qrAI);
end;

function Tplano.incluir: Boolean;
Var
  qrINC : TZQuery;
  cSQL  : String;
begin

  // Incluir dados na tabela plano

  cSQL:= 'INSERT INTO planos'+
         ' (id_plano, descricao, tipo)'+
         'VALUES'+
         '(:id_plano, :descricao, :tipo)';


  qrINC := TZQuery.Create(nil);
  qrINC.Connection := TabGlobal.conexao;
  qrINC.SQL.Text:=cSQL;
  qrINC.ParamByName('id_plano').AsInteger:=retornaAI;
  qrINC.ParamByName('descricao').AsString:=descricao;
  qrINC.ParamByName('tipo').AsString     :=tipo;
  try
    qrINC.ExecSQL;
    Result := true;
  Except
    on e: Exception do
    Begin
      Result := false;
      ShowMessage('Erro ao incluir o plano'+sLineBreak+
      e.ClassName+sLineBreak+e.Message);
    end;
  end;
  if Assigned(qrINC) then
  FreeAndNil(qrINC);
end;

function Tplano.localiza(codigo: Integer): Boolean;
Var
  qrPESQUISA : TZQuery;
begin

  //Pesquisa de dados na tabela plano

  qrPESQUISA := TZQuery.Create(nil);
  qrPESQUISA.Connection := TabGlobal.conexao;
  qrPESQUISA.SQL.Add('select * from planos');
  qrPESQUISA.SQL.Add('where id_plano = :nCODIGO');
  qrPESQUISA.ParamByName('nCODIGO').AsInteger:=codigo;
  qrPESQUISA.Open;
    if qrPESQUISA.RecordCount >= 1 then
    begin
      Self.id_plano  := qrPESQUISA.FieldByName('id_plano').AsInteger;
      Self.descricao := qrPESQUISA.FieldByName('descricao').AsString;
      Self.tipo      := qrPESQUISA.FieldByName('tipo').AsString;
      Result := true;
    end
    else
      Result := false;
    if Assigned(qrPESQUISA) then
    FreeAndNil(qrPESQUISA);
end;

function Tplano.altera(codigo: Integer): Boolean;
Var
  qrALT : TZQuery;
  cSQL  : String;
begin

  // Alterar dados da tabela planos

  cSQL:=  'UPDATE planos SET '+
          '   descricao = :descricao, '+
          '   tipo = :tipo '+
          'WHERE'+
          '   id_plano = :OLD_id_plano';

  qrALT := TZQuery.Create(nil);
  qrALT.Connection := TabGlobal.conexao;
  qrALT.SQL.Text:=cSQL;
  qrALT.ParamByName('OLD_id_plano').AsInteger:= codigo;
  qrALT.ParamByName('descricao').AsString    := descricao;
  qrALT.ParamByName('tipo').AsString         := tipo;
  try
    qrALT.ExecSQL;
    Result := true;
  Except
    on e: Exception do
    Begin
      Result := false;
      ShowMessage('Erro ao atualizar o plano'+sLineBreak+
      e.ClassName+sLineBreak+e.Message);
    end;
  end;
  if Assigned(qrALT) then
  FreeAndNil(qrALT);
  end;

function Tplano.exclui(codigo: Integer): Boolean;
Var
  qrEXC : TZQuery;
  cSQL  : String;
begin

  // Alterar dados da tabela planos

  cSQL:=  'DELETE FROM planos '+
          'WHERE '+
          'planos.id_plano = :OLD_id_plano';


  qrEXC := TZQuery.Create(nil);
  qrEXC.Connection := TabGlobal.conexao;
  qrEXC.SQL.Text:=cSQL;
  qrEXC.ParamByName('OLD_id_plano').AsInteger:= codigo;
  try
    qrEXC.ExecSQL;
    Result := true;
  Except
    on e: Exception do
    Begin
      Result := false;
      ShowMessage('Erro ao excluir o plano'+sLineBreak+
      e.ClassName+sLineBreak+e.Message);
    end;
  end;
  if Assigned(qrEXC) then
  FreeAndNil(qrEXC);
  end;

end.

