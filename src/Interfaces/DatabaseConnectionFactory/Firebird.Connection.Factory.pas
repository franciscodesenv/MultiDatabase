unit Firebird.Connection.Factory;

interface
uses
    Intf.Connection.Factory, Intf.DatabaseConnection, Intf.DatabaseConfig, Firebird.DatabaseConnection;
type
    TFBConnectionFactory = class(TDatabaseConnectionFactory)
    public
        function CreateConnection(Config: IDatabaseConfig): IDatabaseConnection; override;
    end;

implementation

{ TFBConnectionFactory }

function TFBConnectionFactory.CreateConnection(Config: IDatabaseConfig): IDatabaseConnection;
begin
    Result := TFBConnection.Create(Config);
end;

end.
