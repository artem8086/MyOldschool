uses Crt;
const F:array [1..12] of real=
  (130.8,138.6,146.8,155.6,164.8,
  174.6,185,196,207.7,220,
  233.1,246.9);
  temp=10000;
var k,n:integer;
begin
  for k:=0 to 3 do
    for n:=1 to 12 do begin
      sound(round(F[n]*(1 shl k)));
      delay(temp);
      NoSound end;
    for k:=3 downto 0 do
      for n:=12 downto 1 do begin
	sound(round(F[n]*(1 shl k)));
	delay(temp);
	NoSound end;
end.