﻿program retygde;
var a,b : integer;
begin
  writeln ('введите трехзначное число, затем четырехзначное' );
  readln (a, b);
  a:= a div 100;  //нахождение первой цифры трехзначного
  b:= b div 1000;  // первой четырехзначное
  writeln ('Первая цифра трехзначного числа =', a);
  writeln ('Первая цифра четырехзначного =', b);
end.
