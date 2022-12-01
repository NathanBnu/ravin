unit UfrmListaClientes;

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
  Vcl.StdCtrls,

  UfrmBotaoPrimario,
  UfrmBotaoCancelar, Vcl.ExtCtrls;

type
  TfrmListaClientes = class(TForm)
    frmBotaoPrimario: TfrmBotaoPrimario;
    frmBotaoCancelar: TfrmBotaoCancelar;
    lvwClientes: TListView;
    Shape1: TShape;
    Shape2: TShape;
    Shape5: TShape;
    lblInformacoesGerenciais: TLabel;
    pnlListaClientes: TPanel;
    lblListaClientesTitulo: TLabel;
    Timer1: TTimer;
    procedure frmBotaoPrimariospbBotaoPrimarioClick(Sender: TObject);
    procedure frmBotaoCancelarspbBotaoCancelarClick(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmListaClientes: TfrmListaClientes;

implementation

uses
  UfrmCadastroCliente;

{$R *.dfm}

procedure TfrmListaClientes.frmBotaoCancelarspbBotaoCancelarClick(
  Sender: TObject);
begin
  close();
end;

procedure TfrmListaClientes.frmBotaoPrimariospbBotaoPrimarioClick
  (Sender: TObject);
var
  LItem: TListItem;
begin
  {LItem := lvwClientes.Items.Add();
  LItem.Caption := 'Marcio';
  LItem.SubItems.Add('2134234324');
  LItem.SubItems.Add('(47)9925645663');
  LItem.SubItems.Add('Ativo'); }

  if (not Assigned(frmCadastroCliente)) then
  begin
    Application.CreateForm(TfrmCadastroCliente, frmCadastroCliente);
  end;
  frmCadastroCliente.show();
end;

procedure TfrmListaClientes.Timer1Timer(Sender: TObject);
begin
  Showmessage('Cento de salgado');
end;

end.
