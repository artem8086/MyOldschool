uses crt;
var x,y:word;b,c,d,s,z,p:byte;
procedure putpixel(x2,y2:word;col:byte);
begin
  asm
	mov	ah,$C
	mov     al,col
	mov	bh,0
	mov	cx,x2
	mov	dx,y2
	int	$10
  end;
end;
procedure mice(t:byte);
begin
  PutPixel(x,y,$FF*t);
  for b:=1 to 15 do PutPixel(x,y+b,$FF*t);
  for b:=1 to 10 do PutPixel(x+b,y+b,$FF*t);
  for b:=7 to 11 do PutPixel(x+b,y+11,$FF*t);
  for b:=0 to 3 do begin
    PutPixel(x+b+4,y+b*2+12,$FF*t);
    PutPixel(x+b+4,y+b*2+13,$FF*t);
    PutPixel(x+b+7,y+b*2+12,$FF*t);
    PutPixel(x+b+7,y+b*2+13,$FF*t);
  end;for b:=1 to 3 do PutPixel(x+b,y-b+15,$FF*t);
  PutPixel(x+8,y+19,$FF*t);
  PutPixel(x+9,y+19,$FF*t);
end;
begin
  asm
	mov	ah,$4F
	mov	al,2
	mov	bx,$106
	int	$10
  end;mice(1);d:=0;z:=1;
  repeat
    if keypressed then begin mice(0);
      if 0=ord(readkey) then c:=ord(readkey) else if #27=readkey then c:=27 else c:=0;
      case c of
	72:y:=y-z;
	75:x:=x-z;
	80:y:=y+z;
	77:x:=x+z;
      end;
      if d>5 then begin d:=0;z:=z+1 end else d:=d+1;
      if z>10 then z:=10;
      if x>1275 then x:=0;
      if y>1015 then y:=0;mice(1);
    end;if p<>c then begin d:=0;z:=1;p:=c end;
  until 27=c;
end.