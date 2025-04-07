unit Intf.Connection.Factory;

interface
uses
    Intf.DatabaseConnection, Intf.DatabaseConfig;
type
    IDatabaseConnectionFactory = interface
        ['{63945767-D5CB-44D4-B8C8-2AC10F5268D1}']
        function CreateConnection(Config: IDatabaseConfig): IDatabaseConnection;
    end;

    TDatabaseConnectionFactory = class(TInterfacedObject, IDatabaseConnectionFactory)
    public
        function CreateConnection(Config: IDatabaseConfig): IDatabaseConnection; virtual; abstract;
    end;

implementation

end.
