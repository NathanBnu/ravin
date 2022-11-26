unit UfrmListarUsuarios;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, UfrmBotaoPrimario, System.Generics.Collections;

type
  TfrmListarUsuarios = class(TForm)
    Label1: TLabel;
    mmLista: TMemo;
    frmBotaoPrimario1: TfrmBotaoPrimario;
    procedure frmBotaoPrimario1spbBotaoPrimarioClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmListarUsuarios: TfrmListarUsuarios;

implementation

{$R *.dfm}

uses UusuarioDao, Uusuario;

procedure TfrmListarUsuarios.frmBotaoPrimario1spbBotaoPrimarioClick(
  Sender: TObject);
var
  LDao: TUsuarioDao;
  LUsuario: TUsuario;
  LLista: TList<TUsuario>;
  I: integer;
begin
  LDao := TUsuarioDao.Create;

  LLista := LDao.BuscarTodosUsuarios;

  for I := 0 to Llista.Count -1 do
  begin
    LUsuario := Llista.Items[i];
    mmLista.Lines.Add(LUsuario.login);
    freeandnil(Lusuario);
  end;

  freeandnil(LDao);
  Freeandnil(Llista);
end;

end.
