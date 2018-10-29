uses crt;
var f:file of longint;t,s,a:longint;n:string;
begin
  if paramcount=1 then assign(f,paramstr(1)) else begin
    write('Open file:');read(n);assign(f,n) end;
  write('Temp:');read(t);reset(f);
  while not eof(f) do begin
    read(f,s);sound(s);delay(t);nosound end;
  close(f);
end.