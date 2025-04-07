unit MySQL.DatabaseConfig;

interface

uses
    Intf.DatabaseConfig, Impl.DatabaseConfig, SysUtils;
type
    TMySQLConnectionConfig = class(TDatabaseConnectionConfig)
    public
        constructor Create; override;
        function ConnectionString: string; override;
    end;

implementation

{ TMySQLConnectionConfig }

constructor TMySQLConnectionConfig.Create;
begin
    inherited;
    Self.DriverId('MySQL');
    Self.Port(3306);
end;

function TMySQLConnectionConfig.ConnectionString: string;
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
