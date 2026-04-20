program BaseProject;

uses
  Vcl.Forms,
  uMainForm in 'src\View\uMainForm.pas' {Form1},
  Intf.DatabaseConnection in 'src\Interfaces\DatabaseConnection\Intf.DatabaseConnection.pas',
  Impl.DatabaseConnection in 'src\Interfaces\DatabaseConnection\Impl.DatabaseConnection.pas',
  MySQL.DatabaseConnection in 'src\Interfaces\DatabaseConnection\MySQL.DatabaseConnection.pas',
  Intf.DatabaseConfig in 'src\Interfaces\DatabaseConfig\Intf.DatabaseConfig.pas',
  Impl.DatabaseConfig in 'src\Interfaces\DatabaseConfig\Impl.DatabaseConfig.pas',
  Intf.Connection.Factory in 'src\Interfaces\DatabaseConnectionFactory\Intf.Connection.Factory.pas',
  MySQL.DatabaseConfig in 'src\Interfaces\DatabaseConfig\MySQL.DatabaseConfig.pas',
  MySQL.Connection.Factory in 'src\Interfaces\DatabaseConnectionFactory\MySQL.Connection.Factory.pas',
  uDatabaseManager in 'src\Interfaces\DatabaseManager\uDatabaseManager.pas',
  MSSQL.DatabaseConnection in 'src\Interfaces\DatabaseConnection\MSSQL.DatabaseConnection.pas',
  MSSQL.DatabaseConfig in 'src\Interfaces\DatabaseConfig\MSSQL.DatabaseConfig.pas',
  MSSQL.Connection.Factory in 'src\Interfaces\DatabaseConnectionFactory\MSSQL.Connection.Factory.pas',
  Firebird.DatabaseConfig in 'src\Interfaces\DatabaseConfig\Firebird.DatabaseConfig.pas',
  Firebird.DatabaseConnection in 'src\Interfaces\DatabaseConnection\Firebird.DatabaseConnection.pas',
  Firebird.Connection.Factory in 'src\Interfaces\DatabaseConnectionFactory\Firebird.Connection.Factory.pas',
  Postgre.DatabaseConnection in 'src\Interfaces\DatabaseConnection\Postgre.DatabaseConnection.pas',
  Postgre.DatabaseConfig in 'src\Interfaces\DatabaseConfig\Postgre.DatabaseConfig.pas',
  Postgre.Connection.Factory in 'src\Interfaces\DatabaseConnectionFactory\Postgre.Connection.Factory.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
