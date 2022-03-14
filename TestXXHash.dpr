program TestXXHash;

{$APPTYPE CONSOLE}

{$R *.res}

uses
  System.SysUtils,
  SysTem.Hash,
  System.Diagnostics,
  XXHash;

const
  TestCount = $10000000;
var
  Data : array[0..TestCount-1] of Word;
  W : TStopWatch;
  s : string;
  M : THashMD5;
begin
  try
    { TODO -oUser -cConsole Main : Insert code here }
    randomize;
    for var i := 0 to TestCount-1 do Data[i] := Random(65536);
    Writeln(format('Data Size: %d bytes',[sizeof(Data)]));
    W := TStopWatch.Create;
    W.Start;
    M := THashMD5.Create;
    M.Update(Data,sizeof(Data));
    s := M.HashAsString;
    W.Stop;
    writeln(format('MD5:%s  Run time:%dms',[s,W.ElapsedMilliseconds]));
    W.Reset;W.Start;
    s := THashXXH3.HashAsString(@Data,sizeof(Data));
    W.Stop;
    writeln(format('XXH3:%s  Run time:%dms',[s,W.ElapsedMilliseconds]));
    readln;
  except
    on E: Exception do
      Writeln(E.ClassName, ': ', E.Message);
  end;
end.
