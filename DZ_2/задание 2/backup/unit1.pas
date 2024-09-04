unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls;

type

  { TForm1 }

  TForm1 = class(TForm)
    Button1: TButton;
    Button2: TButton;
    Edit1: TEdit;
    Edit2: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Memo1: TMemo;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private

  public

  end;

var
  Form1: TForm1;

implementation

{$R *.lfm}

{ TForm1 }

procedure TForm1.Button1Click(Sender: TObject);
var
  c, a, S, alpha: real;
begin
  c := StrToInt(Edit1.Text);
  alpha := StrToInt(Edit2.Text);

  alpha := alpha * pi / 180;
  a := c / (2 * cos(alpha));
  S := c*(a*sin(alpha))/2;

  Memo1.Lines.Add('площадь тругольника = ' + FloatToStr(s));
  Memo1.Lines.Add('боковая сторона a = ' + FloatToStr(a));
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
  close;
end;

end.

