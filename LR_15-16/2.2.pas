type
  PNode = ^Node;
  Node = record
    data: integer;
    next: PNode;
  end;

var
  Head, Temp: PNode;
  f: TextFile;
  value: integer;

// Функция создания узла
function CreateNode(value: integer): PNode;
var
  NewNode: PNode;
begin
  New(NewNode);
  NewNode^.data := value;
  NewNode^.next := nil;
  Result := NewNode;
end;

// Процедура добавления узла в список
procedure AddNode(var Head: PNode; NewNode: PNode);
var
  Temp: PNode;
begin
  if Head = nil then
    Head := NewNode
  else
  begin
    Temp := Head;
    while Temp^.next <> nil do
      Temp := Temp^.next;
    Temp^.next := NewNode;
  end;
end;

// Процедура вывода списка на экран
procedure PrintList(Head: PNode);
var
  Temp: PNode;
begin
  Temp := Head;
  while Temp <> nil do
  begin
    Write(Temp^.data, ' ');
    Temp := Temp^.next;
  end;
  Writeln;
end;

// Процедура добавления узлов из файла в список
procedure AddNodesFromFile(var Head: PNode; var f: TextFile);
var
  NewNode: PNode;
begin
  while not EOF(f) do
  begin
    Read(f, value);
    NewNode := CreateNode(value);
    AddNode(Head, NewNode);
  end;
end;

begin
  AssignFile(f, 'num.txt');
  Reset(f);
  Head := nil;
  
  // Добавление чисел из файла в список
  AddNodesFromFile(Head, f);
  
  CloseFile(f);
  
  // Вывод списка на экран
  PrintList(Head);
  
  // Вывод только четных элементов списка
  Temp := Head;
  Writeln('Четные элементы:');
  while Temp <> nil do
  begin
    if Temp^.data mod 2 = 0 then
      Write(Temp^.data, ' ');
    Temp := Temp^.next;
  end;
end.
