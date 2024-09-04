unit dynamic_list;

interface

type
  PNode = ^Node;
  Node = record
    data: integer;
    next: PNode;
  end;

var
  head, tail: PNode;

procedure addNode(a: integer);
procedure deleteNode;
procedure printList;

implementation

procedure addNode(a: integer);
var
  newNode: PNode;
begin
  new(newNode);
  newNode^.data := a;
  newNode^.next := nil;
  if head = nil then
  begin
    head := newNode;
    tail := newNode;
  end
  else
  begin
    tail^.next := newNode;
    tail := newNode;
  end;
end;

procedure deleteNode;
var
  temp: PNode;
begin
  if head = nil then
    writeln('Список пуст')
  else
  begin
    temp := head;
    head := head^.next;
    dispose(temp);
  end;
end;

procedure printList;
var
  current: PNode;
begin
  writeln('Список:');
  current := head;
  while current <> nil do
  begin
    write(current^.data, ' ');
    current := current^.next;
  end;
  writeln;
  readln;
end;

end.