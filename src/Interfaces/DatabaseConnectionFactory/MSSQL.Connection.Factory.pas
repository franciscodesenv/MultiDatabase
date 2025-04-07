unit MSSQL.Connection.Factory;

interface
uses
    Intf.Connection.Factory, Intf.DatabaseConnection, Intf.DatabaseConfig, MSSQL.DatabaseConnection;
type
    TMSSQLConnectionFactory = class(TDatabaseConnectionFactory)
    public
        function CreateConnection(Config: IDatabaseConfig): IDatabaseConnection; override;
    end;

implementation

{ TMSSQLConnectionFactory }

function TMSSQLConnectionFactory.CreateConnection(Config: IDatabaseConfig): IDatabaseConnection;
begin
    Result := TMSSQLConnection.Create(Config);
end;

end.
