unit usobre;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ExtCtrls, StdCtrls,
  Buttons;

type

  { TfrmSobre }

  TfrmSobre = class(TForm)
    Image1: TImage;
    imgLogo: TImage;
    Label1: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    Label15: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Panel1: TPanel;
    pnlCentro: TPanel;
    pnlTop: TPanel;
    pnlLeste: TPanel;
    BtnFechar: TSpeedButton;
    Shape1: TShape;
    shLinha: TShape;
    BtnSair: TSpeedButton;
    procedure BtnFecharClick(Sender: TObject);
    procedure BtnSairClick(Sender: TObject);
  private

  public

  end;

var
  frmSobre: TfrmSobre;

implementation

{$R *.lfm}

{ TfrmSobre }

procedure TfrmSobre.BtnFecharClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmSobre.BtnSairClick(Sender: TObject);
begin
  Close;
end;

end.

