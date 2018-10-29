var f:file of byte;a,n:byte;
begin
  assign(f,'1.bmp');reset(f);
  for n:=1 to 24 do begin
    read(f,a);writeln(a) end;
  readln
end.
