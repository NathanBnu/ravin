unit Uusuario;

interface

type
  TUsuario = class

  private
    Fid: Integer;
    Flogin: String;
    Fsenha: String;
    FpessoaId: Integer;
    FCPF: String;
    FcriadoEm: TDateTime;
    FCriadoPor: string;
    FalteradoEm: TDateTime;
    FalteradoPor: String;

  protected

  public
    property id: Integer read Fid write Fid;
    property login: String read Flogin write Flogin;
    property senha: String read Fsenha write Fsenha;
    property pessoaId: Integer read FpessoaId write FpessoaId;
    property CPF: String read FCPF write FCPF;
    property criadoEm: TDateTime read FcriadoEm write FcriadoEm;
    property criadoPor: String read FCriadoPor write FCriadoPor;
    property alteradoEm: TDateTime read FalteradoEm write FalteradoEm;
    property alteradoPor: String read FalteradoPor write FalteradoPor;
end;

implementation

end.
