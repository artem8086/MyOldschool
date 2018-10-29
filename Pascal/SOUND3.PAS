uses crt;
var f:file of byte;t,s:byte;n:string;
begin
  if paramcount=1 then assign(f,paramstr(1)) else begin
    write('Open file:');read(n);assign(f,n) end;
  reset(f);
  while (not eof(f))or(not keypressed) do begin
    read(f,t);read(f,s);sound(s);delay(t);nosound end;
  close(f);
end.