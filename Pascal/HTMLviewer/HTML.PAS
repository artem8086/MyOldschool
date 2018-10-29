uses crt;
var n:string;b,sp,x,y,str:byte;d:word;
  col:array[0..255]of byte;f:file of byte;
procedure page;
begin
  asm
	mov	ah,5
	mov	al,str
	int	$10
  end;
end;
function ansi(c:byte):char;
var cb:byte;
begin
  if c>127 then cb:=c-64 else cb:=c;
  if c>239 then cb:=c-16;ansi:=chr(cb)
end;
begin
  if paramcount=1 then assign(f,paramstr(1)) else begin
    write('Open file:');read(n);assign(f,n) end;
  textmode(3);col[0]:=$F0;
  asm
	mov	ax,1003
	mov	bl,0
	int	$10
  end;reset(f);
  while not eof(f) do begin
    read(f,b);if b<>$D then begin
    textcolor(col[sp] and 15);
    textbackground(col[sp] shr 4);
    write(ansi(b)) end else begin
      read(f,b);writeln end;
  end;repeat
    case readkey of
      #0:case ord(readkey) of
	73:if str=0 then str:=7 else str:=str-1;
	81:if str=7 then str:=0 else str:=str+1;
      end;
      #13:break;
    end;page
  until str>8;
end.