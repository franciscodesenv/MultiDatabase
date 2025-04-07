unit uMainForm;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Data.DB, uDatabaseManager,
  Vcl.ComCtrls, Vcl.ExtCtrls, Vcl.Grids, Vcl.DBGrids;

type
  TForm1 = class(TForm)
    cmb_sgdb: TComboBox;
    StatusBar1: TStatusBar;
    ed_port: TLabeledEdit;
    ed_server: TLabeledEdit;
    ed_username: TLabeledEdit;
    ed_password: TLabeledEdit;
    btn_connect: TButton;
    btn_open_dataset: TButton;
    memoSQL: TMemo;
    Memo1: TMemo;
    DBGrid1: TDBGrid;
    btn_run_command: TButton;
    Label1: TLabel;
    Button2: TButton;
    ed_database: TLabeledEdit;
    procedure FormCreate(Sender: TObject);
    procedure cmb_sgdbChange(Sender: TObject);
    procedure btn_connectClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btn_open_datasetClick(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure btn_run_commandClick(Sender: TObject);
  private
    { Private declarations }
    FDBManager: TDatabaseManager;
    FDataSet: TDataSet;
    ds: TDataSource;
    procedure FreeDataSet;
    procedure UpdateUIState;
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.btn_connectClick(Sender: TObject);
var
    port: Integer;
begin
    if TryStrToInt(ed_port.Text, Port) then
        FDBManager.SetConnectionParams(ed_server.Text, ed_database.Text, ed_username.Text, ed_password.Text, port)
    else
        FDBManager.SetConnectionParams(ed_server.Text, ed_database.Text, ed_username.Text, ed_password.Text);
    if FDBManager.Connect then
    begin
        ShowMessage('Conexão bem-sucedida!');
        UpdateUIState;
    end
    else
        ShowMessage('Falha ao conectar: ' + FDBManager.GetLastError);
end;

procedure TForm1.btn_open_datasetClick(Sender: TObject);
begin
    FreeDataSet;
    if Trim(memoSQL.Text) = '' then
    begin
        ShowMessage('Informe uma consulta SQL válida.');
        Exit;
    end;
    try
        Screen.Cursor := crHourGlass;
        FDataSet := FDBManager.ExecuteQuery(memoSQL.Text);
        if Assigned(FDataSet) then
        begin
            ds.DataSet := FDataSet;
            ShowMessage('Consulta executada com sucesso!');
        end
        else
            ShowMessage('A consulta não retornou dados ou ocorreu um erro: ' + FDBManager.GetLastError);
    finally
        Screen.Cursor := crDefault;
    end;
end;

procedure TForm1.btn_run_commandClick(Sender: TObject);
var
    rowsAffected: Integer;
begin
    if Trim(memoSQL.Text) = '' then
    begin
        ShowMessage('Informe um comando SQL válido.');
        Exit;
    end;
    try
        Screen.Cursor := crHourGlass;
        if FDBManager.StartTransaction then
        begin
            try
                RowsAffected := FDBManager.ExecuteCommand(memoSQL.Text);
                if RowsAffected >= 0 then
                begin
                    if FDBManager.CommitTransaction then
                        ShowMessage(Format('Comando executado com sucesso! Linhas afetadas: %d', [RowsAffected]))
                    else
                        ShowMessage('Erro ao confirmar a transação: ' + FDBManager.GetLastError);
                end
                else
                begin
                    FDBManager.RollbackTransaction;
                    ShowMessage('Erro ao executar o comando: ' + FDBManager.GetLastError);
                end;
            except on E: Exception do
                begin
                    FDBManager.RollbackTransaction;
                    ShowMessage('Erro ao executar o comando: ' + E.Message);
                end;
            end;
        end
        else
            ShowMessage('Erro ao iniciar a transação: ' + FDBManager.GetLastError);
    finally
        Screen.Cursor := crDefault;
    end;
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
    FDBManager.Disconnect;
    FreeDataSet;
    UpdateUIState;
    ShowMessage('Desconectado com sucesso!');
end;

procedure TForm1.cmb_sgdbChange(Sender: TObject);
var
    DBType: TDatabaseType;
begin
    case cmb_sgdb.ItemIndex of
        0: DBType := dbtMySQL;
        1: DBType := dbtSQLite;
        2: DBType := dbtMSSQL;
        3: DBType := dbtPostgreSQL;
        4: DBType := dbtOracle;
    else
        DBType := dbtMySQL;
    end;
  FDBManager.ChangeDatabase(DBType);

    // Ajusta a UI com valores padrão para cada tipo de banco
    case DBType of
        dbtMySQL:
            begin
                ed_port.Text := '3306';
            end;
        dbtSQLite:
            begin
                ed_server.Text := '';
                ed_port.Text := '';
                ed_username.Text := '';
                ed_password.Text := '';
            end;
        dbtMSSQL:
            begin
                ed_port.Text := '1433';
            end;
        dbtPostgreSQL:
            begin
                ed_port.Text := '5432';
            end;
        dbtOracle:
            begin
                ed_port.Text := '1521';
            end;
    end;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
    cmb_sgdb.Items.Clear;
    cmb_sgdb.Items.Add('MySQL');
    cmb_sgdb.Items.Add('SQLite');
    cmb_sgdb.Items.Add('SQL Server');
    cmb_sgdb.Items.Add('PostgreSQL');
    cmb_sgdb.Items.Add('Oracle');
    cmb_sgdb.ItemIndex := 0;
    ds := TDataSource.Create(Self);
    DBGrid1.DataSource := ds;
    FDBManager := TDatabaseManager.Create(dbtMySQL);
end;

procedure TForm1.FormDestroy(Sender: TObject);
begin
    if Assigned(FDBManager) then
        FDBManager.Free;
end;

procedure TForm1.FreeDataSet;
begin
    if Assigned(FDataSet) then
    begin
        ds.DataSet := nil;
        FDataSet.Free;
        FDataSet := nil;
    end;
end;

procedure TForm1.UpdateUIState;
begin

end;

end.
