uses Graph,Crt;
label 1,2;
const xm=100;ym=100;
type pic=record
  a:array [1..xm,1..ym] of byte
end;
var g:file of pic;b:pic;x,y:word;
    c:char;a:string;k,d:byte;GD,GM:integer;
begin
  writeln('open file:');read(a);assign(g,a);
  GD:=9;GM:=2;
  InitGraph(GD,GM,'c:\TP7');
  reset(g);read(g,b);close(g);
  d:=100;k:=0;
  for x:=1 to xm do
    for y:=1 to ym do PutPixel(x,y,b.a[x,y]);
    x:=1;y:=1;
  1:c:=readkey;
  case c of
    'w':y:=y-1;
    'a':x:=x-1;
    'x':y:=y+1;
    'd':x:=x+1;
    's':begin PutPixel(x,y,k);b.a[x,y]:=k end;
    'q':begin y:=y-1;x:=x-1 end;
    'z':begin x:=x-1;y:=y+1 end;
    'c':begin y:=y+1;x:=x+1 end;
    'e':begin y:=y-1;x:=x+1 end;
    '0'..'9':begin if d=0 then d:=100;
      k:=(ord(c)-ord('0'))*d+k;d:=d div 10 end;
    else goto 2;
  end;
  if x=0 then x:=1;
  if x>xm then X:=xm;
  if y=0 then y:=1;
  if y>ym then y:=ym;
  Delay(500);goto 1;
2:CloseGraph;rewrite(g);write(g,b)
end.