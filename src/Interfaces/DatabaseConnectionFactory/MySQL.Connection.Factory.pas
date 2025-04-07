unit MySQL.Connection.Factory;

interface

uses
    Intf.Connection.Factory, Intf.DatabaseConnection, Intf.DatabaseConfig, MySQL.DatabaseConnection;
type
    TMySQLConnectionFactory = class(TDatabaseConnectionFactory)
    public
        function CreateConnection(Config: IDatabaseConfig): IDatabaseConnection; override;
    end;

implementation

{ TMySQLConnectionFactory }

function TMySQLConnectionFactory.CreateConnection(Config: IDatabaseConfig): IDatabaseConnection;
begin
    Result := TMySQLConnection.Create(Config);
end;

end.
