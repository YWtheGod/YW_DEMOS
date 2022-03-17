unit LZ4TestUnit;

interface
uses
  System.SysUtils,
  classes,
  lz4,
  xxhash,
  system.zlib,
  System.Diagnostics  ;

procedure DoTest; cdecl;

implementation

var data,c,d,cc,dd : TMemoryStream;
    ZC : TLZ4CompressStream;
    ZD : TLZ4DecompressStream;
    ZLC : TZCompressionStream;
    ZLD : TZDeCompressionStream;
    W: TStopWatch;

procedure WriteInfo(Op : String; St : TStream);
begin
  st.Position := 0;
  write(Op,' in ',W.ElapsedMilliseconds,'ms   ');
  writeln('Size: ',St.Size,'   XXHash3: ',THASHXXH3.HashAsString(St));
  W.Reset;
  st.Position := 0;
end;
procedure DoTest; cdecl;
begin
  writeln('LZ4 version: ',LZ4_VERSION_STRING);
  writeln;
  try
    { TODO -oUser -cConsole Main : Insert code here }
    W := TStopWatch.Create;
    data := TMemoryStream.Create;
    data.LoadFromFile('glibc-2.31.tar');
    data.Position := 0;
    writeln('Orginal Size: ',data.SIZE,'  Orginal XXHash3: ',THASHXXH3.HashAsString(data));
    writeln;
    C := TMemoryStream.Create;
    D := TMemoryStream.Create;
    cc := TMemoryStream.Create;
    dd := TMemoryStream.Create;
    data.Position := 0;
    cc.SetSize(0);
    W.Start;
    cc.position:= 0;
    ZLC := TZCompressionStream.Create(clFastest,cc);
    ZLC.CopyFrom(data,data.Size);
    ZLC.Free;
    W.Stop;
    WriteInfo('Zlib Fastest Compress',cc);
    W.Start;
    dd.position := 0;
    ZLD := TZDecompressionStream.Create(CC);
    dd.CopyFrom(ZLD);
    ZLD.Free;
    W.Stop;
    WriteInfo('Zlib Fastest DeCompress',dd);
    writeln;
    data.Position := 0;
    c.SetSize(0);
    W.Start;
    c.position := 0;
    ZC := TLZ4CompressStream.Create(C,1);
    ZC.CopyFrom(data,data.Size);
    ZC.Free;
    W.Stop;
    WriteInfo('LZ4 Fastest Compress',c);
    W.Start;
    d.position := 0;
    ZD := TLZ4DecompressStream.Create(C,false);
    D.CopyFrom(ZD);
    ZD.Free;
    WriteInfo('LZ4 Fastest DeCompress',d);
    writeln;
    cc.SetSize(0);
    data.Position := 0;
    W.Start;
    cc.position:= 0;
    ZLC := TZCompressionStream.Create(clDefault,cc);
    ZLC.CopyFrom(data,data.Size);
    ZLC.Free;
    W.Stop;
    WriteInfo('Zlib Default Compress',cc);
    W.Start;
    dd.position := 0;
    ZLD := TZDecompressionStream.Create(CC);
    DD.CopyFrom(ZLD);
    ZLD.Free;
    W.Stop;
    WriteInfo('Zlib Default DeCompress',dd);
    writeln;
    data.position := 0;
    c.SetSize(0);
    W.Start;
    c.position := 0;
    ZC := TLZ4CompressStream.Create(C);
    ZC.CopyFrom(data,data.Size);
    ZC.Free;
    W.Stop;
    WriteInfo('LZ4 Default Compress',c);
    W.Start;
    d.position := 0;
    ZD := TLZ4DecompressStream.Create(C,false);
    D.CopyFrom(ZD);
    ZD.Free;
    W.Stop;
    WriteInfo('LZ4 Default DeCompress',d);
    writeln;
    data.Position := 0;
    cc.SetSize(0);
    W.Start;
    cc.position:= 0;
    ZLC := TZCompressionStream.Create(clMAX,cc);
    ZLC.CopyFrom(data,data.Size);
    ZLC.Free;
    W.Stop;
    WriteInfo('Zlib MAX Compress',cc);
    W.Start;
    dd.position := 0;
    ZLD := TZDecompressionStream.Create(CC);
    DD.CopyFrom(ZLD);
    ZLD.Free;
    W.Stop;
    WriteInfo('Zlib MAX DeCompress',dd);
    writeln;
    data.position := 0;
    c.SetSize(0);
    W.Start;
    c.position := 0;
    ZC := TLZ4CompressStream.Create(C,12);
    ZC.CopyFrom(data,data.Size);
    ZC.Free;
    W.Stop;
    WriteInfo('LZ4 LV12 Compress',c);
    W.Start;
    d.position := 0;
    ZD := TLZ4DecompressStream.Create(C,false);
    D.CopyFrom(ZD);
    ZD.Free;
    W.Stop;
    WriteInfo('LZ4 LV12 DeCompress',d);
    writeln;
    data.Free;
    c.free;
    d.free;
    cc.free;
    dd.free;
  except
    on E: Exception do
      Writeln(E.ClassName, ': ', E.Message);
  end;
  writeln('Done! press ENTER to quit');
  readln;
end;

end.
