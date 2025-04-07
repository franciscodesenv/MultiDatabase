unit MySQL.DatabaseConnection;

interface
uses
    System.SysUtils, FireDAC.Phys.MySQL,
    FireDAC.Phys.Intf, FireDAC.UI.Intf, FireDAC.Stan.ASync,
    Intf.DatabaseConnection, Impl.DatabaseConnection,
    Intf.DatabaseConfig, Impl.DatabaseConfig;
type
    TMySQLConnection = class(TDatabaseConnection)
    private
        FMySQLDriver: TFDPhysMySQLDriverLink;
    public
        constructor Create(Config: IDatabaseConfig); override;
        destructor Destroy; override;
        function Connect: Boolean; override;
    end;

implementation

{ TMySQLConnection }

function TMySQLConnection.Connect: Boolean;
begin
    try
        Connection.Params.Clear;
        Connection.ConnectionString := Config.ConnectionString;
        Connection.DriverName := 'MySQL';
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

constructor TMySQLConnection.Create(Config: IDatabaseConfig);
begin
    inherited Create(Config);
    FMySQLDriver := TFDPhysMySQLDriverLink.Create(nil);
    FMySQLDriver.VendorLib := ExtractFilePath(ParamStr(0)) + 'libmysql.dll';
end;

destructor TMySQLConnection.Destroy;
begin
    if Assigned(FMySQLDriver) then
    begin
        FMySQLDriver.Free;
    end;
    inherited;
end;

end.
