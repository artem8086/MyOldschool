uses Graph,Crt;
label 1,2,3,4;
const xm=250;ym=250;
var f:file of byte;x,y:word;n:boolean;
    c:char;b,k,d:byte;GD,GM:integer;
begin
  GD:=0;assign(f,'1.pic');
  InitGraph(GD,GM,'');
  4:reset(f);for x:=0 to xm do for y:=0 to ym do begin read(f,b);putpixel(x,y,b) end;
  d:=100;k:=15;x:=0;y:=0;SetColor(15);
  1:if keypressed then c:=readkey else c:=' ';
  case c of
    ' ':if k>15 then k:=10;
    '-':putpixel(x,y,0);
    'w':y:=y-1;
    'a':x:=x-1;
    'x':y:=y+1;
    'd':x:=x+1;
    's':begin n:=not n;repeat until not KeyPressed end;
    'q':begin y:=y-1;x:=x-1 end;
    'z':begin x:=x-1;y:=y+1 end;
    'c':begin y:=y+1;x:=x+1 end;
    'e':begin y:=y-1;x:=x+1 end;
    'o':goto 4;
    'g':if not keypressed then close(f);
    'n':for x:=0 to xm do for y:=0 to ym do putpixel(x,y,0);
    '0'..'9':begin if d=0 then d:=100;
      k:=(ord(c)-ord('0'))*d+k;d:=d div 10 end;
    else goto 2;
  end;
  if n then putpixel(x,y,k);
  if x>xm then X:=0;
  if y>ym then y:=0;
  b:=getpixel(x,y);
  PutPixel(x,y,k);
  Delay(10);
  PutPixel(x,y,b);
  goto 1;
  2:rewrite(f);for  x:=0 to xm do for y:=0 to ym do begin b:=getpixel(x,y);write(f,b) end;
  if 13=ord(c) then goto 1
end.

