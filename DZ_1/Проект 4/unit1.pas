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
    Edit3: TEdit;
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

procedure TForm1.Button2Click(Sender: TObject);
begin
  Close;
end;

procedure TForm1.Button1Click(Sender: TObject);
var
  a, b, i, h: integer;
  x, y: real;
  s: string;
begin
  a := StrToInt(Edit1.Text); // начало
  b := StrToInt(Edit2.Text); // конец
  h := StrToInt(Edit3.Text); // шаг
  for i := a to b do
  begin
    x := i;
    y := x * x;
    s := 'y = ' + FloatToStr(y) + ' при x = ' + IntToStr(i);
    Memo1.Lines.Add(s);
    Memo1.Lines.Add('');
    a:=a+h;
  end;
end;

end.

