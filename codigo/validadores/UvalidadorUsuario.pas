unit UvalidadorUsuario;

interface

uses Uusuario, system.sysutils;

type TValidadorUsuario = class
  private

  protected

  public
  class procedure Validar(PUsuario: TUsuario; PSenhaConfirma��o:String);
  class function isCPF(CPF: string): boolean;

  Const MAXIMO_CARACTERES: Integer = 9;  //Valor maximo de caracteres para colocar no campo de registro login
end;
implementation

{ TValidadorUsuario }

uses UfrmRegistrar;

//validarCPF
class function TValidadorUsuario.isCPF(CPF: string): boolean;
var  dig10, dig11: string;
    s, i, r, peso: integer;
begin
// length - retorna o tamanho da string (CPF � um n�mero formado por 11 d�gitos)
  if ((CPF = '00000000000') or (CPF = '11111111111') or
      (CPF = '22222222222') or (CPF = '33333333333') or
      (CPF = '44444444444') or (CPF = '55555555555') or
      (CPF = '66666666666') or (CPF = '77777777777') or
      (CPF = '88888888888') or (CPF = '99999999999') or
      (length(CPF) <> 11))
     then begin
              isCPF := false;
              exit;
            end;

// try - protege o c�digo para eventuais erros de convers�o de tipo na fun��o StrToInt
  try
{ *-- C�lculo do 1o. Digito Verificador --* }
    s := 0;
    peso := 10;
    for i := 1 to 9 do
    begin
// StrToInt converte o i-�simo caractere do CPF em um n�mero
      s := s + (StrToInt(CPF[i]) * peso);
      peso := peso - 1;
    end;
    r := 11 - (s mod 11);
    if ((r = 10) or (r = 11))
       then dig10 := '0'
    else str(r:1, dig10); // converte um n�mero no respectivo caractere num�rico

{ *-- C�lculo do 2o. Digito Verificador --* }
    s := 0;
    peso := 11;
    for i := 1 to 10 do
    begin
      s := s + (StrToInt(CPF[i]) * peso);
      peso := peso - 1;
    end;
    r := 11 - (s mod 11);
    if ((r = 10) or (r = 11))
       then dig11 := '0'
    else str(r:1, dig11);

{ Verifica se os digitos calculados conferem com os digitos informados. }
    if ((dig10 = CPF[10]) and (dig11 = CPF[11]))
       then isCPF := true
    else isCPF := false;
  except
    isCPF := false
  end;
end;

class procedure TValidadorUsuario.Validar(PUsuario: TUsuario; PSenhaConfirma��o:String);
begin
//cpf) n�o pode ser vazio
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

  if length(Pusuario.login) > MAXIMO_CARACTERES then begin
    raise exception.Create('Login n�o pode passar de 9 caracteres');
  end;

  if not TValidadorUsuario.isCPF(PUsuario.CPF) then begin
    raise Exception.Create('CPF inv�lido');
  end;
end;

end.
