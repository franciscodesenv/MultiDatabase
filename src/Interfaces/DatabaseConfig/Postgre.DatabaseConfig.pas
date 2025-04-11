unit Postgre.DatabaseConfig;

interface
uses
    Intf.DatabaseConfig, Impl.DatabaseConfig, SysUtils;
type
    TPGConnectionConfig = class(TDatabaseConnectionConfig)
    public
        constructor Create; override;
        function ConnectionString: string; override;
    end;

implementation

{ TPGConnectionConfig }

constructor TPGConnectionConfig.Create;
begin
    inherited;
    Self.DriverId('PG');
    Self.Port(5432);
end;

function TPGConnectionConfig.ConnectionString: string;
var
    s: String;
begin
    s := Inherited ConnectionString;
    if s <> '' then
        Result := s
    else
        Result := Format('DriverID=MySQL;Server=%s;Port=%d;Database=%s;User_Name=%s;Password=%s', [Server, Port, Database, Username, Password]);
end;

end.
