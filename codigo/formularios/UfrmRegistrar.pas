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
    procedure SetMainForm(NovoMainForm: TForm);
  public
    { Public declarations }
  end;

var
  frmRegistrar: TfrmRegistrar;

implementation

uses
  UusuarioDao, UfrmLogin, Uusuario, UvalidadorUsuario;

{$R *.dfm}

procedure TfrmRegistrar.frmBotaoPrimarioRegistrarspbBotaoPrimarioClick(
  Sender: TObject);
var
LUsuario: TUsuario;
LDao: TUsuarioDao;
begin //registrar, ler os valores dos campos, criar o objeto de usuario, setar os valores, criar um DAO, chamar o metodo para salvar o usuario
  try
    LUsuario := TUsuario.create();
    LUsuario.Login := edtLogin.Text;
    LUsuario.senha := edtSenha.text;
    LUsuario.PessoaId := 1;
    LUsuario.CriadoEm := now();
    LUsuario.criadopor := 'admin';
    LUsuario.alteradoEm := now();
    LUsuario.alteradoPor := 'admin';

    TValidadorUsuario.Validar(LUsuario, edtConfirmarSenha.Text);

    LDao := TUsuarioDAO.Create();
    LDao.InserirUsuario(LUsuario);

    FreeAndnil(LDAO);
  except
    on E: EMySQLNativeException do begin
      ShowMessage('Erro ao insesrir o usu�rio no banco');
    end;
    on E: Exception do
      showmessage(E.Message);
  end;
  
  FreeAndNil(LUsuario);

end;

procedure TfrmRegistrar.lblSubTituloAutenticarClick(Sender: TObject);
begin
  if not Assigned(frmLogin) then
  begin
    Application.CreateForm(TfrmLogin, frmLogin);
  end;

  SetMainForm(frmLogin);
  frmLogin.Show();

  Close();
end;

procedure TfrmRegistrar.SetMainForm(NovoMainForm: TForm);
var
  tmpMain: ^TCustomForm;
begin
  tmpMain := @Application.Mainform;
  tmpMain^ := NovoMainForm;
end;

end.
