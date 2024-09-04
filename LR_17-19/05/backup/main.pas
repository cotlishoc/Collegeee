unit Main;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls;

type
  { TfMain }
  TfMain = class(TForm)
    doubleprocedure: TButton;
    doublefunction: TButton;
    doublessylka: TButton;
    doubleglobal: TButton;
    doubleglobalX2: TButton;
    Edit1: TEdit;
    Label1: TLabel;
    procedure doubleprocedureClick(Sender: TObject);
    procedure doublefunctionClick(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    function sussynumbercheck(st: string; var r: Real): Boolean;
    procedure Udvoenie(st: string);
    function FuncUdvoenie(st: string): string;
    procedure UdvoeniePoSsilke(var r: Real);
    procedure MyPrivat;
    procedure MyDouble;
  public
  end;

var
  fMain: TfMain;
  MyNum: Real; // глобальная для mynum

implementation

{$R *.lfm}

{ TfMain }

function TfMain.sussynumbercheck(st: string; var r: Real): Boolean;
begin
  if st <> '' then
  begin
    if TryStrToFloat(st, r) then
      Result := True
    else
    begin
      ShowMessage('Некорректный ввод. Введите число, при дробном - через запятую.');
      Result := False;
    end;
  end
  else
  begin
    ShowMessage('Пустое поле. Введите вещественное число.');
    Result := False;
  end;
end;

procedure TfMain.Udvoenie(st: string);
var
  r: Real;
begin
  if sussynumbercheck(st, r) then
  begin
    r := r * 2;
    ShowMessage(FloatToStr(r));
  end;
end;

function TfMain.FuncUdvoenie(st: string): string;
var
  r: Real;
begin
  if sussynumbercheck(st, r) then
  begin
    r := r * 2;
    Result := FloatToStr(r);
  end
  else
    Result := '';
end;

procedure TfMain.UdvoeniePoSsilke(var r: Real); // параметр по ссылке
begin
  r := r * 2;
end;

procedure TfMain.MyPrivat; // с предварительным объявлением
var
  r: Real;
begin
  if sussynumbercheck(Edit1.Text, r) then
  begin
    r := r * 2;
    ShowMessage(FloatToStr(r));
  end;
end;

procedure TfMain.MyDouble; // удвоение глобальной переменной
begin
  MyNum := MyNum * 2;
end;




procedure TfMain.doubleprocedureClick(Sender: TObject);
begin
  Udvoenie(Edit1.Text);
end;

procedure TfMain.doublefunctionClick(Sender: TObject);
begin
  ShowMessage(FuncUdvoenie(Edit1.Text));
end;

procedure TfMain.Button3Click(Sender: TObject);
var
  myReal: Real;
begin
  if sussynumbercheck(Edit1.Text, myReal) then
  begin
    UdvoeniePoSsilke(myReal);
  end;
end;

procedure TfMain.Button4Click(Sender: TObject);
begin
  MyPrivat;
end;

procedure TfMain.Button5Click(Sender: TObject);
begin
  if sussynumbercheck(Edit1.Text, MyNum) then
  begin
    MyDouble;
  end;
end;

procedure TfMain.FormCreate(Sender: TObject);
begin

end;

begin

end.

