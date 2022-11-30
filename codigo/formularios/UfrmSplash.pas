unit UfrmSplash;

interface

uses
  Winapi.Windows,
  Winapi.Messages,

  System.SysUtils,
  System.Variants,
  System.Classes,
  system.DateUtils,
  Vcl.Graphics,
  Vcl.Controls,
  Vcl.Forms,
  Vcl.Dialogs,
  Vcl.ExtCtrls,
  Vcl.Imaging.pngimage,
  Vcl.StdCtrls,

  UfrmLogomarca;

type
  TfrmSplash = class(TForm)
    pnlFundo: TPanel;
    tmrSplash: TTimer;
    frmLogo: TfrmLogo;
    procedure tmrSplashTimer(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormPaint(Sender: TObject);
  private
    { Private declarations }
    Inicialized: Boolean;
    procedure InicializarAplicacao();
    procedure ShowPainelGestao();
    procedure ShowLogin();

  public
    function verificarDeveLogar(): Boolean;
    const MAX_DIAS_LOGIN: Integer = 5; //numero maximo de dias sem logar
  end;

var
  frmSplash: TfrmSplash;

implementation

{$R *.dfm}

uses UfrmPainelGestao, UfrmLogin, UiniUtils, USetarFormularioPrincipal;

procedure TfrmSplash.FormCreate(Sender: TObject);
begin
  Inicialized := false;
  tmrSplash.Enabled := false;
  tmrSplash.Interval := 1000;
end;

procedure TfrmSplash.FormPaint(Sender: TObject);
begin
  tmrSplash.Enabled := not Inicialized;
end;

procedure TfrmSplash.InicializarAplicacao;
var
  LLogado: string;
  LDeveLogar: boolean;
begin
  //carregando se o usuario esta logado
  LLogado := TIniUtils.lerPropriedade(TSECAO.INFORMACOES_GERAIS, TPROPRIEDADE.LOGADO);

  LDeveLogar := verificarDeveLogar();

  if (LLogado = TiniUTILS.VALOR_VERDADEIRO) and (not LDeveLogar)then
  begin
    ShowPainelgestao();
  end
  else
  begin
    ShowLogin();
  end;
end;

procedure TfrmSplash.tmrSplashTimer(Sender: TObject);
begin
  tmrSplash.Enabled := false;
  if not Inicialized then
  begin
    Inicialized := true;
    InicializarAplicacao();
  end;
end;

function TfrmSplash.verificarDeveLogar: Boolean;
var
  LDataString: String;
  LDataTimeUltimoLogin: TDateTime;
  LDataExpiracaoLogin: TDateTime;
  LExisteDataUltimoLogin: boolean;
begin
  //carregando a data e hora do ultimo login do usuario
  LDataString := TIniUtils.lerPropriedade(TSECAO.INFORMACOES_GERAIS, TPROPRIEDADE.DATAHORA_ULTIMO_LOGIN);

  try
    LDataTimeUltimoLogin := StrToDateTime(LDataString);

    LDataExpiracaoLogin := IncDay(LDataTimeUltimoLogin, MAX_DIAS_LOGIN);

    Result := LDataExpiracaoLogin < now();
  except
    on E: Exception do
      Result := true;
  end;

end;

procedure TfrmSplash.ShowLogin;
begin
  if not Assigned(frmLogin) then
  begin
    Application.CreateForm(TfrmLogin, frmLogin);
  end;

  TSetarFormularioPrincipal.SetarFormularioPrincipal(frmLogin);
  frmLogin.Show();

  Close;
end;

procedure TfrmSplash.ShowPainelGestao;
begin
  if not Assigned(frmPainelGestao) then
  begin
    Application.CreateForm(TfrmPainelGestao, frmPainelGestao);
  end;

  TSetarFormularioPrincipal.SetarFormularioPrincipal(frmPainelGestao);
  frmPainelGestao.Show();

  Close;
end;

end.


