unit Postgre.DatabaseConnection;

interface
uses
    System.SysUtils, FireDAC.Phys.PG,
    Intf.DatabaseConnection, Impl.DatabaseConnection,
    Intf.DatabaseConfig, Impl.DatabaseConfig;
type
    TPGConnection = class(TDatabaseConnection)
    public
        constructor Create(Config: IDatabaseConfig); override;
        function Connect: Boolean; override;
    end;

implementation

{ TPGConnection }

function TPGConnection.Connect: Boolean;
begin
    try
        Connection.Params.Clear;
        if Config.UseConnectionString then
            Connection.ConnectionString := Config.ConnectionString
        else
        begin
            Connection.Params.Clear;
            Connection.Params.DriverID := 'PG';
            Connection.Params.Values['Server'] := Config.Server;
            Connection.Params.Values['Port'] := Config.Port.ToString;
            Connection.Params.Values['User_name'] := Config.Username;
            Connection.Params.Values['Password'] := Config.Password;
            Connection.Params.Values['Database'] := Config.Database;
        end;
        Connection.DriverName := 'PG';
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

constructor TPGConnection.Create(Config: IDatabaseConfig);
begin
    inherited Create(Config);
end;

end.
