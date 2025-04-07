unit Impl.DatabaseConnection;

interface
uses
    Intf.DatabaseConnection, System.SysUtils, Data.DB, FireDAC.Comp.Client,
    Intf.DatabaseConfig, FireDAC.DApt, FireDAC.Stan.Def, FireDAC.UI.Intf, FireDAC.VCLUI.Wait,
    FireDAC.Comp.UI;
type
    TDatabaseConnection = class(TInterfacedObject, IDatabaseConnection)
    private
        FWaitCursor: IFDGUIxWaitCursor;
        FConnection: TFDConnection;
        FConfig: IDatabaseConfig;
        FLastError: String;
        procedure FConnectionBeforeConnect(Sender: TObject);
    protected
        procedure HandleException(E: Exception);
    public
        constructor Create(ConnectionParams: IDatabaseConfig); virtual;
        destructor Destroy; override;

        function Connect: Boolean; virtual;
        procedure Disconnect; virtual;
        function IsConnected: Boolean; virtual;
        function ExecuteQuery(const SQL: string): TDataSet; virtual;
        function ExecuteCommand(const SQL: string): Integer; virtual;
        function StartTransaction: Boolean; virtual;
        function CommitTransaction: Boolean; virtual;
        function RollbackTransaction: Boolean; virtual;
        function GetLastError: string; virtual;
        function CreateParameter(const Name: string; DataType: TFieldType; Value: Variant): TParam; virtual;
    published
        property Connection: TFDConnection read FConnection;
        property Config: IDatabaseConfig read FConfig;
    end;

implementation

{ TDatabaseConnection }

function TDatabaseConnection.CommitTransaction: Boolean;
begin
    Result := False;
    try
        if FConnection.InTransaction then
        begin
            FConnection.Commit;
            Result := True;
        end;
    except on E: Exception do
        HandleException(E);
    end;
end;

function TDatabaseConnection.Connect: Boolean;
begin
    Result := False;
    try
        if FConnection.Connected then
            FConnection.Connected := False;
        FConnection.ConnectionString := FConfig.ConnectionString;
        FConnection.Connected := True;
        Result := FConnection.Connected;
    except on E: Exception do
        begin
            HandleException(E);
            Result := False;
        end;
    end;
end;

constructor TDatabaseConnection.Create(ConnectionParams: IDatabaseConfig);
begin
    inherited Create;
    FConfig := ConnectionParams;
    FConnection := TFDConnection.Create(nil);
    FConnection.LoginPrompt := False;
    FWaitCursor := TFDGUIxWaitCursor.Create(nil);
//    FConnection.BeforeConnect := Self.FConnectionBeforeConnect;
end;

function TDatabaseConnection.CreateParameter(const Name: string;
  DataType: TFieldType; Value: Variant): TParam;
begin
    Result := TParam.Create(nil);
    Result.Name := Name;
    Result.DataType := DataType;
    Result.Value := Value;
end;

destructor TDatabaseConnection.Destroy;
begin
    if Assigned(FConnection) then
    begin
        if FConnection.Connected then
            FConnection.Connected := False;
        FConnection.Free;
    end;
//    if Assigned(FWaitCursor) then
//    begin
//        FWaitCursor.Free;
//    end;
    inherited;
end;

procedure TDatabaseConnection.Disconnect;
begin
    try
        if FConnection.Connected then
          FConnection.Connected := False;
    except on E: Exception do
        HandleException(E);
    end;
end;

function TDatabaseConnection.ExecuteCommand(const SQL: string): Integer;
var
  query: TFDQuery;
begin
    Result := -1;
    try
        query := TFDQuery.Create(nil);
        try
            query.Connection := FConnection;
            query.SQL.Text := SQL;
            query.ExecSQL;
            Result := query.RowsAffected;
        finally
            query.Free;
        end;
    except on E: Exception do
        HandleException(E);
    end;
end;

function TDatabaseConnection.ExecuteQuery(const SQL: string): TDataSet;
var
    query: TFDQuery;
begin
    Result := nil;
    try
        query := TFDQuery.Create(nil);
        query.Connection := FConnection;
        query.SQL.Text := SQL;
        query.Open;
        Result := query;
    except on E: Exception do
        begin
            HandleException(E);
            if Assigned(query) then
                query.Free;
        end;
    end;
end;

procedure TDatabaseConnection.FConnectionBeforeConnect(Sender: TObject);
begin
    {
    if Assigned(FConfig) then
    begin
        if TFDConnection(Sender).Connected then
            TFDConnection(Sender).Close;
        if Trim(FConfig.ConnectionString) <> '' then
        begin
            TFDConnection(Sender).ConnectionString := FConfig.ConnectionString;
        end
        else
        begin
            TFDConnection(Sender).Params.Clear;
            TFDConnection(Sender).Params.DriverID := FConfig.DriverID;
            TFDConnection(Sender).Params.Database := FConfig.Database;
            TFDConnection(Sender).Params.UserName := FConfig.Username;
            TFDConnection(Sender).Params.Password := FConfig.Password;
            TFDConnection(Sender).Params.Values['Port'] := FConfig.Port.ToString;
            TFDConnection(Sender).Params.Values['Server'] := FConfig.Server;
        end;
    end;
    }
end;

function TDatabaseConnection.GetLastError: string;
begin
    Result := FLastError;
end;

procedure TDatabaseConnection.HandleException(E: Exception);
begin
    FLastError := e.Message;
//    raise Exception.Create('Error Message: ' + FLastError);
end;

function TDatabaseConnection.IsConnected: Boolean;
begin
    Result := FConnection.Connected;
end;

function TDatabaseConnection.RollbackTransaction: Boolean;
begin
    Result := False;
    try
        if FConnection.InTransaction then
        begin
            FConnection.Rollback;
            Result := True;
        end;
    except  on E: Exception do
        HandleException(E);
    end;
end;

function TDatabaseConnection.StartTransaction: Boolean;
begin
    Result := False;
    try
        if not(FConnection.Connected) then
            Connect;
        if not(FConnection.InTransaction) then
            FConnection.StartTransaction;
        Result := FConnection.InTransaction;
    except on E: Exception do
        HandleException(E);
    end;
end;

end.
