unit EnsureDataVCL;

interface
uses sysutils,classes,zstd;

const
  DataFile = 'glibc-2.31.tar';

procedure CheckData(L : TStrings);

implementation
uses YWTypes,xxhash;
procedure CheckData(L : TStrings);
var G : TFileStream;
    D : TZSTDDecompressStream;
    M,F : TMemoryStream;
    buf : array[0..128*1024-1] of byte;
begin
  if fileexists(DataFile) then Exit;
  L.ADD('File '+DataFile+' not found. creating....');
  F := TMemoryStream.Create;
  M := TMemoryStream.Create;
  try
    for var I := '1' to '4' do begin
      G := TFileStream.Create('DATA.PART.'+i,fmOpenRead);
      try
        var s : Cardinal;
        repeat
          s := G.Read(buf,128*1024);
          M.Write(buf,s);
        until s<128*1024;
      finally
        G.Free;
      end;
    end;
    M.Position := 0;
    D := TZSTDDecompressStream.Create(M,false);
    try
      F.CopyFrom(D,0,128*1024);
    finally
      D.Free;
    end;
    F.Position := 0;
    L.Add(Format('%d '+THASHXXH3.HashAsString(F),[F.Size]));
    F.Position := 0;
    F.SaveToFile(datafile);
  finally
    M.Free;
    F.Free;
  end;
  L.Add('File created.');
  L.Add('');
end;
end.
