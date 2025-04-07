unit MSSQL.DatabaseConfig;

interface
uses
    Intf.DatabaseConfig, Impl.DatabaseConfig, SysUtils;
type
    TMSSQLConnectionConfig = class(TDatabaseConnectionConfig)
    public
        constructor Create; override;
        function ConnectionString: string; override;
    end;

implementation

{ TMSSQLConnectionConfig }

constructor TMSSQLConnectionConfig.Create;
begin
    inherited;
    Self.DriverId('MySQL');
    Self.Port(3306);
end;

function TMSSQLConnectionConfig.ConnectionString: string;
var
    s: String;
begin
    s := inherited ConnectionString;
    if s <> '' then
        Result := s
    else
        Result := Format('DriverID=MySQL;Server=%s;Port=%d;Database=%s;User_Name=%s;Password=%s', [Server, Port, Database, Username, Password]);
end;

end.
