unit kalkulatormain;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls;

type

  { TTkalkul }

  TTkalkul = class(TForm)
    ButBack: TButton;
    But4: TButton;
    But5: TButton;
    But6: TButton;
    ButIncrease: TButton;
    But1DivX: TButton;
    But1: TButton;
    But2: TButton;
    But3: TButton;
    ButMinus: TButton;
    Button19: TButton;
    ButClean: TButton;
    But0: TButton;
    Button21: TButton;
    BotPlus: TButton;
    ButCleanAll: TButton;
    Button4: TButton;
    But7: TButton;
    But8: TButton;
    But9: TButton;
    ButDivide: TButton;
    ButSquared: TButton;
    Output: TEdit;
    procedure But1DivXClick(Sender: TObject);
    procedure ButBackClick(Sender: TObject);
    procedure ButCleanAllClick(Sender: TObject);
    procedure ButCleanClick(Sender: TObject);
    procedure ButEqualClick(Sender: TObject);
    procedure ButSquaredClick(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure ButtonCliKK (Button: TButton);
    procedure ClickArifm(Sender: TObject);
  private

  public

  end;

var
  Tkalkul: TTkalkul;
  a, b, c: real;
  act: string;
implementation

{$R *.lfm}

{ TTkalkul }

procedure TTkalkul.ButCleanClick(Sender: TObject);
begin
  Output.Clear;
end;

procedure TTkalkul.ButEqualClick(Sender: TObject);
begin
  if Output.Text <> '' then
  if Output.Text <> '-' then
  begin
  b:= StrToFloat(Output.Text);
  Output.Clear;
  // переменной b присваивается значение с поля вывода, а также само поле вывода очищается для вывода конечного результата

  // в зависимости от нажатой кнопки действия выполняется арифметическое действие
  case act of
  '/': begin
    // проверка деления на 0
    if b <> 0 then c:= a/b
     else begin
       ShowMessage('Ошибка!' +#13 + 'На ноль делить нельзя!');
       c:= 0;
     end;
  end;
  '+': c:= a+b;
  '-': c:= a-b;
  '*': c:= a*b;
  end;

  // итоговый результат выносится в поле вывода
  Output.Text:= FloatToStr(c)
  end
  else ShowMessage('Ошибка!' +#13 + 'зачем знак!');
  end;


procedure TTkalkul.ButSquaredClick(Sender: TObject);
begin
  if Output.Text <> '' then
  if Output.Text <> '-' then
  begin
  a:= StrToFloat(Output.Text);
  a:= sqr(a);
  Output.Text:= FloatToStr(a);
  a:= 0;
  end
  else ShowMessage('Ошибка!' +#13 + 'зачем знак!');
end;

procedure TTkalkul.Button4Click(Sender: TObject);
begin
  if Output.Text <> '' then
  if Output.Text <> '-' then begin
  a:= StrToFloat(Output.Text);
  if a>=0 then a:= sqrt(a)
  else ShowMessage('Ошибка!' +#13 + 'Отрицательное число!');
  Output.Text:= FloatToStr(a);
  a:= 0;
  end
  else ShowMessage('Ошибка!' +#13 + 'зачем знак!');

end;

procedure TTkalkul.ButtonCliKK(Button: TButton);
begin
  if Output.Text = 'Ошибка' then
    Output.Clear
  else begin
  // Проверяем наличие запятой
    if (Button.Caption = ',') and (Pos(',', Output.Text) > 0) then
      Exit;
    if Output.Text <> '-' then
    Output.Text := Output.Text + Button.Caption;
  end;
end;

procedure TTkalkul.ClickArifm(Sender: TObject);
begin
  if Output.Text <> '' then
  if Output.Text <> '-' then
  begin
  a:= StrToFloat(Output.Text);
  Output.Clear;

  // схожая схема, переменной присваивается надпись с кнопки
  act:= (Sender as TButton).Caption;
end
  else ShowMessage('Ошибка!' +#13 + 'зачем знак!');
end;

procedure TTkalkul.But1DivXClick(Sender: TObject);
begin
  if Output.Text <> '' then
  if Output.Text <> '-' then
  begin
  a:= StrToFloat(Output.Text);
  // проверяется, равно ли значение нулю, и если да, то выводится сообщение об ошибке
  if a <> 0 then a:= 1/a
    else ShowMessage('Ошибка!' +#13 + 'На ноль делить нельзя!');
  Output.Text:= FloatToStr(a);
  a:= 0;
  end
  else ShowMessage('Ошибка!' +#13 + 'зачем знак!');
end;

procedure TTkalkul.ButBackClick(Sender: TObject);
var
  s: string;
begin
  s:= Output.Text;
  // если в поле вывода имеется какой-либо текст, то функция Delete удаляет последний символ
  if s <> '' then
   Delete(s, Length(s), 1);
  Output.Text:= s;
end;

procedure TTkalkul.ButCleanAllClick(Sender: TObject);
begin
  Output.Clear;
  a:= 0; b:= 0; c:= 0;
end;

end.

