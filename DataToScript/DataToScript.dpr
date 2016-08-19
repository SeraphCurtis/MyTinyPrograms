program DataToScript;

uses
  Vcl.Forms,
  UniDataToScript in 'UniDataToScript.pas' {Form3};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm3, Form3);
  Application.Run;
end.
