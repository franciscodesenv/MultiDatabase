unit MSSQL.DatabaseConnection;

interface
uses
    System.SysUtils,
    Intf.DatabaseConnection, Impl.DatabaseConnection,
    Intf.DatabaseConfig, Impl.DatabaseConfig;
type
    TMSSQLConnection = class(TDatabaseConnection)
    public
        constructor Create(Config: IDatabaseConfig); override;
        function Connect: Boolean; override;
    end;

implementation

{ TMSSQLConnection }

function TMSSQLConnection.Connect: Boolean;
begin
    try
        Connection.Params.Clear;
        Connection.ConnectionString := Config.ConnectionString;
        Connection.DriverName := 'MSSQL';
        Connection.LoginPrompt := False;
        Connection.Connected := True;
        Result := Connection.Connected;
    except on E: Exception do
        begin
            HandleException(E);
            Result := False;
        end;
    end;
end;

constructor TMSSQLConnection.Create(Config: IDatabaseConfig);
begin
    inherited Create(Config);
end;

end.
