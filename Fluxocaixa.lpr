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
  ucad_lcto, umovimento, upesquisa, ucadusuarios, usobre;

{$R *.res}

begin
  RequireDerivedFormResource:=True;
  Application.Scaled:=True;
  Application.Initialize;
  Application.CreateForm(TTabGlobal, TabGlobal);
  Application.CreateForm(Tfrmprincipal, frmprincipal);
  Application.CreateForm(Tfrm_cad_lcto, frm_cad_lcto);
  Application.CreateForm(Tfrmmovimento, frmmovimento);
  Application.CreateForm(TfrmPesquisa, frmPesquisa);
  Application.CreateForm(TfrmSobre, frmSobre);
  Application.Run;
end.

