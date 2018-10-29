uses crt,dos;
label 1,2;
var f:file of byte;b:byte;n:word;rom:array[0..64511]of byte;
function hex(a:byte):string;
var t:char;
begin
  if (a and $F)>9 then t:=chr(55+(a and $F)) else t:=chr(48+(a and $F));
  if ((a shr 4)and $F)>9 then hex:=concat(chr(55+((a shr 4)and $F)),t) else hex:=concat(chr(48+((a shr 4)and $F)),t);
end;
begin
  assign(f,'MONITOR.ROM');
  reset(f);for n:=0 to 64511 do read(f,rom[n]);close(f);n:=0;
  1:ClrScr;
  writeln('ПЗУ-редактор для Микро-ЭВМ':48);
  writeln;
  for b:=2 to 23 do writeln(hex((n+b-2)shr 8),hex(n+b-2),' ',hex(rom[n+b-2]));
  textbackground(9);textcolor(4);gotoxy(1,2);write(hex((n)shr 8),hex(n),'>');
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
  end;if n>64511 then n:=0;
  textbackground(0);textcolor(15);goto 1;
  2:textcolor(15);textbackground(0);
  clrscr;write('save(y/n)');b:=ord(readkey);
  if b=ord('y') then begin rewrite(f);for n:=0 to 64511 do begin
    write(f,rom[n]) end end;
end.