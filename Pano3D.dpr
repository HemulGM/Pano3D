program Pano3D;

uses
  System.StartUpCopy,
  FMX.Forms,
  Pano3D.Main in 'Pano3D.Main.pas' {Form1};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
