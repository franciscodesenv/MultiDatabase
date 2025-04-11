unit Firebird.DatabaseConfig;

interface
uses
    Intf.DatabaseConfig, Impl.DatabaseConfig, SysUtils;
type
    TFBConnectionConfig = class(TDatabaseConnectionConfig)
    private
        function GetConnectionStr(Server, Port, Database, Username, Password: String): String;
    public
        constructor Create; override;
        function ConnectionString: string; override;
    end;

implementation

{ TFBConnectionConfig }

constructor TFBConnectionConfig.Create;
begin
    inherited;
    Self.DriverId('FB');
    Self.Port(3050);
end;

function TFBConnectionConfig.GetConnectionStr(Server, Port, Database, Username,
  Password: String): String;
begin
    Result := 'User=' + Username +';Password=' + Password +';Database=' + Database + ';DataSource='+ Server +';Port=' + Port +';Dialect=3;Charset=NONE;Role=;Connection lifetime=15;Pooling=true;MinPoolSize=0;MaxPoolSize=50;Packet Size=8192;ServerType=0;';
end;

function TFBConnectionConfig.ConnectionString: string;
var
    s: String;
begin
    s := inherited ConnectionString;
    if s <> '' then
        Result := s
    else
        Result :=GetConnectionStr(Server, IntToStr(Port), Database, Username, Password);
end;

end.
