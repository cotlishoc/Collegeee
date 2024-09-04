type
  PNode = ^Node;  // Определение типа указателя на узел
  Node = record   // Определение типа узла
    _Word: string;    // Слово
    Counter: integer; // Счетчик
    Next: PNode;      // Указатель на следующий узел[^1^][1]
  end;

var
  Head, NewNode, q: PNode; // Голова списка, новый узел и временный указатель[^1^][1]
  Counter: integer;        // Счетчик уникальных слов
  w: string;               // Текущее слово
  f: text;                 // Файловая переменная

// Функция для получения слова из файла
function GetWord(f: text): string;
var
  c: char;
begin
  Result := '';
  c := ' ';
  while not (EOF(f)) and (c <= ' ') do
    Read(f, c);
  while not (EOF(f)) and (c >  ' ') do
  begin
    Result += c;
    Read(f, c);
  end;
end;

// Функция для поиска слова в списке
function Find(Head: PNode; NewWord: string): PNode;
var
  q: PNode;
begin
  q := Head;
  while (q <> nil) and (q^._Word <> NewWord) do
    q := q^.Next;
  Result := q;
end;

// Функция для создания нового узла
function CreateNode(NewWord: string): PNode;
var
  NewNode: PNode;
begin
  New(NewNode);
  NewNode^._Word   := NewWord;
  NewNode^.Counter := 1;
  NewNode^.Next    := nil;
  Result := NewNode;
end;

// Функция для поиска места для нового узла в отсортированном списке
function FindPlace(Head: PNode; NewWord: string): PNode;
var
  q: PNode;
begin
  q := Head;
  while (q <> nil) and (NewWord > q^._Word) do
    q := q^.Next;
  Result := q;
end;

// Процедура для добавления нового узла в начало списка[^1^][1]
procedure AddFirst(var Head: PNode; NewNode: PNode);
begin
  NewNode^.Next := Head;
  Head          := NewNode;
end;

// Процедура для добавления нового узла после указанного узла
procedure AddAfter(p, NewNode: PNode);
begin
  NewNode^.Next := p^.Next;
  p^.Next       := NewNode;
end;

// Процедура для добавления нового узла перед указанным узлом[^1^][1]
procedure AddBefore(var Head: PNode; p, NewNode: PNode);
var
  q: PNode;
begin
  q := Head;
  if (p = Head) then
    AddFirst(Head, NewNode)
  else begin
    while (q <> nil) and (q^.Next <> p) do
      q := q^.Next;
    if (q <> nil) then
      AddAfter(q, NewNode);
  end;
end;

begin
  Head := nil;
  Assign(f, 'a.txt'); Reset(f);
  
  // Цикл для чтения слов из файла и добавления их в список
  while True do
  begin
    w := GetWord(f);
    if (w = '') then 
      break;
    q := Find(Head, w);
    if (q <> nil) then
      Inc(q^.Counter)
    else begin
      NewNode := CreateNode(w);
      q := FindPlace(Head, w);
      AddBefore(Head, q, NewNode);
    end;
  end;
  
  Close(f);
  Assign(f, 'output.txt'); 
  Rewrite(f);
  q := Head;
  Counter := 0;
  
  // Цикл для записи каждого слова и его счетчика в файл
  while (q <> nil) do
  begin
    Inc(Counter);
    Writeln(f, q^._Word, ': ', q^.Counter);
    q := q^.Next;
  end;
  
  // Запись общего количества уникальных слов
  Writeln(f, Counter, ' уникальных слова ');  
  Writeln(Counter, ' уникальных слова ');
  Close(f);
end.