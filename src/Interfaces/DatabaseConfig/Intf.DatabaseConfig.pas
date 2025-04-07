unit Intf.DatabaseConfig;

interface
type
    IDatabaseConfig = interface
        ['{2DBE450B-7CFC-4B9E-8C32-011A1EE183E2}']
        {getters}
        function Server: String; overload;
        function Database: String; overload;
        function Port: Integer; overload;
        function Username: String; overload;
        function Password: String; overload;
        function DriverId: String; overload;
        function ConnectionString: String; overload;
        {setters}
        function Server(Value: String): IDatabaseConfig; overload;
        function Database(Value: String): IDatabaseConfig; overload;
        function Port(Value: Integer): IDatabaseConfig; overload;
        function Username(Value: String): IDatabaseConfig; overload;
        function Password(Value: String): IDatabaseConfig; overload;
        function DriverId(Value: String): IDatabaseConfig; overload;
        function ConnectionString(Value: String): IDatabaseConfig; overload;
        {methods}
        function ToJSON: String;
        function Default: IDatabaseConfig;
        function Clear: IDatabaseConfig;
    end;

implementation

end.
