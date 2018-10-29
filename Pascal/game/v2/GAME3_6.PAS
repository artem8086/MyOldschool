uses crt;
label 0,1,2,3,4,5,6,7;
type hlp=string[78];
type q=record
  a:array[0..81,0..25]of byte;
end;
type z=record
  a:array[1..80,1..24]of byte;
  x,y:byte;
end;
var sr:array[0..5]of string[20];s:hlp;srt:file of hlp;
  zn,p:word;f:file of z;zon:q;pic:file of byte;
  a,n,l,x,y,x1,y1,mj,maxj,bt,j,xl,yl,mm:byte;b:char;
  u:array[0..3]of boolean;x2,y2,xk,yk:shortint;
  t,w,h,o,m,ij,pv:boolean;lev:z;ms,st:word;
function open(x2,y2:byte):boolean;
begin
  reset(f);open:=true;
  while not eof(f) do begin
    read(f,lev);
    if (lev.x=x2)and(lev.y=y2) then begin
      open:=false;break end;
  end;
  close(f);
end;
procedure przon;
begin
  gotoxy(1,1);
  for y1:=1 to 24 do for x1:=1 to 80 do begin
    textcolor(14);case zon.a[x1,y1] of
      1,0:begin textcolor(0);write(' ');zon.a[x1,y1]:=0 end;
      2:begin textcolor(1);write(#2) end;
      35:begin textcolor(6);write(#35) end;
      15:begin textcolor(4);write(#15) end;
      12:begin textcolor(8);write(#12) end;
      21,5,23,16,17,30,31:begin textcolor(15);write(chr(zon.a[x1,y1])) end;
      18,14,3,43,27,28,29:begin textcolor(128+4);write(chr(zon.a[x1,y1])) end;
      32:zon.a[x,y]:=0;
      else write(chr(zon.a[x1,y1]));
    end end;while keypressed do if readkey=#27 then exit;
end;
procedure zonopen(h:byte);
begin
  case h of
    0:begin if open(xl+1,yl) then
      for x1:=1 to 80 do for y1:=1 to 24 do lev.a[x1,y1]:=0;
      if lev.a[1,y]=0 then begin
	xl:=xl+1;x:=1;for xk:=1 to 80 do begin
	  for x1:=1 to 80 do for y1:=1 to 24 do zon.a[x1-1,y1]:=zon.a[x1,y1];
	  for y1:=1 to 24 do zon.a[80,y1]:=lev.a[xk,y1];
	  przon;
      end;zon.a[x,y]:=1;textcolor(15);gotoxy(x,y);write(#1) end;
    end;
    1:begin if open(xl,yl+1) then
      for x1:=1 to 80 do for y1:=1 to 24 do lev.a[x1,y1]:=0;
      if lev.a[x,1]=0 then begin
	yl:=yl+1;y:=1;for yk:=1 to 24 do begin
	  for x1:=1 to 80 do for y1:=1 to 24 do zon.a[x1,y1-1]:=zon.a[x1,y1];
	  for x1:=1 to 80 do zon.a[x1,24]:=lev.a[x1,yk];
	  przon;
	end;zon.a[x,y]:=1;textcolor(15);gotoxy(x,y);write(#1) end;
    end;
    2:begin if open(xl-1,yl) then
      for x1:=1 to 80 do for y1:=1 to 24 do lev.a[x1,y1]:=0;
      if lev.a[80,y]=0 then begin
	xl:=xl-1;x:=80;for xk:=80 downto 1 do begin
	  for x1:=80 downto 1 do for y1:=1 to 24 do zon.a[x1+1,y1]:=zon.a[x1,y1];
	  for y1:=1 to 24 do zon.a[1,y1]:=lev.a[xk,y1];
	  przon;
	end;zon.a[x,y]:=1;textcolor(15);gotoxy(x,y);write(#1) end;
    end;
    3:begin if open(xl,yl-1) then
      for x1:=1 to 80 do for y1:=1 to 24 do lev.a[x1,y1]:=0;
      if lev.a[x,24]=0 then begin
	yl:=yl-1;y:=24;for yk:=24 downto 1 do begin
	  for x1:=1 to 80 do for y1:=24 downto 1 do zon.a[x1,y1+1]:=zon.a[x1,y1];
	  for x1:=1 to 80 do zon.a[x1,1]:=lev.a[x1,yk];
	  przon;
	end;zon.a[x,y]:=1;textcolor(15);gotoxy(x,y);write(#1) end;
    end;
  end;
end;
procedure delst;
begin
  if u[0] then begin gotoxy(x+1,y);write(' ');u[0]:=false end else
  if u[1] then begin gotoxy(x,y+1);write(' ');u[1]:=false end else
  if u[2] then begin gotoxy(x-1,y);write(' ');u[2]:=false end else
  if u[3] then begin gotoxy(x,y-1);write(' ');u[3]:=false end;
end;
function left:boolean;
label 2;
begin
  left:=false;
  case zon.a[x-1,y]of
    18,14,0,3,43,27,28,29,5,21:if x>1 then begin
      zon.a[x,y]:=0;gotoxy(x-1,y);write(#1,' ');x:=x-1;
      case zon.a[x,y] of
	43:l:=l+1;
	14:left:=true;
	18:m:=not m;
	3:l:=l+10;
	5:l:=l-1;
	29:st:=st+100;
	27:h:=true;
	28:o:=true;
	21:begin gotoxy(x,y);write(#21);zon.a[x,y]:=21;delst;
	  2:x:=random(79)+1;y:=random(23)+1;if zon.a[x,y]<>0 then goto 2;
	gotoxy(x,y);write(#1) end;
      end;zon.a[x,y]:=1;
    if (zon.a[x-1,y]=0)and(x>1) then u[2]:=true end else zonopen(2)
  end;
end;
function rigt:boolean;
label 2;
begin
  rigt:=false;
  case zon.a[x+1,y] of
    18,14,0,3,43,27,28,29,5,21:if x<80 then begin
      zon.a[x,y]:=0;gotoxy(x,y);write(' ',#1);x:=x+1;
      case zon.a[x,y] of
	3:l:=l+10;
	14:rigt:=true;
	18:m:=not m;
	43:l:=l+1;
	5:l:=l-1;
	29:st:=st+100;
	27:h:=true;
	28:o:=true;
	21:begin gotoxy(x,y);write(#21);zon.a[x,y]:=21;delst;
	  2:x:=random(79)+1;y:=random(23)+1;if zon.a[x,y]<>0 then goto 2;
	gotoxy(x,y);write(#1) end;
      end;zon.a[x,y]:=1;
    if (zon.a[x+1,y]=0)and(x<80) then u[0]:=true end else zonopen(0)
  end;
end;
function up:boolean;
label 2;
begin
  up:=false;
  case zon.a[x,y-1]of
    18,14,0,3,43,27,28,29,5,21:if y>1 then begin
      if (j=0)and(zon.a[x,y+1]<>0) then j:=1;
      zon.a[x,y]:=0;gotoxy(x,y);write(' ');y:=y-1;gotoxy(x,y);write(#1);
      case zon.a[x,y] of
	43:l:=l+1;
	14:up:=true;
	18:m:=not m;
	3:l:=l+10;
	5:l:=l-1;
	29:st:=st+100;
	27:h:=true;
	28:o:=true;
	21:begin gotoxy(x,y);write(#21);zon.a[x,y]:=21;delst;
	  2:x:=random(79)+1;y:=random(23)+1;if zon.a[x,y]<>0 then goto 2;
	gotoxy(x,y);write(#1) end;
      end;zon.a[x,y]:=1;
    if (zon.a[x,y-1]=0)and(y>1) then u[3]:=true end else zonopen(3)
  end;
end;
function down:boolean;
label 2;
begin
  down:=false;
  case zon.a[x,y+1]of
    18,14,0,3,43,27,28,29,5,21:if y<24 then begin j:=0;
      zon.a[x,y]:=0;gotoxy(x,y);write(' ');y:=y+1;gotoxy(x,y);write(#1);
      case zon.a[x,y] of
	21:begin gotoxy(x,y);write(#21);zon.a[x,y]:=21;delst;
	  2:x:=random(79)+1;y:=random(23)+1;if zon.a[x,y]<>0 then goto 2;
	gotoxy(x,y);write(#1) end;
	43:l:=l+1;
	14:down:=true;
	18:m:=not m;
	3:l:=l+10;
	5:l:=l-1;
	29:st:=st+100;
	27:h:=true;
	28:o:=true;
      end;zon.a[x,y]:=1;
    if (zon.a[x,y+1]=0)and(y<24) then u[1]:=true end else zonopen(1)
  end;
end;
procedure Laser;
label 1;
begin
  textcolor(4);if st<100 then goto 1;n:=0;
  if u[0] then begin st:=st-100;for x1:=x+1 to 80 do begin
    gotoxy(x1,y);case zon.a[x1,y] of
      0,2,15,12,5,30,31,16,17,18,3,43,27,28,29:begin zon.a[x1,y]:=0;write(#196) end;
      else begin n:=1;break end;
    end;delay(p div 10);
    end;for x1:=x1-n downto x+1 do begin
    gotoxy(x1,y);delay(p div 10);write(' ') end end else
  if u[1] then begin st:=st-100;for y1:=y+1 to 24 do begin
    gotoxy(x,y1);case zon.a[x,y1] of
      0,2,15,12,5,30,31,16,17,18,3,43,27,28,29:begin zon.a[x,y1]:=0;write(#179) end;
      else begin n:=1;break end;
    end;delay(p div 10);
    end;for y1:=y1-n downto y+1 do begin
    gotoxy(x,y1);delay(p div 10);write(' ') end end else
  if u[2] then begin st:=st-100;for x1:=x-1 downto 1 do begin
    gotoxy(x1,y);case zon.a[x1,y] of
      0,2,15,12,5,30,31,16,17,18,3,43,27,28,29:begin zon.a[x1,y]:=0;write(#196) end;
      else begin n:=1;break end;
    end;delay(p div 10);
    end;for x1:=x1+n to x-1 do begin
    gotoxy(x1,y);delay(p div 10);write(' ') end end else
  if u[3] then begin st:=st-100;for y1:=y-1 downto 1 do begin
    gotoxy(x,y1);case zon.a[x,y1] of
      0,2,15,12,5,30,31,16,17,18,3,43,27,28,29:begin zon.a[x,y1]:=0;write(#179) end;
      else begin n:=1;break end;
    end;delay(p div 10);
    end;for y1:=y1+n to y-1 do begin
    gotoxy(x,y1);delay(p div 10);write(' ') end end;
  1:while keypressed do if readkey=#27 then exit;
end;
procedure readmax;
begin
  read(pic,bt);x1:=bt shl 4;
  read(pic,bt);x1:=x1+((bt and $F0)shr 4);
  read(pic,y1);
end;
begin
  t:=false;assign(srt,'game.hlp');reset(srt);
  3:textbackground(2);textcolor(15);
  clrscr;x:=0;y:=0;
  sr[0]:='>Новая игра';
  sr[1]:='Продолжить...';
  sr[2]:='Сложность<0>';
  sr[3]:='Справка <F1>';
  sr[4]:='Выход <ESC>';
  assign(pic,'game.pcs');
  write(#218);reset(pic);readmax;close(pic);
  for bt:=2 to 79 do write(#196);
  write(#191);
  for bt:=2 to 23 do begin
    gotoxy(1,bt-26);write(#179);
    gotoxy(80,wherey);write(#179) end;
  write(#192);for bt:=2 to 79 do write(#196);
  write(#217,'Автор:Святоха Артём.');goto 2;
  0:window(2,2,79,23);textbackground(2);
  clrscr;ms:=0;seek(srt,0);y:=1;
  for x:=0 to 21 do begin
    s:='';if not eof(srt) then read(srt,s);
    gotoxy(1,1+x);write(s) end;
    repeat
      gotoxy(y,1);b:=readkey;case b of
      #27:exit;
      #0:case ord(readkey) of
	  80:if ms<filesize(srt) then begin
	    ms:=ms+1;seek(srt,ms);clrscr;
	    for x:=0 to 21 do begin
	      s:='';if not eof(srt) then read(srt,s);
	      gotoxy(1,1+x);write(s) end;
	  end;
	  72:if ms>0 then begin
	    ms:=ms-1;gotoxy(1,1);insline;
	    gotoxy(1,1);seek(srt,ms);
	    if not eof(srt) then read(srt,s);
	    write(s) end;
	  77:if y>79 then y:=1 else y:=y+1;
	  75:if y<1 then y:=79 else y:=y-1;
	end;
      end;
    until b=#13;clrscr;
  window(1,1,80,25);
  2:reset(pic);seek(pic,2);
  for x:=0 to x1 do for y:=0 to y1 do begin
    read(pic,bt);bt:=bt and 15;
    textcolor(bt);gotoxy(x+2,y+2);
    if bt<>0 then write(#219) end;
  close(pic);textcolor(15);
  for bt:=0 to 4 do begin
    gotoxy(9,19+bt);write(sr[bt]) end;
  bt:=0;a:=0;p:=0;repeat
    textbackground(2);gotoxy(9,19+bt);
    write(sr[bt]);bt:=a;
    textbackground(1);gotoxy(9,19+a);
    write(sr[a]);gotoxy(19,21);textbackground(2);if p=10 then p:=0;
    if p>9 then p:=9;write(p);gotoxy(9,19+a);b:=readkey;
    case b of
      #27:exit;
      #13:begin if a=4 then exit;if a=3 then goto 0;
	if (a=1)and(not t) then a:=0;if (a=1)and(t) then goto 7 end;
      '0'..'9':if a=2 then p:=ord(b)-ord('0');
      #0:case ord(readkey) of
	72:if a=0 then a:=4 else a:=a-1;
	80:if a=4 then a:=0 else a:=a+1;
	75:if a=2 then p:=p-1;
	77:if a=2 then p:=p+1;
	59:goto 0;
      end;
    end;
  until (a=0)and(b=#13);
  zn:=0;st:=1000;l:=100;p:=1000*(10-p);
  1:zn:=zn+1;h:=false;maxj:=5;
  mj:=maxj;pv:=true;mm:=1;t:=true;
  7:textbackground(0);clrscr;delst;
  str(zn,s);assign(f,s+'.lev');
  {$I-}reset(f);close(f);{$I+}
  if ioresult<>0 then begin
    write('Вы выграли!');delay($FFFF);textcolor(128+15);gotoxy(1,25);b:=#27;
    write('Нажмите любую кнопку...');repeat until keypressed;
    t:=false;goto 3;
  end;t:=true;m:=false;
  o:=false;s:='';w:=false;
  reset(f);read(f,lev);close(f);xl:=lev.x;yl:=lev.y;
  for x1:=1 to 80 do for y1:=1 to 24 do zon.a[x1,y1]:=lev.a[x1,y1];
  for x1:=1 to 80 do for y1:=1 to 24 do begin
    textcolor(14);gotoxy(x1,y1);case zon.a[x1,y1] of
      1:begin x:=x1;y:=y1 end;
      32:zon.a[x1,y1]:=0;
      35:begin textcolor(6);write(#35) end;
      5,18,14,2,15,12,16,17,30,31,43,27,28,3,29,23,21:;
      else write(chr(zon.a[x1,y1]));
    end end;
  textcolor(128+15);write('Нажмите любую кнопку...');
  repeat until keypressed;
  for x1:=1 to 80 do for y1:=1 to 24 do begin
    gotoxy(x1,y1);case zon.a[x1,y1] of
      0:;
      2:begin textcolor(1);write(#2) end;
      15:begin textcolor(4);write(#15) end;
      21,5,23,16,17,30,31:begin textcolor(15);write(chr(zon.a[x1,y1])) end;
      12:begin textcolor(8);write(#12) end;
      18,3,14,43,27,28,29:begin textcolor(128+4);write(chr(zon.a[x1,y1])) end;
      32:zon.a[x,y]:=0;
      1:if (x1<>x)or(y1<>y)then zon.a[x,y]:=0;
    end end;textcolor(15);gotoxy(x,y);
  write(#1);gotoxy(1,25);
  write(' Жизней:      ; стрел :      ');
  repeat
    if keypressed then begin
      b:=readkey;textcolor(15);case b of
	'6':if (u[0]=false)and(zon.a[x+1,y]=0)and(j=0)and(x<81) then begin delst;u[0]:=true;goto 6 end;
	'2':if (u[1]=false)and(zon.a[x,y+1]=0)and(y<25) then begin delst;u[1]:=true;goto 6 end;
	'4':if (u[2]=false)and(zon.a[x-1,y]=0)and(j=0)and(x>0) then begin delst;u[2]:=true;goto 6 end;
	'8':if (u[3]=false)and(zon.a[x,y-1]=0)and(y>0) then begin delst;u[3]:=true;goto 6 end;
      end;case b of
	' ','5':if st>0 then
	if u[0] then begin st:=st-1;zon.a[x+1,y]:=16;gotoxy(x+1,y);write(#16) end else
	if u[1] then begin st:=st-1;zon.a[x,y+1]:=31;gotoxy(x,y+1);write(#31) end else
	if u[2] then begin st:=st-1;zon.a[x-1,y]:=17;gotoxy(x-1,y);write(#17) end else
	if u[3] then begin st:=st-1;zon.a[x,y-1]:=30;gotoxy(x,y-1);write(#30) end;
	'+':laser;
	#8:goto 3;
	#13:begin textcolor(128+15);gotoxy(1,25);
	  write('Нажмите любую кнопку...      ');repeat until keypressed;
	  gotoxy(1,25);textcolor(15);write(' Жизней:      ; стрел :      ');
	end;
	'4','8','6','2','9','7','1','3':delst;
      end;case b of
	#27,' ',#13,'5','0',#8,'+':j:=0;
	'6':if rigt then goto 1;
	'2':if down then goto 1;
	'4':if left then goto 1;
	'8':if up then goto 1;
	'9':begin if up then goto 1;delst;
	  if rigt then goto 1 end;
	'7':begin if up then goto 1;delst;
	  if left then goto 1 end;
	'1':begin if down then goto 1;delst;if left then goto 1 end;
	'3':begin if down then goto 1;delst;if rigt then goto 1 end;
	else begin gotoxy(x,y);write('?') end;
      end;
      6:case b of
	'4','8','2','6','9','7','1','3':if u[0] then begin gotoxy(x+1,y);write(#16) end else
	  if u[1] then begin gotoxy(x,y+1);write(#31) end else
	  if u[2] then begin gotoxy(x-1,y);write(#17) end else
	  if u[3] then begin gotoxy(x,y-1);write(#30) end;
	'0':if u[0] then begin st:=st-1;zon.a[x+1,y]:=5;gotoxy(x+1,y);write(#5);u[0]:=false end else
	if u[1] then begin st:=st-1;zon.a[x,y+1]:=5;gotoxy(x,y+1);write(#5);u[1]:=false end else
	if u[2] then begin st:=st-1;zon.a[x-1,y]:=5;gotoxy(x-1,y);write(#5);u[2]:=false end else
	if u[3] then begin st:=st-1;zon.a[x,y-1]:=5;gotoxy(x,y-1);write(#5);u[3]:=false end;
      end end else j:=0;textcolor(15);
    4:if zon.a[x,y+1]=23 then mj:=20;if j>=mj then begin j:=0;mj:=maxj end;
    if (not m)and(j=0) then begin case zon.a[x,y+1] of
	18,14,0,3,43,27,28,29,5,21:begin delst;if down then goto 1;
	  if ((b='8')or(b='9')or(b='7')) then begin
	    delst;if down then goto 1 end end;
      end end;for x1:=1 to 80 do for y1:=1 to 24 do begin
      textcolor(15);case zon.a[x1,y1] of
	1:if (x<>x1)and(y<>y1) then begin zon.a[x1,y1]:=0;gotoxy(x1,y1);write(' ') end;
	17:case zon.a[x1-1,y1] of
	  0:if x1>1 then begin gotoxy(x1-1,y1);write(#17,' ');zon.a[x1-1,y1]:=17;zon.a[x1,y1]:=0;
	    if h then begin for y2:=y1 downto 1 do
	      if (zon.a[x1-1,y2]=2)or(zon.a[x1-1,y2]=12)or(zon.a[x1-1,y2]=15) then zon.a[x1-1,y1]:=30;
	      for y2:=y1 to 24 do
	      if (zon.a[x1-1,y2]=2)or(zon.a[x1-1,y2]=12)or(zon.a[x1-1,y2]=15) then zon.a[x1-1,y1]:=31;
	      end end else begin gotoxy(x1,y1);write(' ');zon.a[x1,y1]:=0;
		if h then begin for y2:=y1 downto 1 do
		  if (zon.a[x1-1,y2]=2)or(zon.a[x1-1,y2]=12)or(zon.a[x1-1,y2]=15) then zon.a[x1-1,y1]:=30;
		  for y2:=y1 to 24 do
		  if (zon.a[x1-1,y2]=2)or(zon.a[x1-1,y2]=12)or(zon.a[x1-1,y2]=15) then zon.a[x1-1,y1]:=31;
		end  end;
	  35:begin x2:=-1;zon.a[x1,y1]:=0;
	    gotoxy(x1,y1);write(' ');
	    repeat
	    x2:=x2-1;if x2+x1>80 then break;
	    if zon.a[x1+x2,y1]<>35 then case zon.a[x1+x2,y1] of
	      0:zon.a[x1+x2,y1]:=17;
	      2,15,12,5:begin zon.a[x1+x2,y1]:=0;
		gotoxy(x1+x2,y1);write(' ') end;
	      1:begin textcolor(4);gotoxy(x,y);
		write(#1);l:=l-1 end;
	    end;
	  until zon.a[x1+x2,y1]<>35 end;
	  1:begin textcolor(4);gotoxy(x,y);write(#1,' ');l:=l-1;zon.a[x1,y1]:=0 end;
	  2,15,12,5:begin gotoxy(x1-1,y1);write('  ');zon.a[x1,y1]:=0;zon.a[x1-1,y1]:=0 end;
	  else begin gotoxy(x1,y1);write(' ');zon.a[x1,y1]:=0;
	    if o then begin if zon.a[x1,y1-1]=0 then zon.a[x1,y1]:=30;
	      if zon.a[x1+1,y1]=0 then zon.a[x1,y1]:=16;
	      if zon.a[x1,y1+1]=0 then zon.a[x1,y1]:=31;
	      if zon.a[x1-1,y1]=0 then zon.a[x1,y1]:=17;
	    end end;
	end;
	30:case zon.a[x1,y1-1] of
	  0:if y1>1 then begin gotoxy(x1,y1);write(' ');
	    gotoxy(x1,y1-1);write(#30);zon.a[x1,y1]:=0;zon.a[x1,y1-1]:=30;
	    if h then begin for x2:=x1 downto 1 do
	      if (zon.a[x2,y1-1]=2)or(zon.a[x2,y1-1]=12)or(zon.a[x2,y1-1]=15) then zon.a[x1,y1-1]:=17;
	      for x2:=x1 to 80 do
	      if (zon.a[x2,y1-1]=2)or(zon.a[x2,y1-1]=12)or(zon.a[x2,y1-1]=15) then zon.a[x1,y1-1]:=16;
	      end end else begin gotoxy(x1,y1);write(' ');zon.a[x1,y1]:=0;
		if h then begin for x2:=x1 downto 1 do
		  if (zon.a[x2,y1-1]=2)or(zon.a[x2,y1-1]=12)or(zon.a[x2,y1-1]=15) then zon.a[x1,y1-1]:=17;
		  for x2:=x1 to 80 do
		  if (zon.a[x2,y1-1]=2)or(zon.a[x2,y1-1]=12)or(zon.a[x2,y1-1]=15) then zon.a[x1,y1-1]:=16;
		end end;
	  35:begin x2:=-1;zon.a[x1,y1]:=0;
	    gotoxy(x1,y1);write(' ');
	    repeat
	    x2:=x2-1;if x2+y1>24 then break;
	    if zon.a[x1,y1+x2]<>35 then case zon.a[x1,y1+x2] of
	      0:zon.a[x1,y1+x2]:=30;
	      2,15,12,5:begin zon.a[x1,y1+x2]:=0;
		gotoxy(x1,y1+x2);write(' ') end;
	      1:begin textcolor(4);gotoxy(x,y);
		write(#1);l:=l-1 end;
	    end;
	  until zon.a[x1+x2,y1]<>35 end;
	  1:begin textcolor(4);gotoxy(x1,y1);write(' ');gotoxy(x1,y1-1);
	    write(#1);l:=l-1;zon.a[x1,y1]:=0 end;
	  2,15,12,5:begin gotoxy(x1,y1);write(' ');gotoxy(x1,y1-1);
	    write(' ');zon.a[x1,y1-1]:=0;zon.a[x1,y1]:=0 end;
	  else begin gotoxy(x1,y1);write(' ');zon.a[x1,y1]:=0;
	    if o then begin if zon.a[x1,y1-1]=0 then zon.a[x1,y1]:=30;
	      if zon.a[x1+1,y1]=0 then zon.a[x1,y1]:=16;
	      if zon.a[x1,y1+1]=0 then zon.a[x1,y1]:=31;
	      if zon.a[x1-1,y1]=0 then zon.a[x1,y1]:=17;
	    end end;
	end;
	15:if (zon.a[x1+1,y1]=1)or(zon.a[x1-1,y1]=1)or(zon.a[x1,y1+1]=1)or(zon.a[x1,y1-1]=1) then begin
	    textcolor(4);gotoxy(x1,y1);write(#15);
	    gotoxy(x,y);write(#1);l:=l-1 end else begin
	    textcolor(4);gotoxy(x1,y1);write(' ');zon.a[x1,y1]:=0;
	    if (zon.a[x1+1,y1]=0)and(4=random(9))and(x1<80) then begin
	      gotoxy(x1+1,y1);write(#15);zon.a[x1+1,y1]:=15 end else
	    if (zon.a[x1-1,y1]=0)and(3=random(9))and(x1>1) then begin
	      gotoxy(x1-1,y1);write(#15);zon.a[x1-1,y1]:=15 end else
	    if (zon.a[x1,y1+1]=0)and(8=random(9))and(y1<24) then begin
	      gotoxy(x1,y1+1);write(#15);zon.a[x1,y1+1]:=15 end else
	    if (zon.a[x1,y1-1]=0)and(5=random(9))and(y1>1) then begin
	      gotoxy(x1,y1-1);write(#15);zon.a[x1,y1-1]:=15 end else begin
	      gotoxy(x1,y1);write(#15);zon.a[x1,y1]:=15 end;
	end;
	2:if (zon.a[x1+1,y1]=1)or(zon.a[x1-1,y1]=1)or(zon.a[x1,y1+1]=1)or(zon.a[x1,y1-1]=1)then begin
	  textcolor(9);gotoxy(x1,y1);write(#2);
	  textcolor(4);gotoxy(x,y);write(#1);l:=l-1 end else begin
	  textcolor(9);gotoxy(x1,y1);write(' ');zon.a[x1,y1]:=0;
	  x2:=(abs(x-x1+1)-abs(x-x1-1))div 2;y2:=(abs(y-y1+1)-abs(y-y1-1))div 2;
	 if (x2+x1>0)and(x1+x2<81)and(y1+y2>0)and(y1+y2<25) then if zon.a[x1+x2,y1+y2]=0 then begin
	    gotoxy(x1+x2,y1+y2);write(#2);zon.a[x1+x2,y1+y2]:=2 end else begin
	    gotoxy(x1,y1);write(#2);zon.a[x1,y1]:=2
	  end else begin
	    gotoxy(x1,y1);write(#2);zon.a[x1,y1]:=2
	  end
	end;
	12:if (zon.a[x1+1,y1]=1)or(zon.a[x1-1,y1]=1)or(zon.a[x1,y1+1]=1)or(zon.a[x1,y1-1]=1)then begin
	    textcolor(8);gotoxy(x1,y1);write(#12);
	    textcolor(4);gotoxy(x,y);write(#1);l:=l-1 end else begin
	    textcolor(8);gotoxy(x1,y1);write(' ');zon.a[x1,y1]:=0;
	    if zon.a[x1,y1-1]=0 then if x=x1 then zon.a[x1,y1-1]:=30;
	    if zon.a[x1,y1+1]=0 then if x=x1 then zon.a[x1,y1+1]:=31;
	    if zon.a[x1-1,y1]=0 then if y=y1 then zon.a[x1-1,y1]:=17;
	    if zon.a[x1+1,y1]=0 then if y=y1 then zon.a[x1+1,y1]:=16;
	    if (zon.a[x1+1,y1]=0)and(4=random(9))and(x1<80) then begin
	      gotoxy(x1+1,y1);write(#12);zon.a[x1+1,y1]:=12 end else
	    if (zon.a[x1-1,y1]=0)and(3=random(9))and(x1>1) then begin
	      gotoxy(x1-1,y1);write(#12);zon.a[x1-1,y1]:=12 end else
	    if (zon.a[x1,y1+1]=0)and(8=random(9))and(y1<24) then begin
	      gotoxy(x1,y1+1);write(#12);zon.a[x1,y1+1]:=12 end else
	    if (zon.a[x1,y1-1]=0)and(5=random(9))and(y1>1) then begin
	      gotoxy(x1,y1-1);write(#12);zon.a[x1,y1-1]:=12 end else begin
	      gotoxy(x1,y1);write(#12);zon.a[x1,y1]:=12 end end;
      end;
    end;while keypressed do if readkey=#27 then exit;
    for x1:=80 downto 1 do for y1:=24 downto 1 do begin
      case zon.a[x1,y1] of
	1:if (x1<>x)and(y1<>y) then zon.a[x1,y1]:=0;
	5:begin for xk:=-mm to mm do for yk:=-mm to mm do case zon.a[x1+xk,y1+yk] of
	    2,15,12:begin textcolor(4);zon.a[x1+xk,y1+yk]:=0;gotoxy(x1+xk,y1+yk);write(' ');
	      zon.a[x1,y1]:=0;gotoxy(x1,y1);write(' ');
	    end end;
	end;
	16:begin textcolor(15);case zon.a[x1+1,y1] of
	  0:if x1<80 then begin gotoxy(x1,y1);write(' ',#16);zon.a[x1+1,y1]:=16;zon.a[x1,y1]:=0;
	  if h then begin for y2:=y1 downto 1 do
	      if (zon.a[x1+1,y2]=2)or(zon.a[x1+1,y2]=12)or(zon.a[x1+1,y2]=15) then zon.a[x1+1,y1]:=30;
	      for y2:=y1 to 24 do
	      if (zon.a[x1+1,y2]=2)or(zon.a[x1+1,y2]=12)or(zon.a[x1+1,y2]=15) then zon.a[x1+1,y1]:=31;
	      end end else begin gotoxy(x1,y1);write(' ');zon.a[x1,y1]:=0;
		if h then begin for y2:=y1 downto 1 do
		  if (zon.a[x1+1,y2]=2)or(zon.a[x1+1,y2]=12)or(zon.a[x1+1,y2]=15) then zon.a[x1+1,y1]:=30;
		   for y2:=y1 to 24 do
		   if (zon.a[x1+1,y2]=2)or(zon.a[x1+1,y2]=12)or(zon.a[x1+1,y2]=15) then zon.a[x1+1,y1]:=31;
		end end;
	  35:begin x2:=1;zon.a[x1,y1]:=0;
	    gotoxy(x1,y1);write(' ');
	    repeat
	    x2:=x2+1;if x2+x1>80 then break;
	    if zon.a[x1+x2,y1]<>35 then case zon.a[x1+x2,y1] of
	      0:zon.a[x1+x2,y1]:=16;
	      2,15,12,5:begin zon.a[x1+x2,y1]:=0;
		gotoxy(x1+x2,y1);write(' ') end;
	      1:begin textcolor(4);gotoxy(x,y);
		write(#1);l:=l-1 end;
	    end;
	  until zon.a[x1+x2,y1]<>35 end;
	  1:begin textcolor(4);gotoxy(x-1,y);write(' ',#1);l:=l-1;zon.a[x1,y1]:=0 end;
	  2,15,12,5:begin gotoxy(x1,y1);write('  ');zon.a[x1,y1]:=0;zon.a[x1+1,y1]:=0 end;
	  else begin gotoxy(x1,y1);write(' ');zon.a[x1,y1]:=0;
	    if o then begin if zon.a[x1,y1-1]=0 then zon.a[x1,y1]:=30;
	      if zon.a[x1+1,y1]=0 then zon.a[x1,y1]:=16;
	      if zon.a[x1,y1+1]=0 then zon.a[x1,y1]:=31;
	      if zon.a[x1-1,y1]=0 then zon.a[x1,y1]:=17;
	    end end;
	end end;
	31:begin textcolor(15);case zon.a[x1,y1+1] of
	  0:if y1<24 then begin gotoxy(x1,y1);write(' ');
	      gotoxy(x1,y1+1);write(#31);zon.a[x1,y1+1]:=31;zon.a[x1,y1]:=0;
	      if h then begin for x2:=x1 downto 1 do
		if (zon.a[x2,y1+1]=2)or(zon.a[x2,y1+1]=12)or(zon.a[x2,y1+1]=15) then zon.a[x1,y1+1]:=17;
		for x2:=x1 to 80 do
		if (zon.a[x2,y1+1]=2)or(zon.a[x2,y1+1]=12)or(zon.a[x2,y1+1]=15) then zon.a[x1,y1+1]:=16;
	      end end else begin gotoxy(x1,y1);write(' ');zon.a[x1,y1]:=0;
		if h then begin for x2:=x1 downto 1 do
		  if (zon.a[x2,y1+1]=2)or(zon.a[x2,y1+1]=12)or(zon.a[x2,y1+1]=15) then zon.a[x1,y1+1]:=17;
		  for x2:=x1 to 80 do
		  if (zon.a[x2,y1+1]=2)or(zon.a[x2,y1+1]=12)or(zon.a[x2,y1+1]=15) then zon.a[x1,y1+1]:=16;
		end end;
	  35:begin x2:=1;zon.a[x1,y1]:=0;
	    gotoxy(x1,y1);write(' ');
	    repeat
	    x2:=x2+1;if x2+y1>24 then break;
	    if zon.a[x1,y1+x2]<>35 then case zon.a[x1,y1+x2] of
	      0:zon.a[x1,y1+x2]:=31;
	      2,15,12,5:begin zon.a[x1,y1+x2]:=0;
		gotoxy(x1,y1+x2);write(' ') end;
	      1:begin textcolor(4);gotoxy(x,y);
		write(#1);l:=l-1 end;
	    end;
	  until zon.a[x1+x2,y1]<>35 end;
	  1:begin textcolor(4);gotoxy(x1,y1);write(' ');
	    gotoxy(x1,y1+1);write(#1);l:=l-1;zon.a[x1,y1]:=0 end;
	  2,15,12,5:begin gotoxy(x1,y1);write(' ');gotoxy(x1,y1+1);
	    write(' ');zon.a[x1,y1+1]:=0;zon.a[x1,y1]:=0 end;
	  else begin gotoxy(x1,y1);write(' ');zon.a[x1,y1]:=0;
	    if o then begin if zon.a[x1,y1-1]=0 then zon.a[x1,y1]:=30;
	      if zon.a[x1+1,y1]=0 then zon.a[x1,y1]:=16;
	      if zon.a[x1,y1+1]=0 then zon.a[x1,y1]:=31;
	      if zon.a[x1-1,y1]=0 then zon.a[x1,y1]:=17;
	    end end;
	  end end;
      end;if (not m)and pv then case zon.a[x1,y1] of
	  2,5,15,12:if zon.a[x1,y1+1]=0 then begin
	    if y1=24 then begin zon.a[x1,y1]:=0;gotoxy(x1,y1);
	    write(' ') end else begin
	    zon.a[x1,y1+1]:=zon.a[x1,y1];zon.a[x1,y1]:=0;gotoxy(x1,y1);
	    write(' ');gotoxy(x1,y1+1);case zon.a[x1,y1+1] of
	      2:begin textcolor(1);write(#2);
	      if zon.a[x1,y1+2]=0 then begin
	    zon.a[x1,y1+2]:=zon.a[x1,y1+1];zon.a[x1,y1+1]:=0;gotoxy(x1,y1+1);
	    write(' ');gotoxy(x1,y1+2);textcolor(1);write(#2) end; end;
	      15:begin textcolor(4);write(#15) end;
	      12:begin textcolor(8);write(#12) end;
	      5:begin textcolor(15);write(#5) end;
	    end end;
	end end;
    end;while keypressed do if readkey=#27 then exit;
    delay(p);textcolor(15);if (l>a)and(l<250) then a:=l;
    if w then l:=a else a:=l;if l>254 then l:=254;
    if j>0 then j:=j+1;
    gotoxy(10,25);write(l:3);gotoxy(25,25);write(st:5);
    if (l=0)or(l>250) then begin clrscr;gotoxy(1,1);
      write('Вы проиграли!');delay($FFFF);textcolor(128+15);gotoxy(1,25);
      write('Нажмите любую кнопку...');repeat until keypressed;t:=false;goto 3
    end;
  until b=#27;
end.