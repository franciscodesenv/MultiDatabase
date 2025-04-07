unit Impl.DatabaseConfig;

interface
uses
    Intf.DatabaseConfig, System.SysUtils, System.JSON;
type
    TDatabaseConnectionConfig = class(TInterfacedObject, IDatabaseConfig)
    private
        FServer: String;
        FDatabase: String;
        FPort: Integer;
        FUsername: String;
        FPassword: String;
        FDriverID: String;
        FConnectionString: String;
    public
        constructor Create; virtual;
        destructor Destroy; override;
        {getters}
        function Server: String; overload; virtual;
        function Database: String; overload; virtual;
        function Port: Integer; overload; virtual;
        function Username: String; overload; virtual;
        function Password: String; overload; virtual;
        function DriverId: String; overload; virtual;
        function ConnectionString: String; overload; virtual;
        {setters}
        function Server(Value: String): IDatabaseConfig; overload;
        function Database(Value: String): IDatabaseConfig; overload;
        function Port(Value: Integer): IDatabaseConfig; overload;
        function Username(Value: String): IDatabaseConfig; overload;
        function Password(Value: String): IDatabaseConfig; overload;
        function DriverId(Value: String): IDatabaseConfig; overload;
        function ConnectionString(Value: String): IDatabaseConfig; overload;
        {methods}
        function ToJSON: String;
        function Default: IDatabaseConfig; virtual;
        function Clear: IDatabaseConfig;
    end;

implementation

{ TDatabaseConnectionParams }

function TDatabaseConnectionConfig.Clear: IDatabaseConfig;
begin
    Result := Self;
    FConnectionString := '';
    FServer := '';
    FDatabase := '';
    FPort := 0;
    FUsername := '';
    FPassword := '';
    FDriverID := '';
end;

function TDatabaseConnectionConfig.ConnectionString(
  Value: String): IDatabaseConfig;
begin
    Result := Self;
    FConnectionString := Value.Trim;
end;

constructor TDatabaseConnectionConfig.Create;
begin
    Self.Clear;
end;

function TDatabaseConnectionConfig.ConnectionString: String;
begin
    if FConnectionString <> '' then
        Result := FConnectionString
    else
        Result := Format('DriverID=MySQL;Server=%s;Port=%d;Database=%s;User_Name=%s;Password=%s', [Server, Port, Database, Username, Password]);
end;

function TDatabaseConnectionConfig.Database(
  Value: String): IDatabaseConfig;
begin
    Result := Self;
    FDatabase := Value.Trim;
end;

function TDatabaseConnectionConfig.Database: String;
begin
    Result := FDatabase.Trim;
end;

function TDatabaseConnectionConfig.Default: IDatabaseConfig;
begin
    Result := Self;
    FServer := '127.0.0.1';
    FDatabase := '';
    FPort := 3306;
    FUsername := 'root';
    FPassword := '123456';
    FDriverID := 'MySQL';
end;

destructor TDatabaseConnectionConfig.Destroy;
begin

  inherited;
end;

function TDatabaseConnectionConfig.DriverId: String;
begin
    Result := FDriverID.Trim;
end;

function TDatabaseConnectionConfig.DriverId(
  Value: String): IDatabaseConfig;
begin
    Result := Self;
    FDriverID := Value.Trim;
end;

function TDatabaseConnectionConfig.Password: String;
begin
    Result := FPassword.Trim;
end;

function TDatabaseConnectionConfig.Password(
  Value: String): IDatabaseConfig;
begin
    Result := Self;
    FPassword := Value.Trim;
end;

function TDatabaseConnectionConfig.Port(
  Value: Integer): IDatabaseConfig;
begin
    Result := Self;
    FPort := Value;
end;

function TDatabaseConnectionConfig.Port: Integer;
begin
    Result := FPort;
end;

function TDatabaseConnectionConfig.Server: String;
begin
    Result := FServer.Trim;
end;

function TDatabaseConnectionConfig.Server(
  Value: String): IDatabaseConfig;
begin
    Result := Self;
    FServer := Value.Trim;
end;

function TDatabaseConnectionConfig.ToJSON: String;
var
    json: TJSONObject;
begin
    try
        json := TJSONObject.Create;
        json.AddPair('server', FServer);
        json.AddPair('database', FDatabase);
        json.AddPair('port', FPort.ToString);
        json.AddPair('username', FUsername);
        json.AddPair('password', FPassword);
        json.AddPair('driverId', FDriverID);
        Result := json.ToString;
    finally
        FreeAndNil(json);
    end;
end;

function TDatabaseConnectionConfig.Username: String;
begin
    Result := FUsername.Trim
end;

function TDatabaseConnectionConfig.Username(
  Value: String): IDatabaseConfig;
begin
    Result := Self;
    FUsername := Value.Trim;
end;

end.
