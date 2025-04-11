unit MSSQL.DatabaseConfig;

interface
uses
    Intf.DatabaseConfig, Impl.DatabaseConfig, SysUtils;
type
    TMSSQLConnectionConfig = class(TDatabaseConnectionConfig)
    private
    public
        constructor Create; override;
        function ConnectionString: string; override;
    end;

implementation

{ TMSSQLConnectionConfig }

constructor TMSSQLConnectionConfig.Create;
begin
    inherited;
    Self.DriverId('MSSQL');
    Self.Port(1433);
end;

function TMSSQLConnectionConfig.ConnectionString: string;
var
    osauth: String;
begin
    osauth := 'N';
    if Self.OSAuthMSSQL then
        osauth := 'S';
    Result := Format('DriverID=MSSQL;Server=%s;Port=%d;Database=%s;User_Name=%s;Password=%s;OSAuthent=%s;MARS=No;Trusted_Connection=False', [Server, Port, Database, Username, Password, osauth]);
end;

end.
