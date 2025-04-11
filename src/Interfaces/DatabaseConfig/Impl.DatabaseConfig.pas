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
        FOSAuthMSSQL: Boolean;
        FUseConnectionString: Boolean;
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
        function OSAuthMSSQL: Boolean; overload;
        function UseConnectionString: Boolean; overload;
        {setters}
        function Server(Value: String): IDatabaseConfig; overload;
        function Database(Value: String): IDatabaseConfig; overload;
        function Port(Value: Integer): IDatabaseConfig; overload;
        function Username(Value: String): IDatabaseConfig; overload;
        function Password(Value: String): IDatabaseConfig; overload;
        function DriverId(Value: String): IDatabaseConfig; overload;
        function ConnectionString(Value: String): IDatabaseConfig; overload;
        function OSAuthMSSQL(Value: Boolean): IDatabaseConfig; overload;
        function UseConnectionString(Value: Boolean): IDatabaseConfig; overload;
        {methods}
        function ToJSON: String;
        function Default: IDatabaseConfig; virtual;
        function Clear: IDatabaseConfig;
        procedure CopyFrom(const Source: IDatabaseConfig);
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
    FOSAuthMSSQL := False;
end;

function TDatabaseConnectionConfig.ConnectionString(
  Value: String): IDatabaseConfig;
begin
    Result := Self;
    FConnectionString := Value.Trim;
end;

procedure TDatabaseConnectionConfig.CopyFrom(const Source: IDatabaseConfig);
begin
    if Assigned(Source) then
    begin
        Self.FServer := Source.Server;
        Self.FDatabase := Source.Database;
        Self.FPort := Source.Port;
        Self.FUsername := Source.Username;
        Self.FPassword := Source.Password;
        Self.FDriverID := Source.DriverId;
        Self.FOSAuthMSSQL := Source.OSAuthMSSQL;
        Self.FUseConnectionString := Source.UseConnectionString;
    end;
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

function TDatabaseConnectionConfig.OSAuthMSSQL(Value: Boolean): IDatabaseConfig;
begin
    Result := Self;
    FOSAuthMSSQL := Value;
end;

function TDatabaseConnectionConfig.OSAuthMSSQL: Boolean;
begin
    Result := FOSAuthMSSQL;
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

function TDatabaseConnectionConfig.UseConnectionString(
  Value: Boolean): IDatabaseConfig;
begin
    Result := Self;
    FUseConnectionString := Value;
end;

function TDatabaseConnectionConfig.UseConnectionString: Boolean;
begin
    Result := FUseConnectionString;
end;

function TDatabaseConnectionConfig.Username(
  Value: String): IDatabaseConfig;
begin
    Result := Self;
    FUsername := Value.Trim;
end;

end.
