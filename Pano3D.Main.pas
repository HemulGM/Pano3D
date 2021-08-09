unit Pano3D.Main;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.ListBox,
  FMX.Layouts, FMX.Objects, FMX.Controls.Presentation, FMX.StdCtrls,
  System.Math.Vectors, FMX.Controls3D, FMX.Objects3D, FMX.Viewport3D,
  FMX.MaterialSources;

type
  TForm1 = class(TForm)
    Viewport3D1: TViewport3D;
    Sphere1: TSphere;
    TextureMaterialSource1: TTextureMaterialSource;
    Camera1: TCamera;
    Button1: TButton;
    OpenDialog1: TOpenDialog;
    procedure Sphere1MouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Single; RayPos, RayDir: TVector3D);
    procedure Sphere1MouseMove(Sender: TObject; Shift: TShiftState; X, Y: Single; RayPos, RayDir: TVector3D);
    procedure Sphere1MouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Single; RayPos, RayDir: TVector3D);
    procedure Button1Click(Sender: TObject);
  private
    FMouseIsDown: Boolean;
    FMousePos: TPointF;
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

uses
  System.Math;

{$R *.fmx}

procedure TForm1.Button1Click(Sender: TObject);
begin
  if OpenDialog1.Execute then
  begin
    TextureMaterialSource1.Texture.LoadFromFile(OpenDialog1.FileName);
    TextureMaterialSource1.Texture.FlipHorizontal;
  end;
end;

procedure TForm1.Sphere1MouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Single; RayPos, RayDir: TVector3D);
begin
  SetCaptured(Sphere1);
  FMouseIsDown := True;
  FMousePos := Screen.MousePos;
end;

procedure TForm1.Sphere1MouseMove(Sender: TObject; Shift: TShiftState; X, Y: Single; RayPos, RayDir: TVector3D);
var
  AX, AY: Single;
begin
  if FMouseIsDown then
  begin
    AY := DegNormalize(Camera1.RotationAngle.Y - (Screen.MousePos.X - FMousePos.X) * 0.1);
    AX := DegNormalize(Camera1.RotationAngle.X + (Screen.MousePos.Y - FMousePos.Y) * 0.1);
    AX := Min(180, Max(5, DegNormalize(AX + 90))) - 90;
    Camera1.RotationAngle.X := 0;
    Camera1.RotationAngle.Y := AY;
    Camera1.RotationAngle.X := AX;
    FMousePos := Screen.MousePos;
  end;
end;

procedure TForm1.Sphere1MouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Single; RayPos, RayDir: TVector3D);
begin
  FMouseIsDown := False;
end;

end.

