unit TestZSTDVCLUnit;

interface
uses
  System.SysUtils,
  classes,
  zstd,
  xxhash,
  system.zlib,
  System.Diagnostics,
  Forms;

procedure DoTest(L:TStrings); cdecl;

implementation
uses dialogs;

var data,c,d,cc,dd : TMemoryStream;
    ZC : TZstdCompressStream;
    ZD : TZSTDDecompressStream;
    ZLC : TZCompressionStream;
    ZLD : TZDeCompressionStream;
    W: TStopWatch;

procedure WriteInfo(L:TStrings; Op : String; St : TStream);
begin
  st.Position := 0;
  L.Add(Op+' in '+W.ElapsedMilliseconds.ToString+'ms   ');
  L.Add('Size: '+St.Size.ToString+'   XXHash3: '+THASHXXH3.HashAsString(St));
  Application.ProcessMessages;
  W.Reset;
  st.Position := 0;
end;
procedure DoTest(L:TStrings); cdecl;
begin
  L.Add('zstd version: '+ZSTD_VERSION_STRING);
  L.Add('');
  try
    { TODO -oUser -cConsole Main : Insert code here }
    W := TStopWatch.Create;
    data := TMemoryStream.Create;
    data.LoadFromFile('glibc-2.31.tar');
    data.Position := 0;
    L.Add('Orginal Size: '+data.SIZE.ToString+'  Orginal XXHash3: '+THASHXXH3.HashAsString(data));
    L.Add('');
    Application.ProcessMessages;
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
    WriteInfo(L,'Zlib Fastest Compress',cc);
    W.Start;
    dd.position := 0;
    ZLD := TZDecompressionStream.Create(CC);
    dd.CopyFrom(ZLD);
    ZLD.Free;
    W.Stop;
    WriteInfo(L,'Zlib Fastest DeCompress',dd);
    L.Add('');
    data.Position := 0;
    c.SetSize(0);
    W.Start;
    c.position := 0;
    ZC := TZSTDCompressStream.Create(C,1);
    ZC.CopyFrom(data,data.Size);
    ZC.Free;
    W.Stop;
    WriteInfo(L,'ZSTD Fastest Compress',c);
    W.Start;
    d.position := 0;
    ZD := TZSTDDecompressStream.Create(C,false);
    D.CopyFrom(ZD);
    ZD.Free;
    WriteInfo(L,'ZSTD Fastest DeCompress',d);
    L.Add('');
    cc.SetSize(0);
    data.Position := 0;
    W.Start;
    cc.position:= 0;
    ZLC := TZCompressionStream.Create(clDefault,cc);
    ZLC.CopyFrom(data,data.Size);
    ZLC.Free;
    W.Stop;
    WriteInfo(L,'Zlib Default Compress',cc);
    W.Start;
    dd.position := 0;
    ZLD := TZDecompressionStream.Create(CC);
    DD.CopyFrom(ZLD);
    ZLD.Free;
    W.Stop;
    WriteInfo(L,'Zlib Default DeCompress',dd);
    L.Add('');
    data.position := 0;
    c.SetSize(0);
    W.Start;
    c.position := 0;
    ZC := TZSTDCompressStream.Create(C);
    ZC.CopyFrom(data,data.Size);
    ZC.Free;
    W.Stop;
    WriteInfo(L,'ZSTD Default Compress',c);
    W.Start;
    d.position := 0;
    ZD := TZSTDDecompressStream.Create(C,false);
    D.CopyFrom(ZD);
    ZD.Free;
    W.Stop;
    WriteInfo(L,'ZSTD Default DeCompress',d);
    L.Add('');
    data.Position := 0;
    cc.SetSize(0);
    W.Start;
    cc.position:= 0;
    ZLC := TZCompressionStream.Create(clMAX,cc);
    ZLC.CopyFrom(data,data.Size);
    ZLC.Free;
    W.Stop;
    WriteInfo(L,'Zlib MAX Compress',cc);
    W.Start;
    dd.position := 0;
    ZLD := TZDecompressionStream.Create(CC);
    DD.CopyFrom(ZLD);
    ZLD.Free;
    W.Stop;
    WriteInfo(L,'Zlib MAX DeCompress',dd);
    L.Add('');
    data.position := 0;
    c.SetSize(0);
    W.Start;
    c.position := 0;
    ZC := TZSTDCompressStream.Create(C,9);
    ZC.CopyFrom(data,data.Size);
    ZC.Free;
    W.Stop;
    WriteInfo(L,'ZSTD LV9 Compress',c);
    W.Start;
    d.position := 0;
    ZD := TZSTDDecompressStream.Create(C,false);
    D.CopyFrom(ZD);
    ZD.Free;
    W.Stop;
    WriteInfo(L,'ZSTD LV9 DeCompress',d);
    L.Add('');
    data.Free;
    c.free;
    d.free;
    cc.free;
    dd.free;
  except
    on E: Exception do
      ShowMessage(E.ClassName+': '+E.Message);
  end;
end;

end.
