uses crt;
var f:file of byte;t,t1:word;n:string;s,b:byte;
begin
  if paramcount=1 then assign(f,paramstr(1)) else begin
    write('Open file:');read(n);assign(f,n) end;
    {$i-}
  reset(f);
  if ioresult<>0 then begin writeln('Error! Not file!');
  exit;
  end;
  {$i+}
  write('Temp:');read(t);
  for s:=0 to 10 do read(f,b);
  while (not eof(f))or(not keypressed) do begin
    read(f,s);sound(s);delay(t);nosound end;
  close(f);
end.