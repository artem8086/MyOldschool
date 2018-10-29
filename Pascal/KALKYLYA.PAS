uses Crt;
label 1,2,3,4;
var c:char;v:string[20];n:byte;x,y:real;a:array [0..255] of real;
procedure screen;
begin
  ClrScr;GotoXY(0,0);TextBackground(7);
  TextColor(6);write(#201);
  for n:=1 to 78 do write(#205);write(#187);
  write(#186,'Электроника':45,#186:34);
  write(#186,x:45,#186:34);write(#186);
  TextColor(15);write('Вводите:':14);TextColor(6);
  write(#186:65);write(#186,v:45,#186:34);
  write(#200);for n:=1 to 78 do write(#205);write(#188);
  GotoXY(16,4);TextColor(4);
end;
begin
  x:=0;
  2:v:='Введите число Х';screen;
  read(x);
  1:v:='Введите функцию';screen;c:=readkey;
  if (c='+')or(c='-')or(c='*')or(c='/')or(c='i')or(c='o') then begin
  v:='Введите число У';screen;read(y);n:=round(y) end;
  case c of
    '=':goto 2;
    '+':x:=x+y;
    '-':x:=x-y;
    '*':x:=x*y;
    '/':if y<>0 then x:=x/y else goto 1;
    's':x:=sin(x);
    'c':x:=cos(x);
    's':if x>=0 then x:=sqrt(x) else goto 1;
    'i':a[n]:=x;
    'o':x:=a[n];
    'e':begin v:='До свиданья.';screen;repeat until KeyPressed;goto 3 end
    else goto 1;end;
  goto 1;
3:end.