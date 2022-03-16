program TestZSTDDirect;

{$APPTYPE CONSOLE}

{$R *.res}

uses
  System.SysUtils,
  classes,
  xxhash,
  zstd,
  EnsureData in 'EnsureData.pas';

var m : TMemoryStream;
    b1,b2 : TBytes;
    i : NativeInt;
begin
  try
    { TODO -oUser -cConsole Main : Insert code here }
    CheckData;
    M := TMemoryStream.Create;
    M.LoadFromFile('glibc-2.31.tar');
    SetLength(b1,M.Size);
    i := CompressData(M.Memory,M.Size,b1,Length(b1),4);
    SetLength(b1,i);
    M.Free;
    b2 := DeCompressData(b1);
    writeln(i,'  ',THashXXH3.HashAsString(b2));
    b1 := CompressData(b2);
    b2 := DeCompressData(b1);
    writeln(Length(b1),'  ',THashXXH3.HashAsString(b2));
  except
    on E: Exception do
      Writeln(E.ClassName, ': ', E.Message);
  end;
  readln;
end.
