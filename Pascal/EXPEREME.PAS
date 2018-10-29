uses Crt,Graph;
const n=4;
type pt=record
  x,y:integer
end;
var m:array [1..4] of pt;d,g:integer;
begin
  m[1].x:=21;m[1].y:=35;m[3].x:=213;m[3].y:=322;
  m[2].x:=123;m[2].y:=244;m[4].x:=21;m[4].y:=35;
  d:=11;g:=3;initGraph(d,g,'');
  repeat until keypressed
end.