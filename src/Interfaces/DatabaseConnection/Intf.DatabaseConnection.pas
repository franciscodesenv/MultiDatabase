unit Intf.DatabaseConnection;

interface
uses
    Data.DB;
type
    IDatabaseConnection = interface
        ['{8B135346-8A3E-4D54-BF8F-CD429AD47114}']
        function Connect: Boolean;
        procedure Disconnect;
        function IsConnected: Boolean;
        function ExecuteQuery(const SQL: string): TDataSet;
        function ExecuteCommand(const SQL: string): Integer;
        function StartTransaction: Boolean;
        function CommitTransaction: Boolean;
        function RollbackTransaction: Boolean;
        function GetLastError: string;
        function CreateParameter(const Name: string; DataType: TFieldType; Value: Variant): TParam;
    end;

implementation

end.
