unit UusuarioDao;

interface
uses
  Uusuario, FireDAC.Comp.Client, System.SysUtils, System.Classes,System.Generics.Collections;

type TUsuarioDAO = class
  private

  protected

  public
  //Metodos
  function BuscarTodosUsuarios(): TList<TUsuario>;
  function BuscarUsuarioPorLoginSenha(PLogin: String; PSenha: String) : TUsuario;
  procedure InserirUsuario(PUsuario: TUsuario);
end;

implementation

uses
  UdmRavin;

{ TUsuarioDAO }

function TUsuarioDAO.BuscarTodosUsuarios: TList<TUsuario>;
var
  LQuery: TFDQuery;
  LLista: TList<TUsuario>;
  LUsuario: TUsuario;
begin
  LQuery := TFDQuery.Create(nil);
  LQuery.Connection := dmRavin.cnxBancoDeDados;
  LQuery.SQL.Text := 'SELECT * FROM usuario';
  LQuery.Open();

  Llista := TList<TUsuario>.Create();

  LUsuario := nil;

  LQuery.First;
  //Mapear os dados carregados para o objeto
  while not LQUERY.Eof do
  begin
    LUsuario := TUsuario.Create();
    LUsuario.id := LQuery.FieldByName('id').AsInteger;
    LUsuario.login := LQuery.FieldByName('login').AsString;
    LUsuario.senha := LQuery.FieldByName('senha').AsString;
    LUsuario.pessoaId := LQuery.FieldByName('pessoaId').AsInteger;
    LUsuario.criadoEm := LQuery.FieldByName('criadoEm').asDateTime;
    LUsuario.criadoPor := LQuery.FieldbyName('criadoPor').AsString;
    LUsuario.alteradoEm := LQuery.Fieldbyname('alteradoEm').asDateTime;
    LUsuario.alteradoPor := LQuery.FieldByName('AlteradoPor').asString;

    Llista.add(LUsuario);
    LQuery.Next;
  end;


  FreeAndNil(LQuery);
  Result := LLista;
end;

function TUsuarioDAO.BuscarUsuarioPorLoginSenha(PLogin,
  PSenha: String): TUsuario;
var
  LQuery: TFDQuery;
  LUsuario: TUsuario;
begin
  LQuery := TFDQuery.Create(nil);
  LQuery.Connection := dmRavin.cnxBancoDeDados;
  LQuery.SQL.Text := 'SELECT * FROM usuario WHERE login = :login AND senha = :senha';
  LQuery.ParamByName('login').AsString := PLogin;
  LQuery.ParamByName('senha').AsString := PSenha;
  LQuery.open();

  LUsuario := nil;

  if not LQuery.IsEmpty then begin
    //achou algum registro
    LUsuario := TUsuario.Create();
    LUsuario.id := LQuery.FieldByName('id').AsInteger;
    LUsuario.login := LQuery.FieldByName('login').AsString;
    LUsuario.senha := LQuery.FieldByName('senha').AsString;
    LUsuario.pessoaId := LQuery.FieldByName('pessoaId').AsInteger;
    LUsuario.criadoEm := LQuery.FieldByName('criadoEm').asDateTime;
    LUsuario.criadoPor := LQuery.FieldbyName('criadoPor').AsString;
    LUsuario.alteradoEm := LQuery.Fieldbyname('alteradoEm').asDateTime;
    LUsuario.alteradoPor := LQuery.FieldByName('AlteradoPor').asString;
  end;

  LQuery.Close();
  FreeAndNil(LQuery);
  Result := LUsuario;
end;

procedure TUsuarioDAO.InserirUsuario(PUsuario: TUsuario);
var
  LQuery: TFDQuery;
begin
  LQuery := TFDQuery.Create(nil);
  LQuery.Connection := dmRavin.cnxBancoDeDados;
  LQuery.SQL.add('INSERT INTO usuario ');
  LQuery.SQL.Add('(login, senha, pessoaId, criadoEm, criadoPor, alteradoEm, alteradoPor)');
  LQuery.SQL.ADD('VALUES (:login, :senha, :pessoaId, :criadoEm, :criadoPor, :alteradoEm, :alteradoPor)');

  LQuery.ParamByName('login').AsString := PUsuario.Login;
  LQuery.ParamByName('senha').AsString := PUsuario.senha;
  LQuery.ParamByName('pessoaId').AsInteger := PUsuario.pessoaId;
  LQuery.ParamByName('criadoEm').AsDateTime := PUsuario.criadoEm;
  LQuery.ParamByName('criadoPor').AsString := PUsuario.criadoPor;
  LQuery.ParamByName('alteradoEm').AsDateTime := PUsuario.alteradoEm;
  LQuery.ParamByName('alteradoPor').AsString := PUsuario.alteradoPor;
  LQuery.ExecSQL();

  FreeAndNil(LQuery);
end;




end.
