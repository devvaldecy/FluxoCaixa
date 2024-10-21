unit utabela;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, ZConnection;

type

  { TTabGlobal }

  TTabGlobal = class(TDataModule)
    conexao: TZConnection;
    procedure conexaoBeforeConnect(Sender: TObject);
  private

  public

  end;

var
  TabGlobal: TTabGlobal;

implementation
uses uprincipal, upesquisa, u_login;

{$R *.lfm}

{ TTabGlobal }

procedure TTabGlobal.conexaoBeforeConnect(Sender: TObject);
begin
  conexao.Database   := cfg_banco;
  conexao.HostName   := cfg_servidor;
  conexao.User       := cfg_usuario;
  conexao.Password   := cfg_senha;
  conexao.Port       := cfg_porta;
  conexao.AutoCommit := true;
  {$IfDef windows }
  conexao.LibraryLocation:= cfg_pathApp+'libmariadb.dll';
  {$EndIf}

end;













end.

