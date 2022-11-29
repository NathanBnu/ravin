unit UfrmRegistrar;

interface

uses
  Winapi.Windows,
  Winapi.Messages,
  System.SysUtils,
  System.Variants,
  FireDac.Phys.MySQLWrapper,
  System.Classes,
  Vcl.Graphics,
  Vcl.Controls,
  Vcl.Forms,
  Vcl.Dialogs,
  UfrmBotaoPrimario,
  Vcl.StdCtrls,
  Vcl.ExtCtrls,
  Vcl.Imaging.pngimage,
  System.Actions, Vcl.ActnList, Vcl.ExtActns;

type
  TfrmRegistrar = class(TForm)
    imgFundo: TImage;
    pnlRegistrar: TPanel;
    lblTituloRegistrar: TLabel;
    lblSubTituloRegistrar: TLabel;
    lblTituloAutenticar: TLabel;
    lblSubTituloAutenticar: TLabel;
    edtNome: TEdit;
    edtCpf: TEdit;
    frmBotaoPrimarioRegistrar: TfrmBotaoPrimario;
    edtLogin: TEdit;
    edtSenha: TEdit;
    edtConfirmarSenha: TEdit;
    procedure lblSubTituloAutenticarClick(Sender: TObject);
    procedure frmBotaoPrimarioRegistrarspbBotaoPrimarioClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmRegistrar: TfrmRegistrar;

implementation

uses
  UusuarioDao, UfrmLogin, Uusuario, UvalidadorUsuario,
  USetarFormularioPrincipal;

{$R *.dfm}

procedure TfrmRegistrar.frmBotaoPrimarioRegistrarspbBotaoPrimarioClick
  (Sender: TObject);
var
  LUsuario: TUsuario;
  LDao: TUsuarioDao;
begin // registrar, ler os valores dos campos, criar o objeto de usuario, setar os valores, criar um DAO, chamar o metodo para salvar o usuario
  try
    try
      LUsuario := TUsuario.create();
      LUsuario.Login := edtLogin.Text;
      LUsuario.senha := edtSenha.Text;
      LUsuario.PessoaId := 1;
      LUsuario.CriadoEm := now();
      LUsuario.criadopor := 'admin';
      LUsuario.alteradoEm := now();
      LUsuario.alteradoPor := 'admin';

      TValidadorUsuario.Validar(LUsuario, edtConfirmarSenha.Text);
      TValidadorUsuario.isCPF(edtCpf.text); //VALIDAR CPF

      LDao := TUsuarioDao.create();
      LDao.InserirUsuario(LUsuario);

    except
      on E: EMySQLNativeException do
      begin
        ShowMessage('Erro ao insesrir o usuário no banco');
      end;
      on E: Exception do
        ShowMessage(E.Message);
    end;

  finally
    if assigned(LDao) then
      BEGIN
        FreeAndnil(LDao);
      END;
    FreeAndnil(LUsuario);
  end;

end;

procedure TfrmRegistrar.lblSubTituloAutenticarClick(Sender: TObject);
begin
  if not assigned(frmLogin) then
  begin
    Application.CreateForm(TfrmLogin, frmLogin);
  end;

  TSetarFormularioPrincipal.SetarFormularioPrincipal(frmLogin);
  frmLogin.Show();

  Close();
end;

end.
