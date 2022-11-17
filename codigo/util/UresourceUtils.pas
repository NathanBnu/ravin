unit UresourceUtils;

interface

uses system.classes, System.IOUTils, System.Sysutils, Vcl.Dialogs;

type
  TResourceUtils = class

  public
  class function carregarArquivoResource(PNomeArquivo: String; PNomeAplicacao: String): String;
end;

implementation

{ TResourceUtils }

class function TResourceUtils.carregarArquivoResource(PNomeArquivo: String; PNomeAplicacao: String): String;
var
  LConteudoArquivo: TStringList;
  LCaminhoArquivo: String;
  LCaminhoPastaAplicacao: String;
  LConteudoTexto: String;
begin
  LConteudoArquivo := TStringList.Create();
  LConteudoTexto := '';

  Try
    try
      LCaminhoPastaAplicacao := TPath.Combine(TPath.GetDocumentsPath,PNomeAplicacao);
      LCaminhoArquivo := TPath.Combine(LCaminhoPastaAplicacao, PNomeArquivo);
      LConteudoArquivo.LoadFromFile(LCaminhoArquivo);
      LConteudoTexto := LConteudoArquivo.Text;
    except
      on E: Exception do
        raise Exception.Create('Erro ao carregar os arquivos de resource. Arquivo ' + PNomeArquivo);
    end;
  Finally
    LConteudoArquivo.Free;
  End;

  Result := LConteudoTexto;
end;
end.
