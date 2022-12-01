unit UfrmCadastroCliente;

interface

uses
  Winapi.Windows,
  Winapi.Messages,
  System.SysUtils,
  System.Variants,
  System.Classes,
  Vcl.Graphics,
  Vcl.Controls,
  Vcl.Forms,
  Vcl.Dialogs,
  Vcl.ComCtrls,
  Vcl.ExtCtrls,
  Vcl.StdCtrls,
  Vcl.Mask,
  Vcl.WinXCtrls,
  UfrmBotaoPrimario,

  UfrmBotaoExcluir,
  UfrmBotaoCancelar;

type
  TfrmCadastroCliente = class(TForm)
    pnlCadastroCliente: TPanel;
    lblCadastroCliente: TLabel;
    edtNome: TEdit;
    edtTelefone: TEdit;
    mskCpf: TMaskEdit;
    dtpDataNascimento: TDateTimePicker;
    lblInformacoesGerenciais: TfrmBotaoPrimario;
    frmBotaoCancelar: TfrmBotaoCancelar;
    frmBotaoExcluir: TfrmBotaoExcluir;
    procedure frmBotaoCancelarspbBotaoCancelarClick(Sender: TObject);
    procedure lblInformacoesGerenciaisspbBotaoPrimarioClick(Sender: TObject);
    procedure frmBotaoExcluirspbBotaoExcluirClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmCadastroCliente: TfrmCadastroCliente;

implementation

{$R *.dfm}

procedure TfrmCadastroCliente.frmBotaoCancelarspbBotaoCancelarClick(
  Sender: TObject);
begin
  close();
end;

procedure TfrmCadastroCliente.frmBotaoExcluirspbBotaoExcluirClick(
  Sender: TObject);
var
  LConfirmacaoExclusao: Integer;
begin
  LConfirmacaoExclusao := MessageDlg('Deseja realmente exlcuir o registro', TMsgDlgType.mtWarning, [TMsgDlgBtn.mbYes, TMsgdlgbtn.mbNo], 0);

  if LConfirmacaoExclusao = mrYes then
  begin
    ShowMessage('Registro Excluído com sucesso!');
    close();
  end;

  if LConfirmacaoExclusao = mrNo then
  begin
    //Tratativas
  end;
end;

procedure TfrmCadastroCliente.lblInformacoesGerenciaisspbBotaoPrimarioClick(
  Sender: TObject);
begin
  ShowMessage('Cliente cadastrado com sucesso!');
  close();
end;

end.
