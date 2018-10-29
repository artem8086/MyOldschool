uses Graph,Crt;
label 1,2,3,4,5;
const xm=250;ym=250;
var g:file of byte;b:array [1..xm,1..ym] of byte;e:byte;
    n:boolean;x,y,xg,yg:integer;x1,y1:word;xt,yt:integer;
    c:char;a:string;k,d:byte;GD,GM:integer;f:boolean;
begin
  xg:=1;yg:=1;
  write('open file:');read(a);assign(g,a);
  d:=10;k:=15;n:=false;f:=false;
  5:GD:=9;GM:=2;InitGraph(GD,GM,'c:\TP7');x:=1;y:=1;
  4:for xt:=1 to xm do
      for yt:=1 to ym do PutPixel(xt+xg,yt+yg,b[x,y]);
  1:f:=false;SetColor(15);
  if KeyPressed then c:=readkey else c:=' ';
  case c of
    'w':y:=y-1;
    'a':x:=x-1;
    'x':y:=y+1;
    'd':x:=x+1;
    'q':begin y:=y-1;x:=x-1 end;
    'z':begin x:=x-1;y:=y+1 end;
    'c':begin y:=y+1;x:=x+1 end;
    'e':begin y:=y-1;x:=x+1 end;
    ' ':if k>15 then k:=10;
    '-':b[x,y]:=0;
    's':begin n:=not n;repeat until not KeyPressed end;
    'o':begin reset(g);for x:=1 to xm do
      for y:=1 to ym do begin read(g,e);b[x,y]:=e end;close(g);goto 4 end;
    'v':begin for x:=1 to xm do for y:=1 to ym do begin b[x,y]:=0;goto 4 end;end;
    'n':begin rewrite(g);close(g) end;
    'f':begin rewrite(g);for x:=1 to xm do
      for y:=1 to ym do begin e:=b[x,y];write(g,e) end;close(g) end;
    'p':goto 4;
    '0'..'9':begin if d=0 then d:=100;
      k:=(ord(c)-ord('0'))*d+k;d:=d div 10 end;
    'g':begin f:=true;
    3:if KeyPressed then c:=readkey else c:=' ';
      SetColor(0);Rectangle(xg,yg,xg+xm,ym+yg);
      case c of
	' ':;
	'w':yg:=yg-1;
	'a':xg:=xg-1;
	'x':yg:=yg+1;
	'd':xg:=xg+1;
	'q':begin yg:=yg-1;xg:=xg-1 end;
	'z':begin xg:=xg-1;yg:=yg+1 end;
	'c':begin yg:=yg+1;xg:=xg+1 end;
	'e':begin yg:=yg-1;xg:=xg+1 end;
      else begin goto 4;goto 1 end;end;f:=true;SetColor(15) end;
    else goto 2;
  end;
  Rectangle(xg,yg,xg+xm,ym+yg);
  if n then b[x,y]:=k;
  if x=0 then x:=xm;
  if x>=xm then X:=1;
  if y=0 then y:=ym;
  if y>=ym then y:=1;
  PutPixel(x+xg,y+yg,k);
  Delay(50);
  PutPixel(x+xg,y+yg,b[x,y]);
  Delay(50);
  if f then goto 3 else goto 1;
2:CloseGraph
end.