uses crt;
var f:file of longint;t,s:longint;n:string;a:word;
begin
  if paramcount=1 then assign(f,paramstr(1)) else begin
    write('Open file:');read(n);assign(f,n) end;
  reset(f);
  while not eof(f) do begin
    for a:=0 to (t shr 16)and $FFFF+1 do begin
      read(f,t);read(f,s);sound(s);delay(t);nosound end;
  end;close(f);
end.