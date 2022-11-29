unit UvalidadorUsuario;

interface

uses Uusuario, system.sysutils;

type TValidadorUsuario = class
  private

  protected

  public
  class procedure Validar(PUsuario: TUsuario; PSenhaConfirmação:String);
  class function isCPF(CPF: string): boolean;
end;
implementation

{ TValidadorUsuario }

uses UfrmRegistrar;

//validarCPF
class function TValidadorUsuario.isCPF(CPF: string): boolean;
var  dig10, dig11: string;
    s, i, r, peso: integer;
begin
// length - retorna o tamanho da string (CPF é um número formado por 11 dígitos)
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

// try - protege o código para eventuais erros de conversão de tipo na função StrToInt
  try
{ *-- Cálculo do 1o. Digito Verificador --* }
    s := 0;
    peso := 10;
    for i := 1 to 9 do
    begin
// StrToInt converte o i-ésimo caractere do CPF em um número
      s := s + (StrToInt(CPF[i]) * peso);
      peso := peso - 1;
    end;
    r := 11 - (s mod 11);
    if ((r = 10) or (r = 11))
       then dig10 := '0'
    else str(r:1, dig10); // converte um número no respectivo caractere numérico

{ *-- Cálculo do 2o. Digito Verificador --* }
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

class procedure TValidadorUsuario.Validar(PUsuario: TUsuario; PSenhaConfirmação:String);
begin
//cpf) não pode ser vazio
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

  if length(Pusuario.login) > 9 then begin
    raise exception.Create('Login não pode passar de 9 caracteres');
  end;

  if not TValidadorUsuario.isCPF(PUsuario.CPF) then begin
    raise Exception.Create('CPF inválido');
  end;
end;

end.
