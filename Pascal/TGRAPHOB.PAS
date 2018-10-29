unit GraphObgi;
interface
type TGraphObgi=object
    x,y:integer;
    color:word;
    constructor init(ax,ay:integer;acolor:word);
    procedure draw(acolor:word);virtual;
    procedure show;
    procedure hide;
    procedure moveto(dx,dy:integer);
  end;
  TPoint=object(TGraphObgi)
    procedure draw(acolor:word);virtual;
  end;
  TLine=object(TGraphObgi)
    dx,dy:integer;
    constructor init(x1,y1,x2,y2:integer;acolor:word);
    procedure draw(acolor:word);virtual;
  end;
  TCircle=object(TGraphObgi)
    r:integer;
    constructor init(ax,ay,ar:integer;acolor:word);
    procedure draw(acolor:word);virtual;
  end;
  TRest=object(TLine)
    procedure draw(acolor:word);virtual;
  end;
implementation
uses Graph;
constructor TGraphObgi.init;
begin
  x:=ax;y:=ay;
  color:=acolor;
end;
procedure TGraphObgi.draw;
begin
end;
procedure TGraphObgi.show;
begin
  draw(color);
end;
procedure TGraphObgi.hide;
begin
  draw(GetBkColor);
end;
procedure TGraphObgi.moveto;
begin
  hide;
  x:=x+dx;y:=y+dy;
  show;
end;
procedure TPoint.draw;
begin
  putpixel(x,y,color);
end;
constructor TLine.init;
begin
  inherited init(x1,y1,acolor);
  dx:=x2-x1;dy:=y2-y1;
end;
procedure TLine.draw;
begin
  setcolor(color);
  line(x,y,x+dx,y+dy);
end;
constructor TCircle.init;
begin
  inherited init(ax,ay,acolor);
  r:=ar;
end;
procedure TCircle.draw;
begin
  setcolor(acolor);
  circle(x,y,r);
end;
procedure TRest.draw;
begin
  setcolor(acolor);
  rectangle(x,y,x+dx,y+dy);
end;
end.