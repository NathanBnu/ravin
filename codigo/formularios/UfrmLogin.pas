unit UfrmLogin;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.Imaging.pngimage,
  Vcl.StdCtrls, UfrmBotaoPrimarioAutenticar, USetarFormularioPrincipal;

type
  TfrmLogin = class(TForm)
    pnlAutenticacao: TPanel;
    imgFundo: TImage;
    lblTitulo: TLabel;
    lblSubTitulo: TLabel;
    edtLogin: TEdit;
    edtSenha: TEdit;
    lblSubTituloRegistrar: TLabel;
    lblRegistrar: TLabel;
    frmBotaoPrimarioAutenticar1: TfrmBotaoPrimarioAutenticar;
    procedure frmBotaoPrimarioAutenticar1spdBotaoPrimarioClick(Sender: TObject);
    procedure lblRegistrarClick(Sender: TObject);

  private
    { Private declarations }
  public
  end;

var
  frmLogin: TfrmLogin;

implementation

{$R *.dfm}

uses UfrmPainelGestao, UusuarioDao, Uusuario, UfrmRegistrar, UiniUtils,
  UfrmListarUsuarios;

procedure TfrmLogin.frmBotaoPrimarioAutenticar1spdBotaoPrimarioClick(
  Sender: TObject);
var
  LDao: TUsuarioDao;
  LUsuario: TUsuario;

  LLogin: String;
  LSenha: String;
begin
  LUsuario := nil;
  LDao := nil;

  Ldao := TUsuarioDao.Create;

  LLogin := edtLogin.Text;
  LSenha := edtSenha.Text;

  LUsuario := LDao.BuscarUsuarioPorLoginSenha(LLogin, LSenha);

  if Assigned(LUsuario) then
  begin
    //REGISTRANDO HORARIO DO LOGIN!
    TIniutils.gravarPropriedade(TSECAO.INFORMACOES_GERAIS, TPROPRIEDADE.DATAHORA_ULTIMO_LOGIN, DateTimeToStr(Now()));

    //REGISTRANDO QUE O USUARIO LOGOU COM SUCESSO!
    TIniUtils.gravarPropriedade(TSECAO.INFORMACOES_GERAIS, TPROPRIEDADE.LOGADO, TIniUtils.VALOR_VERDADEIRO);

    if not Assigned(frmPainelGestao) then
      begin
        Application.CreateForm(TfrmPainelGestao, frmPainelGestao)
    end;

    TSetarFormularioPrincipal.SetarFormularioPrincipal(frmPainelGestao);
    frmPainelGestao.Show();

    Close();

  end else
    showmessage('Login e/ou senha inválidos');

    FreeAndNil(LDao);
    FreeAndNil(LUsuario);

end;

procedure TfrmLogin.lblRegistrarClick(Sender: TObject);
begin
  if not Assigned(frmRegistrar) then
  begin
    Application.CreateForm(TfrmRegistrar, frmRegistrar);
  end;

  TSetarFormularioPrincipal.SetarFormularioPrincipal(frmRegistrar);
  frmRegistrar.Show();
  Close();
end;

end.
