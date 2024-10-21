program Fluxocaixa;

{$mode objfpc}{$H+}

uses
  {$IFDEF UNIX}
  cthreads,
  {$ENDIF}
  {$IFDEF HASAMIGA}
  athreads,
  {$ENDIF}
  Interfaces, // this includes the LCL widgetset
  Forms, rxnew, datetimectrls, zcomponent, uprincipal, uconfigurabanco, utabela,
  ucad_padrao, ucad_planoconta, classe_plano, ucad_contas, classe_lancamento,
  ucad_lcto, umovimento, upesquisa, u_login;

{$R *.res}

begin
  RequireDerivedFormResource:=True;
  Application.Scaled:=True;
  Application.Initialize;
  Application.CreateForm(TTabGlobal, TabGlobal);
  Application.CreateForm(Tfrmprincipal, frmprincipal);
  Application.CreateForm(Tfrmlogin, frmlogin);
  Application.CreateForm(TfrmPesquisa, frmPesquisa);
  Application.Run;
end.

