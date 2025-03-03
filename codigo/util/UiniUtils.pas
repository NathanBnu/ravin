unit UiniUtils;

interface
uses
  System.IOUtils,
  Vcl.Forms,
  TypInfo,
  IniFiles;

type
  TSECAO = (CONFIGURACOES, INFORMACOES_GERAIS, BANCO);
type
  TPROPRIEDADE = (LOGADO, DATAHORA_ULTIMO_LOGIN, SERVIDOR, PORTA, USUARIO, SENHA, NOME_BASE, CAMINHO_BANCO, DRIVER_ID);

type
  TIniUtils = class
  private
  protected
  public
    constructor Create();
    destructor Destroy; override;
    class procedure gravarPropriedade(PSecao: TSECAO;
      PPropriedade: TPROPRIEDADE; PValor: String);
    class function lerPropriedade(PSecao: TSECAO;
      PPropriedade: TPROPRIEDADE): String;

    const VALOR_VERDADEIRO: String = 'true';
    const VALOR_FALSO: String = 'false';
  end;
implementation
{ TIniUltis }

constructor TIniUtils.Create;
begin
  inherited;
end;
destructor TIniUtils.Destroy;
begin
  inherited;
end;

class procedure TIniUtils.gravarPropriedade(PSecao: TSECAO;
  PPropriedade: TPROPRIEDADE; PValor: String);
var
  LcaminhoArquivoIni: String;
  LarquivoINI: TIniFile;
  LNomePropiedade: String;
  LNomeSecao: String;
begin
  LcaminhoArquivoIni := TPath.Combine(TPath.Combine(TPath.GetDocumentsPath,
    'ravin'), 'configuracoes.ini');

  LarquivoINI := TIniFile.Create(LcaminhoArquivoIni);

  LNomeSecao := GetEnumName(TypeInfo(TSecao), Integer(pSecao));
  LNomePropiedade := GetEnumName(TypeInfo(TPROPRIEDADE), Integer(PPropriedade));

  LarquivoINI.WriteString(LNomeSecao, LNomePropiedade, PValor);

  LarquivoINI.Free;
end;

class function TIniUtils.lerPropriedade(PSecao: TSECAO;
  PPropriedade: TPROPRIEDADE): String;
var
  LcaminhoArquivoIni: String;
  LarquivoINI: TIniFile;
  LNomePropriedade: string;
  LNomeSecao: string;
begin
  LcaminhoArquivoIni := TPath.Combine(TPath.Combine(TPath.GetDocumentsPath,
    'ravin'), 'configuracoes.ini');
  LarquivoINI := TIniFile.Create(LcaminhoArquivoIni);
  LNomeSecao := GetEnumName(TypeInfo(TSECAO), Integer(PSECAO));
  LNomePropriedade := GetEnumName(TypeInfo(TPROPRIEDADE), Integer(PPropriedade));
  Result := LarquivoINI.ReadString(LNomeSecao, LNomePropriedade, '');

  LarquivoINI.Free;
end;

end.

