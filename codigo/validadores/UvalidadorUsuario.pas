unit UvalidadorUsuario;

interface

uses Uusuario, system.sysutils;

type TValidadorUsuario = class
  private

  protected

  public
  class procedure Validar(PUsuario: TUsuario; PSenhaConfirma��o:String);

end;
implementation

{ TValidadorUsuario }

class procedure TValidadorUsuario.Validar(PUsuario: TUsuario; PSenhaConfirma��o:String);
begin
//(nome,login,cpf) n�o pode ser vazio
//quantidade de caractere do login
//so numero no cpf
//nome n pode ser numero
//validar carcteres especiais nos campos
//senha = confirma��o de senha
//cpf � valido

  if PUsuario.login.IsEmpty then begin
    raise Exception.Create('O Campo login n�o pode ser vazio');
  end;

    if PUsuario.senha.IsEmpty then begin
    raise Exception.Create('O Campo senha n�o pode ser vazio');
  end;

  if PUsuario.senha <> PSenhaConfirma��o then begin
    raise Exception.Create('As senha n�o conferem');
  end;


end;

end.
