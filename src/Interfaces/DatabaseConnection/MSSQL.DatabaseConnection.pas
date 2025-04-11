unit MSSQL.DatabaseConnection;

interface
uses
    System.SysUtils,
    Intf.DatabaseConnection, Impl.DatabaseConnection,
    Intf.DatabaseConfig, Impl.DatabaseConfig, FireDAC.Phys.MSSQL;
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
        Connection.DriverName := 'MSSQL';
        Connection.Params.DriverID := 'MSSQL';
        Connection.Params.Values['Server'] := Config.Server;
        Connection.Params.Values['Port'] := '';
        if Config.OSAuthMSSQL then
        begin
            Connection.Params.Values['OSAuthent'] := 'Yes';
            Connection.Params.Values['Mars'] := 'No';
            Connection.Params.Values['User_name'] := '';
            Connection.Params.Values['Password'] := '';
        end
        else
        begin
            Connection.Params.Values['User_name'] := Config.Username;
            Connection.Params.Values['Password'] := Config.Password;
            Connection.Params.Values['OSAuthent'] := 'No';
        end;
        Connection.Params.Values['Database'] := Config.Database;
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
