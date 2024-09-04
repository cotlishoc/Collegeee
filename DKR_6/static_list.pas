 unit static_list;

interface

type
  List = array[1..10] of record
    next: integer;
    data: integer;
  end;

var
  head2, tail2: integer;
  lit: List;

procedure addNodeStatic(a: integer);
procedure deleteNodeStatic;
procedure printList1;

implementation

procedure addNodeStatic(a: integer);
var
  i: integer;
begin
  if (tail2 + 1) mod 5 = head2 then
  begin
    deleteNodeStatic;
    i := i - 1;
    addNodeStatic(a);
  end
  else
  begin
    i := tail2 + 1;
    if i = 5 then
    begin
      deleteNodeStatic;
      i := 1;
    end;
    lit[i].data := a;
    lit[tail2].next := i;
    tail2 := i;
  end;
end;

procedure deleteNodeStatic;
begin
  if head2 = tail2 then
    writeln('Список пуст')
  else
  begin
    lit[head2].data := 0;
    head2 := lit[head2].next;
  end;
end;

procedure printList1;
var
  i: integer;
begin
  writeln('Кольцевой список:');
  i := head2;
  while i <> tail2 do
  begin
    write(lit[i].data, ' ');
    i := lit[i].next;
  end;
  write(lit[i].data);
  writeln;
  readln;
end;

end.