uses crt,dos;
label 1,2;
var f:file of byte;b:byte;n:word;rom:array[0..60000]of byte;
begin
  assign(f,'ŒŽˆ’Ž.ROM');
  reset(f);for n:=0 to 60000 do read(f,rom[n]);close(f);n:=0;
  1:ClrScr;
  writeln('‡“-à¥¤ ªâ®à ¤«ï Œ¨ªà®-‚Œ':48);
  writeln;
  for b:=2 to 23 do writeln(n+b+5519,' ',rom[n+b-2]);
  textbackground(9);textcolor(4);gotoxy(1,2);write(n+5521,'>');
  if ord(readkey)=0 then b:=ord(readkey) else if ord(readkey)=27 then goto 2 else begin
    textcolor(15);textbackground(0);goto 1 end;
  case b of
    72:n:=n-1;
    80:n:=n+1;
    73:n:=n-1000;
    81:n:=n+1000;
    71:n:=n-100;
    79:n:=n+100;
    77:read(rom[n]);
  end;if n>60000 then n:=0;
  textbackground(0);textcolor(15);goto 1;
  2:textcolor(15);textbackground(0);
  clrscr;write('save(y/n)');b:=ord(readkey);
  if b=ord('y') then begin rewrite(f);for n:=0 to 60000 do begin
    write(f,rom[n]) end end;
end.