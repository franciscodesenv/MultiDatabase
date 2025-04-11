unit Postgre.Connection.Factory;

interface
uses
    Intf.Connection.Factory, Intf.DatabaseConnection, Intf.DatabaseConfig, Postgre.DatabaseConnection;
type
    TPGConnectionFactory = class(TDatabaseConnectionFactory)
    public
        function CreateConnection(Config: IDatabaseConfig): IDatabaseConnection; override;
    end;

implementation

{ TPGConnectionFactory }

function TPGConnectionFactory.CreateConnection(Config: IDatabaseConfig): IDatabaseConnection;
begin
    Result := TPGConnection.Create(Config);
end;

end.
