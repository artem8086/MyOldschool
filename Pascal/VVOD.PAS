uses Crt;
var c:char;
begin
  repeat
    c:=readkey;
    writeln(c,'=',ord(c));
  until c=' ';
end.