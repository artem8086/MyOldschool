uses Crt;
label 1,2,3,4,5,6,7,8,9,10,11,12,16,17;
const min=-9999;max=9999;
type pos=record
  a:word
end;
var p:byte;k:integer;ml:array[min..max] of boolean;
    cr:byte;b,i,n:word;o,y:boolean;l:longint;f:file of pos;
    s:string;x:array[1..11] of string[36];c:char;t:array[1..9999] of pos;
procedure RS;
begin
  ClrScr;TextColor(6);TextBackground(0);
  write(#201);for n:=1 to 78 do write(#205);write(#187);
  write(#186);TextColor(15);write('Машина Поста 1.0':45);TextColor(6);write(#186:34);
  write(#199);for n:=1 to 78 do write(#196);write(#182);
  write(#186);TextColor(15);write('Координаты:':19,(k+cr):10);TextColor(6);write(#186:50,#186);
  TextColor(15);for n:=1 to 78 do if ml[k+n] then write(#219) else write(' ');
  TextColor(6);write(#186,#186);if cr>78 then begin k:=k+1;cr:=78 end;if k>max then k:=max;
  if cr<1 then begin k:=k-1;cr:=1 end;if k<min then k:=min;
  TextColor(4);write(#24:cr);TextColor(6);write(#186:(79-cr),#199);
  for n:=1 to 78 do write(#196);write(#186,#186);write(#218);
  for n:=1 to 37 do write(#196);write(#191,#218);for n:=1 to 37 do write(#196);write(#191,#186,#186,#179);
  TextColor(15);write('Программа:                        ':37);TextColor(6);write(#179,#179);
  TextColor(15);write(x[1]:37);TextColor(6);write(#179,#186,#186,#195);
  for n:=1 to 37 do write(#196);write(#180,#179);TextColor(15);write(x[2]:37);TextColor(6);write(#179,#186,#186,#179);
  for n:=3 to 10 do begin
    write(#179:38,#179);TextColor(15);write(x[n]:37);TextColor(6);write(#179,#186,#186,#179)
  end;write(#179:38,#179);TextColor(15);write(x[11]:37);TextColor(6);write(#179,#186,#186,#192);
  for n:=1 to 37 do write(#196);write(#217,#192);for n:=1 to 37 do write(#196);write(#217,#186,#199);
  for n:=1 to 78 do write(#196);write(#182,#186);TextColor(15);write(s:78);TextColor(6);write(#186,#200);
  for n:=1 to 78 do write(#205);write(#188);TextColor(15);writeln('Автор:Святоха Артём.');
  GotoXY(3,11);if b<1 then b:=1;if b>9999 then b:=9999;n:=0;
  for i:=1 to 9 do begin
    GotoXY(3,10+i-n);write(' ':36);GotoXY(3,10+i);
    case t[b+i-1-n].b of
      0:s:='Stop ';
      1:s:='=>';
      2:s:='<=';
      3:s:='V ';
      4:s:='X ';
      5:s:='?~';
      6:s:='? ';
      7:s:='- ';
      8:s:='^:';
    end;write(b+i-1-n,'.',s,t[b+i-1-n].a);
  end;
  TextBackground(1);TextColor(4);GotoXY(3,11);write(b,'.')
end;
function make(b:word):boolean;
label 13,14,15;
var bg:word;
begin
  bg:=b;make:=false;
  15:b:=bg;
  if cr>78 then begin k:=k+1;cr:=78 end;if k>max then k:=max;
  if cr<1 then begin k:=k-1;cr:=1 end;if k<min then k:=min;
  if bg<1 then bg:=1;if bg>9999 then bg:=9999;n:=t[bg].b;
  case n of
    0:begin b:=t[bg].a;goto 13 end;
    1:cr:=cr+1;
    2:cr:=cr-1;
    3:ml[k+cr]:=true;
    4:ml[k+cr]:=false;
    5:if ml[k+cr]=true then begin b:=b+1;goto 15 end;
    6:if ml[k+cr]=false then begin b:=b+1;goto 15 end;
    8:make(0);
    7:begin t[bg].a:=0;goto 15 end;
  end;
  if t[bg].a>max then t[b].a:=max;
  14:bg:=t[bg].a;if bg=0 then begin make:=true;goto 13;
  if y then begin Delay(l);s:=x[9];RS end else goto 15;
13:end;
begin
  cr:=39;k:=-39;p:=1;s:='Нажмите любую кнопку';b:=1;RS;y:=false;o:=false;
  for i:=1 to 9999 do begin t[i].a:=0;t[i].b:=7 end;
  for i:=0 to 19998 do ml[i-9999]:=false;
  x[1]:='Открыть программу                  ';x[2]:='Сохранить программу                ';
  x[3]:='Логическое перемещение             ';x[4]:='Запуск                             ';
  x[5]:='Перейти                            ';x[6]:='Продолжить                         ';
  x[7]:='Изменить ленту                     ';x[8]:='Изменить программу                 ';
  x[9]:='Медленное воспроизведение          ';x[11]:='Выход                              ';
  x[10]:='Очистить программу                 ';
  s:='Главное меню';
  RS;TextBackground(1);TextColor(4);GotoXY(42,8+p);write(x[p]:37);GotoXY(42,8+p);
  if ord(readkey)=0 then n:=ord(readkey) else n:=ord(readkey)+200;
  case n of
    72:p:=p-1;
    80:p:=p+1;
    213:case p of
      1:begin assign(f,'1.pos');Reset(f);for i:=1 to 9999 do read(f,t[i]);close(f) end;
      2:begin assign(f,'1.pos');Rewrite(f);for i:=1 to 9999 do write(f,t[i]);close(f) end;
      3:;
      4:begin y:=false;b:=1;repeat
	  o:=make(0);if o then b:=b+1;
	until not o end;
      5:begin
	s:=x[5];RS;repeat
	  if ord(readkey)=0 then n:=ord(readkey);
	  case n of
	    72:b:=b-1;
	    80:b:=b+1;
	  end;
	until (n=72)or(n=80);
      end;
      6:begin repeat
	  o:=make(0);if o then b:=b+1;
	until not o end;
      7:begin s:=x[7];
    repeat
      RS;if ord(readkey)=0 then n:=ord(readkey);
      case n of
	75:cr:=cr-1;
	77:cr:=cr+1;
	72:ml[k+cr]:=true;
	80:ml[k+cr]:=false;
	else n:=1;
      end;
    until n=1 end;
      8:begin s:=x[8];RS;b:=1;
  7:RS;
  if ord(readkey)=0 then n:=ord(readkey) else begin c:=readkey;n:=0 end;
  case n of
    72:begin b:=b-1;goto 7 end;
    80:begin b:=b+1;goto 7 end;
    0:;
    else goto 16;
  end;
  case c of
    's':begin s:='Stop ';t[b].b:=0 end;
    '.':begin s:='=>';t[b].b:=1 end;
    ',':begin s:='<=';t[b].b:=2 end;
    'v':begin s:='V ';t[b].b:=3 end;
    'x':begin s:='X ';t[b].b:=4 end;
    '`':begin s:='?~';t[b].b:=5 end;
    '/':begin s:='? ';t[b].b:=6 end;
    '-':begin t[b].b:=7;t[b].a:=0;goto 7 end;
    '6':begin s:='^:';t[b].b:=8 end;
    else goto 2;
  end;
  write(s);read(i);t[b].a:=i;goto 7; end;
      9:begin s:=':как медленно? ';RS;y:=true;GotoXY(2,22);read(l);goto 4 end;
      11:goto 3;
      for i:=1 to 9999 do begin t[i].a:=0;t[i].b:=7 end;
    end;
  end;
  if p<1 then p:=11;if p>11 then p:=1;
  goto 2;
  16:goto 2;
3:end.