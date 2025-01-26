unit classe_lancamento;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Controls, ExtCtrls, Dialogs, ZDataset, utabela;

  Type

     { Tlancamento }

     Tlancamento = Class
       private
         Tcod_plano: Integer;
         Tconta: Integer;
         Tdata_mvto: TDate;
         Tdescricao: String;
         Tid_lcto: Integer;
         Tvalor: Double;
         published
           property conta     : Integer read Tconta     write Tconta;
           property id_lcto   : Integer read Tid_lcto   write Tid_lcto;
           property data_mvto : TDate   read Tdata_mvto write Tdata_mvto;
           property cod_plano : Integer read Tcod_plano write Tcod_plano;
           property descricao : String  read Tdescricao write Tdescricao;
           property valor     : Double  read Tvalor     write Tvalor;
           public
             function inclui:Boolean;
             function autoinc(nCONTA:Integer):Integer;
             function SaldoAnterior(nCONTA:integer; dINICIO:TDate):Real;
             function SaldoPeriodo(nCONTA:integer; dINICIO, dFINAL :TDate):Real;
     end;

implementation

{ Tlancamento }

function Tlancamento.inclui: Boolean;
Var
  qrINC : TZQuery;
  cSQL  : String;
begin

  // Incluir dados na tabela Lançamento

  cSQL:= 'INSERT INTO lancamentos ' +
         '(conta, id_lcto, data_mvto, plano, descricao, valor) ' +
         'VALUES' +
         '(:conta, :id_lcto, :data_mvto, :plano, :descricao, :valor)';


  qrINC := TZQuery.Create(nil);
  qrINC.Connection := TabGlobal.conexao;
  qrINC.SQL.Text:=cSQL;
  qrINC.ParamByName('conta').AsInteger     :=conta;
  qrINC.ParamByName('id_lcto').AsInteger   :=autoinc(conta);
  qrINC.ParamByName('data_mvto').AsDate    :=data_mvto;
  //qrINC.ParamByName('tipo').AsString       :=tipo;
  qrINC.ParamByName('plano').AsInteger     :=cod_plano;
  qrINC.ParamByName('descricao').AsString  :=descricao;
  qrINC.ParamByName('valor').AsFloat       :=valor;
  try
    qrINC.ExecSQL;
    Result := true;
  Except
    on e: Exception do
    Begin
      Result := false;
      ShowMessage('Erro ao incluir o Lançamento'+sLineBreak+
      e.ClassName+sLineBreak+e.Message);
    end;
  end;
  if Assigned(qrINC) then
  FreeAndNil(qrINC);
end;

function Tlancamento.autoinc(nCONTA: Integer): Integer;
Var
  qrAI : TZQuery;
  cSQL  : String;
begin

  cSQL:=
  'select coalesce (max(id_lcto),0)+1 idlcto ' +
  'from lancamentos where conta = :nCOD ';

  qrAI := TZQuery.Create(nil);
  qrAI.Connection := TabGlobal.conexao;
  qrAI.SQL.Text:=cSQL;
  qrAI.ParamByName('nCOD').AsInteger:=nCONTA;
  qrAI.Open;
  Result := qrAI.FieldByName('idlcto').AsInteger;
  qrAI.Close;
  if Assigned(qrAI) then
  FreeAndNil(qrAI);
end;

function Tlancamento.SaldoAnterior(nCONTA: integer; dINICIO: TDate): Real;
Var

  qrSaldoAnterior : TZQuery;
  cSQL  : String;

begin
     cSQL:= 'select coalesce(sum(l.valor),0) Saldo_Anterior '+
            'from lancamentos l '+
            'where l.conta = :nCOD '+
            'and l.data_mvto < :dINICIO';

  qrSaldoAnterior := TZQuery.Create(nil);
  qrSaldoAnterior.Connection := TabGlobal.conexao;
  qrSaldoAnterior.SQL.Text:=cSQL;
  qrSaldoAnterior.ParamByName('nCOD').AsInteger:=nCONTA;
  qrSaldoAnterior.ParamByName('dINICIO').AsDate:=dINICIO;
  qrSaldoAnterior.Open;
  Result := qrSaldoAnterior.FieldByName('Saldo_Anterior').AsInteger;
  qrSaldoAnterior.Close;
  if Assigned(qrSaldoAnterior) then
  FreeAndNil(qrSaldoAnterior);
end;

function Tlancamento.SaldoPeriodo(nCONTA: integer; dINICIO, dFINAL: TDate
  ): Real;
Var

  qrSaldoAnterior : TZQuery;
  cSQL  : String;

begin
     cSQL:= 'select coalesce (sum(l.valor),0) SaldoPeriodo '+
            'from lancamentos l '+
            'where l.conta = :nCOD '+
            'and l.data_mvto between :dInicio and :dFinal';

  qrSaldoAnterior := TZQuery.Create(nil);
  qrSaldoAnterior.Connection := TabGlobal.conexao;
  qrSaldoAnterior.SQL.Text:=cSQL;
  qrSaldoAnterior.ParamByName('nCOD').AsInteger:=nCONTA;
  qrSaldoAnterior.ParamByName('dInicio').AsDate:=dINICIO;
  qrSaldoAnterior.ParamByName('dFinal').AsDate :=dFINAL;
  qrSaldoAnterior.Open;
  Result := qrSaldoAnterior.FieldByName('SaldoPeriodo').AsInteger;
  qrSaldoAnterior.Close;
  if Assigned(qrSaldoAnterior) then
  FreeAndNil(qrSaldoAnterior);
end;

end.

