unit TESTZSTDVCLMAIN;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls;

type
  TForm2 = class(TForm)
    Memo1: TMemo;
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form2: TForm2;

implementation
uses EnSureDataVCL,TestZSTDVCLUnit,Threading;

{$R *.dfm}

procedure TForm2.FormShow(Sender: TObject);
begin
  TTask.Run(procedure begin
    TThread.Queue(TThread.Current,procedure begin
      CheckData(Memo1.Lines);
      application.ProcessMessages;
      DoTest(Memo1.Lines);
    end);
  end);
end;

end.
