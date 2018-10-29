unit graph3D;
interface
type func=function (x,y:real):real;
function sqr3D(x,y:real):real;
function cos3D(x,y:real):real;
function sin3D(x,y:real):real;
function abs3D(x,y:real):real;
function exp3D(x,y:real):real;
function arctan3D(x,y:real):real;
function read3D(x,y:real):real;
function random3D(x,y:real):real;
function func3D(x,y:real):real;
function clear3D(x,y:real):real;
var fun,xp,a,b,yp:integer;conx,cony,xs,ys:real;
fil:file of integer;wr,mouse:boolean;
procedure readwrite3D(x3,y3,z3:integer);
function posfuncx(xps,yps,fn:real):integer;
function posfuncy(xps,yps,fn:real):integer;
procedure graph3De(x3,y3:integer;f:func);
implementation
uses graph;
var x1,y1,x,y,sn:integer;x2,y2,rel:real;
procedure mice;
begin
  setcolor(4);
  PutPixel(x1,y1,4);
  line(x1,y1+1,x1,y1+15);line(x1+1,y1+1,x1+10,y1+10);
  line(x1+7,y1+11,x1+11,y1+11);line(x1+4,y1+12,x1+7,y1+18);
  line(x1+7,y1+12,x1+10,y1+18);line(x1+1,y1+14,x1+3,y1+12);
  PutPixel(x1+8,y1+19,4);PutPixel(x1+9,y1+19,4);
  setcolor(15)
end;
procedure graph3De;
begin
x:=-a;repeat
    y:=-b;
    repeat
      rel:=f(x,y);sn:=round(rel*256);
      x1:=round(xs*(y-x*conx)+xp);
      y1:=round(ys*(rel-x*cony)+yp);
      if (x3=x)and(y3=y)and(mouse) then mice;
      if wr then write(fil,sn);
      if (y=-b)
	then moveto (x1,y1)
	else lineto (x1,y1);
      y:=y+1;
    until y>b;
    x:=x+1;
  until x>a;
  y:=-b;
  repeat
    x:=-a;
    repeat
      x1:=round(xs*(y-x*conx)+xp);
      y1:=round(ys*(f(x,y)-x*cony)+yp);
      if (x=-a)
	then moveto (x1,y1)
	else lineto (x1,y1);
      x:=x+1;
    until x>a;
    y:=y+1;
  until y>b;
end;
procedure readwrite3D;
begin
seek(fil,round((y3+b)*(b*2+1)+x3+a+2));
read(fil,sn);
seek(fil,filepos(fil)-1);sn:=sn+z3;write(fil,sn)
end;
function posfuncx;
begin
  posfuncx:=round(xs*(yps-xp*conx));
end;
function posfuncy;
begin
  posfuncy:=round(ys*(fn-xps*cony));
end;
function cos3D;
begin cos3D:=cos(x/100)+cos(y/100) end;
function sin3D;
begin sin3D:=sin(x/100)+sin(y/100) end;
function sqr3D;
begin sqr3D:=sqr(x/100)+sqr(y/100) end;
function abs3D;
begin abs3D:=abs(x/100)+abs(y/100) end;
function arctan3D;
begin arctan3D:=arctan(x/100)+arctan(y/100) end;
function exp3D;
begin exp3D:=exp(x/100)+exp(y/100) end;
function random3D;
begin random3D:=random(10) end;
function read3D;
begin
seek(fil,round((y+b)*(b*2+1)+x+a+2));
read(fil,sn);read3D:=sn/256;
end;
function clear3D(x,y:real):real;
begin clear3D:=0 end;
function func3D;
var ch:char;srt:string[2];rl:real;
begin
fun:=fun and $1FF;
case fun and 7 of
  0:rl:=x;
  1:rl:=sin(x)/cos(x);
  2:rl:=sqr(x);
  3:rl:=cos(x);
  4:rl:=sin(x);
  5:rl:=abs(x);
  6:rl:=arctan(x);
  7:rl:=exp(x);
end;case (fun shr 3)and 7 of
  0:rl:=rl+y;
  1:rl:=rl+sin(y)/cos(y);
  2:rl:=rl+sqr(y);
  3:rl:=rl+cos(y);
  4:rl:=rl+sin(y);
  5:rl:=rl+abs(y);
  6:rl:=rl+arctan(y);
  7:rl:=rl+exp(y);
end;case fun shr 6 of
  0:rl:=rl*1;
  1:rl:=rl*(sin3d(x,y)/cos3d(x,y));
  2:rl:=rl*(sqr3d(x,y));
  3:rl:=rl*(cos3d(x,y));
  4:rl:=rl*(sin3d(x,y));
  5:rl:=rl*(abs3d(x,y));
  6:rl:=rl*(arctan3d(x,y));
  7:rl:=rl*(exp3d(x,y));
end;func3D:=rl
end;
begin
conx:=0.7010678;cony:=0.7010678;
wr:=false;a:=10;b:=10;xp:=200;
xs:=20;ys:=-20;yp:=200;
mouse:=false
end.