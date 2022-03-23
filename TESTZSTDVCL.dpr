program TESTZSTDVCL;

uses
  Vcl.Forms,
  TESTZSTDVCLMAIN in 'TESTZSTDVCLMAIN.pas' {Form2},
  EnsureDataVCL in 'EnsureDataVCL.pas',
  TestZSTDVCLUnit in 'TestZSTDVCLUnit.pas';

{$R *.res}

begin
  ReportMemoryLeaksOnShutdown := true;
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm2, Form2);
  Application.Run;
end.
