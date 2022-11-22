unit UvalidadorUsuario;

interface

uses Uusuario, system.sysutils;

type TValidadorUsuario = class
  private

  protected

  public
  class procedure Validar(PUsuario: TUsuario; PSenhaConfirmação:String);

end;
implementation

{ TValidadorUsuario }

class procedure TValidadorUsuario.Validar(PUsuario: TUsuario; PSenhaConfirmação:String);
begin
//(nome,login,cpf) não pode ser vazio
//quantidade de caractere do login
//so numero no cpf
//nome n pode ser numero
//validar carcteres especiais nos campos
//senha = confirmação de senha
//cpf é valido

  if PUsuario.login.IsEmpty then begin
    raise Exception.Create('O Campo login não pode ser vazio');
  end;

    if PUsuario.senha.IsEmpty then begin
    raise Exception.Create('O Campo senha não pode ser vazio');
  end;

  if PUsuario.senha <> PSenhaConfirmação then begin
    raise Exception.Create('As senha não conferem');
  end;


end;

end.
