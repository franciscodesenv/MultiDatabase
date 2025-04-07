unit uDatabaseManager;

interface
uses
    System.SysUtils, System.Classes, Data.DB, Intf.DatabaseConnection,
    Intf.DatabaseConfig, Intf.Connection.Factory,
    MySQL.Connection.Factory, MySQL.DatabaseConfig;
type
    TDatabaseType = (dbtMySQL, dbtSQLite, dbtMSSQL, dbtPostgreSQL, dbtOracle);
    TDatabaseManager = class
    private
        FConnection: IDatabaseConnection;
        FConfig: IDatabaseConfig;
        FFactory: IDatabaseConnectionFactory;
        FDatabaseType: TDatabaseType;
        function CreateFactory(DatabaseType: TDatabaseType): IDatabaseConnectionFactory;
        function CreateConfig(DatabaseType: TDatabaseType): IDatabaseConfig;
    public
        constructor Create(DatabaseType: TDatabaseType);
        destructor Destroy; override;

        procedure SetConnectionParams(const Server, Database, Username, Password: string; Port: Integer = 0);
        procedure SetConnectionString(const ConnectionString: string);
        procedure ChangeDatabase(DatabaseType: TDatabaseType);

        function Connect: Boolean;
        procedure Disconnect;
        function IsConnected: Boolean;
        function ExecuteQuery(const SQL: string): TDataSet;
        function ExecuteCommand(const SQL: string): Integer;
        function StartTransaction: Boolean;
        function CommitTransaction: Boolean;
        function RollbackTransaction: Boolean;
        function GetLastError: string;

        property DatabaseType: TDatabaseType read FDatabaseType;
        property Config: IDatabaseConfig read FConfig;
        property Connection: IDatabaseConnection read FConnection;
    end;

implementation

{ TDatabaseManager }

constructor TDatabaseManager.Create(DatabaseType: TDatabaseType);
begin
    inherited Create;
    FDatabaseType := DatabaseType;
    FFactory := CreateFactory(DatabaseType);
    FConfig := CreateConfig(DatabaseType);
    FConnection := FFactory.CreateConnection(FConfig);
end;

destructor TDatabaseManager.Destroy;
begin
  if Assigned(FConnection) then
    FConnection.Disconnect;
  inherited;
end;

function TDatabaseManager.CreateFactory(DatabaseType: TDatabaseType): IDatabaseConnectionFactory;
begin
  case DatabaseType of
    dbtMySQL: Result := TMySQLConnectionFactory.Create;
//    dbtSQLite: Result := TSQLiteConnectionFactory.Create;
//    dbtMSSQL: Result := TMSSQLConnectionFactory.Create;
//    dbtPostgreSQL: Result := TPostgreSQLConnectionFactory.Create;
//    dbtOracle: Result := TOracleConnectionFactory.Create;
  else
    raise Exception.Create('Tipo de banco de dados não suportado');
  end;
end;

function TDatabaseManager.CreateConfig(DatabaseType: TDatabaseType): IDatabaseConfig;
begin
    case DatabaseType of
        dbtMySQL: Result := TMySQLConnectionConfig.Create;
    //    dbtSQLite: Result := TSQLiteConnectionConfig.Create;
    //    dbtMSSQL: Result := TMSSQLConnectionConfig.Create;
    //    dbtPostgreSQL: Result := TPostgreSQLConnectionConfig.Create;
    //    dbtOracle: Result := TOracleConnectionConfig.Create;
    else
        raise Exception.Create('Tipo de banco de dados não suportado');
    end;
end;

procedure TDatabaseManager.SetConnectionParams(const Server, Database, Username, Password: string; Port: Integer);
begin
    FConfig.Server(Server);
    FConfig.Database(Database);
    FConfig.Username(Username);
    FConfig.Password(Password);
    if Port > 0 then
        FConfig.Port(Port);
end;

procedure TDatabaseManager.SetConnectionString(const ConnectionString: string);
begin
    FConfig.ConnectionString(ConnectionString);
end;

procedure TDatabaseManager.ChangeDatabase(DatabaseType: TDatabaseType);
var
    server, database, username, password: string;
    port: Integer;
    connectionString: string;
begin
    // Salva as configurações atuais
    server := FConfig.Server;
    database := FConfig.Database;
    username := FConfig.Username;
    password := FConfig.Password;
    port := FConfig.Port;
    connectionString := FConfig.ConnectionString;

    // Desconecta
    if Assigned(FConnection) then
        FConnection.Disconnect;

    // Cria novas instâncias para o novo tipo de banco
    FDatabaseType := DatabaseType;
    FFactory := CreateFactory(DatabaseType);
    FConfig := CreateConfig(DatabaseType);

    // Restaura as configurações
    FConfig.Server(server);
    FConfig.Database(database);
    FConfig.Username(username);
    FConfig.Password(password);
    FConfig.Port(port);
    FConfig.ConnectionString(connectionString);

    // Cria nova conexão
    FConnection := FFactory.CreateConnection(FConfig);
end;

function TDatabaseManager.Connect: Boolean;
begin
    Result := FConnection.Connect;
end;

procedure TDatabaseManager.Disconnect;
begin
    FConnection.Disconnect;
end;

function TDatabaseManager.IsConnected: Boolean;
begin
    Result := FConnection.IsConnected;
end;

function TDatabaseManager.ExecuteQuery(const SQL: string): TDataSet;
begin
    Result := FConnection.ExecuteQuery(SQL);
end;

function TDatabaseManager.ExecuteCommand(const SQL: string): Integer;
begin
    Result := FConnection.ExecuteCommand(SQL);
end;

function TDatabaseManager.StartTransaction: Boolean;
begin
    Result := FConnection.StartTransaction;
end;

function TDatabaseManager.CommitTransaction: Boolean;
begin
    Result := FConnection.CommitTransaction;
end;

function TDatabaseManager.RollbackTransaction: Boolean;
begin
    Result := FConnection.RollbackTransaction;
end;

function TDatabaseManager.GetLastError: string;
begin
    Result := FConnection.GetLastError;
end;

end.
