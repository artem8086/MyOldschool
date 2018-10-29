uses Graph,Crt;
var d,r,r1,r2,rr,k,x1,y1,x2,y2,x01,y01:integer;
  xasp,yasp:word;
begin
  d:=9;r:=2;
  initGraph(d,r,'d:\TP7');
  x1:=GetMaxX div 2;
  y1:=GetMaxY div 2;
  GetAspectRatio(xasp,yasp);
  r:=round(3*GetMaxY*yasp/8/xasp);
  r1:=round(0.9*r);
  r2:=round(0.95*r);
  circle(x1,y1,r);
  circle(x1,y1,round(1.02*r));
  for k:=0 to 59 do begin
    if k mod 5=0 then rr:=r1 else rr:=r2;
    x01:=x1+round(rr*sin(2*pi*k/60));
    y01:=y1-round(rr*xasp*cos(2*pi*k/60)/yasp);
    x2:=x1+round(r*sin(2*pi*k/60));
    y2:=y1-round(r*xasp*cos(2*pi*k/60)/yasp);
    line(x01,y01,x2,y2)
  end;
  SetWriteMode(XORPut);
  SetLineStyle(0,0,3);
  r:=0;
  repeat
    for k:=0 to 59 do
    if not KeyPressed then begin
      x01:=x1+round(r2*sin(2*pi*k/60));
      y01:=y1-round(r2*xasp*cos(2*pi*k/60)/yasp);
      x2:=x1+round(0.85*r1*sin(2*pi*r/60/12));
      y2:=y1-round(0.85*r1*xasp*cos(2*pi*r/60/12)/yasp);
      line(x1,y1,x01,y01);
      line(x1,y1,x2,y2);
      delay(6000);
      line(x1,y1,x01,y01);
      line(x1,y1,x2,y2);
      inc(r);
      if r=12*60 then r:=0
    end
  until keypressed;
  closeGraph
end.



