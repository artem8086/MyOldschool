uses crt;
var f:file of word;t,s,a:word;n:string;b,c:integer;
begin
  if paramcount=1 then assign(f,paramstr(1)) else begin
    write('Open file:');read(n);assign(f,n) end;
  reset(f);a:=0;for s:=0 to 10 do read(f,a);
  while not eof(f) do begin
    read(f,t);read(f,s);c:=0;b:=(a-s) div t;for t:=t downto 0 do begin
      sound(s+c);delay(1);c:=c+b end;a:=s end;
  close(f);nosound;
end.