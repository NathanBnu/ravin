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

uses UresourceUtils;

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

procedure TdmRavin.cnxBancoDeDadosAfterConnect(Sender: TObject); //3-Depois de Conectar, vamos chamar as procedures.
var
  LCriarBaseDados: Boolean;
begin
  LCriarBaseDados := not FileExists('C:\ProgramData\MySQL\MySQL Server 8.0\Data\ravin\statusmesa.ibd');

  if LCriarBaseDados then
  begin
    CriarTabelas();
    InserirDados();
  end;
end;

procedure TdmRavin.cnxBancoDeDadosBeforeConnect(Sender: TObject);  //1-CONFIGURANDO BANCO VIA CODIGO
var
  LCriarBaseDados: Boolean;
begin
  LCriarBaseDados := not FileExists('C:\ProgramData\MySQL\MySQL Server 8.0\Data\ravin\statusmesa.ibd');
  with cnxBancoDeDados do
  begin
    Params.Values['Server'] := 'localhost';
    Params.Values['User_Name'] := 'root';
    Params.Values['Password'] := 'root';
    Params.Values['DriverId'] := 'MySQL';
    Params.Values['Port'] := '3306';

    if not LCriarBaseDados then
    begin
        Params.Values['Database'] := 'ravin';
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
