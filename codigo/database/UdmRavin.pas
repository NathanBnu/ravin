unit UdmRavin;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.MySQL,
  FireDAC.Phys.MySQLDef, FireDAC.VCLUI.Wait, Data.DB, FireDAC.Comp.Client,
  FireDAC.Comp.UI, FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf,
  FireDAC.DApt, FireDAC.Comp.DataSet, vcl.Dialogs;

type
  TdmRavin = class(TDataModule)
    cnxBancoDeDados: TFDConnection;
    drvBancoDeDados: TFDPhysMySQLDriverLink;
    wtcBancoDeDados: TFDGUIxWaitCursor;
    procedure DataModuleCreate(Sender: TObject);
    procedure cnxBancoDeDadosBeforeConnect(Sender: TObject);
    procedure cnxBancoDeDadosAfterConnect(Sender: TObject);
  private
    procedure CriarTabelas();
    procedure InserirDados();
  public
    { Public declarations }
  end;

var
  dmRavin: TdmRavin;

implementation

uses UresourceUtils, UiniUtils;

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

procedure TdmRavin.cnxBancoDeDadosAfterConnect(Sender: TObject); //3-Depois de Conectar, vamos chamar as procedures.
var
  LCriarBaseDados: Boolean;
  lcaminhoBaseDados: string;
begin
  lcaminhoBaseDados := TiniUtils.lerpropriedade(TSECAO.BANCO, TPROPRIEDADE.CAMINHO_BANCO);

  if LCriarBaseDados then
  begin
    CriarTabelas();
    InserirDados();
  end;
end;

procedure TdmRavin.cnxBancoDeDadosBeforeConnect(Sender: TObject);  //1-CONFIGURANDO BANCO VIA CODIGO
var
  lcaminhoBaseDados: string;
  LCriarBaseDados: Boolean;
begin
  lcaminhoBaseDados := TiniUtils.lerpropriedade(TSECAO.BANCO, TPROPRIEDADE.CAMINHO_BANCO);

  with cnxBancoDeDados do
  begin
    Params.Values['Server'] := TiniUtils.lerpropriedade(TSECAO.BANCO, TPROPRIEDADE.SERVIDOR);
    Params.Values['User_Name'] := TiniUtils.lerpropriedade(TSECAO.BANCO, TPROPRIEDADE.USUARIO);
    Params.Values['Password'] := TiniUtils.lerpropriedade(TSECAO.BANCO, TPROPRIEDADE.SENHA);
    Params.Values['DriverId'] := TiniUtils.lerpropriedade(TSECAO.BANCO, TPROPRIEDADE.DRIVER_ID);
    Params.Values['Port'] := TiniUtils.lerpropriedade(TSECAO.BANCO, TPROPRIEDADE.PORTA);

    if not LCriarBaseDados then
    begin
        Params.Values['Database'] := TiniUtils.lerpropriedade(TSECAO.BANCO, TPROPRIEDADE.NOME_BASE);
    end;
  end;
end;

procedure TdmRavin.CriarTabelas; //2.1-procedure para puxar o SCRIPT de CREAT
begin
  try
    cnxBancoDeDados.ExecSQL(TResourceUtils.carregarArquivoResource('createTable.sql', 'ravin'));
  Except
    on E: Exception do
      ShowMessage(E.message);
  end;
end;

procedure TdmRavin.DataModuleCreate(Sender: TObject);
begin
  if not cnxBancoDeDados.Connected then
    cnxBancoDeDados.Connected := true;
end;

procedure TdmRavin.InserirDados; //2.2-procedure para puxar os inserts
begin
  try
    cnxBancoDeDados.StartTransaction();
    cnxBancoDeDados.ExecSQL(TResourceUtils.carregarArquivoResource('inserts.sql','ravin'));
  except 
    on E: Exception do
    begin
      cnxBancoDeDados.Rollback();
      ShowMessage(E.Message);
    end;          
  end;
end;

end.
