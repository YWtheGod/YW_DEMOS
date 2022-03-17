program TESTLZ4;

{$APPTYPE CONSOLE}

{$R *.res}

uses
  LZ4TestUnit in 'LZ4TestUnit.pas',
  EnsureData in 'EnsureData.pas';

begin
  CheckData;
  DoTest;
end.
