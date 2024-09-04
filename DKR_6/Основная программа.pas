program main;

uses crt, dynamic_list, static_list;

var
  choice: integer;
  value: integer;

begin
  head := nil;
  tail := nil;
  head2 := 1;
  tail2 := 1;
  repeat
    writeln('1. Динамический массив');
    writeln('2. Статический массив');
    writeln('3. Выход');
    write('Выберите вариант: ');
    readln(choice);
    clrscr();
    case choice of
      1:
        begin
          repeat
            writeln('1. Добавить элемент');
            writeln('2. Удалить элемент');
            writeln('3. Показать список');
            writeln('4. Выход');
            write('Выберите вариант: ');
            readln(choice);
            case choice of
              1:
                begin
                  write('Введите число: ');
                  readln(value);
                  addNode(value);
                end;
              2: deleteNode;
              3: printList;
            else
              writeln('Неправильно выбран вариант');
            end;
            clrscr();
          until choice = 4;
        end;
      2:
        begin
          repeat
            writeln('1. Добавить элемент');
            writeln('2. Удалить элемент');
            writeln('3. Показать список');
            writeln('4. Выход');
            write('Выберите вариант: ');
            readln(choice);
            case choice of
              1:
                begin
                  write('Введите число: ');
                  readln(value);
                  addNodeStatic(value);
                end;
              2: deleteNodeStatic;
              3: printList1;
            else
              writeln('Неправильно выбран вариант');
            end;
            clrscr();
          until choice = 4;
        end;
      3: ;
    else
      writeln('Неправильно выбран вариант');
    end;
  until choice = 3;
end.