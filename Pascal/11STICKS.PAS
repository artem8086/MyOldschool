label 1,2,3;
var c:1..1000;y:1..3;n:integer;
begin
  writeln('��� � 11 ����祪.');
  write('������ ������⢮ ����祪:');
  readln(c);n:=c;
  while n>0 do n:=n-4;n:=n+3;c:=c-n;
  if n<>0 then goto 1;
  3:if c=1 then goto 2;
  write('��� 室:');readln(y);
  c:=c-4;n:=4-y;
  1:writeln('��� ��������:',n);goto 3;
  2:writeln('�������� �먣ࠫ!');
  read(y);
end.