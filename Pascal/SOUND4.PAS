uses crt;
var f:file of word;t,s:word;n:string;
begin
  if paramcount=1 then assign(f,paramstr(1)) else begin
    write('Open file:');read(n);assign(f,n) end;
  reset(f);for s:=0 to 10 do read(f,t);
  while (not eof(f))or(not keypressed) do begin
    read(f,t);read(f,s);sound(s);delay(t);nosound end;
  close(f);
end.