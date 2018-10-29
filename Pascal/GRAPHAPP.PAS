unit GraphApp;
interface
uses GraphObgi;
const npoints=100;
type TGraphApp=object
    points:array [1..npoints] of tpoint;
    line:tline;
    rest:trest;
    circ:tcircle;
    activeobgi:integer;
    procedure init;
    procedure run;
    procedure done;
    procedure showall;
    procedure moveactiveobgi(dx,dy:integer);
  end;
implementation
uses Graph,Crt;
procedure TGraphApp.init;
var d,r,k:integer;
begin
  d:=0;r:=2;
  initgraph(d,r,'');
  for k:=1 to npoints do points[k].init(random(GetMaxX),random(GetMaxY),random(15)+1);
  line.init(GetMaxX div 3,GetMaxY div 3,2*GetMaxX div 3,2*GetMaxY div 3,4);
  circ.init(GetMaxX div 2,GetMaxY div 2,GetMaxY div 5,15);
  rest.init(2*GetMaxX div 5,2*GetMaxY div 5,3*getMaxX div 5,3*GetMaxY div 5,3);
  showall;
  activeobgi:=1;
end;
procedure TGraphApp.run;
var stop:boolean;
const d=5;
begin
  stop:=false;
  repeat
    case readkey of
      #27:stop:=true;
      #9:begin inc(activeobgi);
	if activeobgi>3 then activeobgi:=3
      end;
      #0:case readkey of
	#71:moveactiveobgi(-d,-d);
	#72:moveactiveobgi(0,-d);
	#73:moveactiveobgi(d,-d);
	#75:moveactiveobgi(-d,0);
	#77:moveactiveobgi(d,0);
	#79:moveactiveobgi(-d,d);
	#80:moveactiveobgi(0,d);
	#81:moveactiveobgi(d,d);
      end;
    end;
  showall;
  until stop
end;
procedure TGraphApp.done;
begin
  closegraph
end;
procedure TGraphApp.showall;
var k:integer;
begin
  for k:=1 to npoints do points[k].show;
  line.show;
  rest.show;
  circ.show;
end;
procedure TGraphApp.moveactiveobgi;
begin
  case activeobgi of
    1:rest.moveto(dx,dy);
    2:circ.moveto(dx,dy);
    3:line.moveto(dx,dy);
  end;
end;
end.