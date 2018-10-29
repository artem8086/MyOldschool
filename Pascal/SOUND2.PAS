uses crt;
var f:file of word;t,s:word;n:string;
begin
  if paramcount=1 then assign(f,paramstr(1)) else begin
    write('Open file:');read(n);assign(f,n) end;
  write('Temp:');read(t);reset(f);
  while (not eof(f))or(not keypressed) do begin
    read(f,s);sound(s);delay(t);nosound end;
  close(f);
end.