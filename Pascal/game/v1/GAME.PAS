uses crt;
label 1;
type z=record
  a:array[1..80,1..24]of byte
end;
var s:string[5];zn,p:word;f:file of z;zon:z;l,x,y,x1,y1,v,b,c:byte;
  u:array[0..3]of boolean;x2,y2:shortint;h:boolean;
begin
  clrscr;l:=100;zn:=0;
  writeln('Игра!');writeln;
  write('Сложность:');read(p);
  {p:=not p;}clrscr;
  1:gotoxy(1,1);zn:=zn+1;v:=0;
  for b:=0 to 3 do u[b]:=false;
  str(zn,s);assign(f,s+'.zon');
  reset(f);read(f,zon);close(f);
  for x1:=1 to 80 do for y1:=1 to 24 do begin
    textcolor(14);gotoxy(x1,y1);case zon.a[x1,y1] of
      1,32:zon.a[x1,y1]:=0;
      2,15,12:v:=v+1;
      16,17,30,31,43,27:;
      else write(chr(zon.a[x1,y1]));
    end end;
  textcolor(128+15);write('Нажмите любую кнопку...     ');
  repeat until keypressed;
  for x1:=1 to 80 do for y1:=1 to 24 do begin
    gotoxy(x1,y1);case zon.a[x1,y1] of
      0:;
      2:begin textcolor(1);write(#2) end;
      15:begin textcolor(4);write(#15) end;
      16,17,30,31:begin textcolor(15);write(chr(zon.a[x1,y1])) end;
      12:begin textcolor(8);write(#12) end;
      43:begin textcolor(128+4);write(#43) end;
      27:begin textcolor(128+4);write(#27) end;
      32:zon.a[x,y]:=0;
      else zon.a[x1,y1]:=10;
    end end;x:=10;y:=10;zon.a[x,y]:=1;
  gotoxy(1,25);textcolor(15);
  write(' Жизней:      ; врагов:      ');
  textcolor(15);h:=false;
  repeat
    if keypressed then begin b:=ord(readkey);
      if b=0 then c:=ord(readkey) else c:=0;
      case b of
	0,27:;
	32:if u[0] then begin case zon.a[x+1,y] of
	    2,12,15:v:=v-1;
	  end;zon.a[x+1,y]:=16 end else
	  if u[1] then begin case zon.a[x,y+1] of
	    2,12,15:v:=v-1;
	  end;zon.a[x,y+1]:=31 end else
	  if u[2] then begin case zon.a[x-1,y] of
	    2,12,15:v:=v-1;
	  end;zon.a[x-1,y]:=17 end else
	  if u[3] then begin case zon.a[x,y-1] of
	    2,12,15:v:=v-1;
	  end;zon.a[x,y-1]:=30 end;
	13:begin textcolor(128+15);gotoxy(1,25);
	  write('Нажмите любую кнопку...      ');repeat until keypressed;
	  gotoxy(1,25);textcolor(15);write(' Жизней:      ; врагов:      ');
	end;
	else begin textcolor(15);gotoxy(x,y);write('?') end;
      end;textcolor(15);
      case c of
	77,80,72,75:begin
	  if u[0] then begin gotoxy(x+1,y);write(' ');u[0]:=false end else
	  if u[1] then begin gotoxy(x,y+1);write(' ');u[1]:=false end else
	  if u[2] then begin gotoxy(x-1,y);write(' ');u[2]:=false end else
	  if u[3] then begin gotoxy(x,y-1);write(' ');u[3]:=false end;
	end;
      end;case c of
	0:;
	77:if (zon.a[x+1,y]=0)or(zon.a[x+1,y]=43)or(zon.a[x+1,y]=27) then if x<80 then begin
	  zon.a[x,y]:=0;gotoxy(x,y);write(' ',#1);x:=x+1;
	  if zon.a[x,y]=43 then l:=l+1;if zon.a[x,y]=27 then h:=true;zon.a[x,y]:=1;
	  if (zon.a[x+1,y]=0)and(x<80) then u[0]:=true end;
	80:if (zon.a[x,y+1]=0)or(zon.a[x,y+1]=43)or(zon.a[x,y+1]=27) then if y<24 then begin
	  zon.a[x,y]:=0;gotoxy(x,y);write(' ');y:=y+1;gotoxy(x,y);write(#1);
	  if zon.a[x,y]=43 then l:=l+1;if zon.a[x,y]=27 then h:=true;zon.a[x,y]:=1;
	  if (zon.a[x,y+1]=0)and(y<24) then u[1]:=true end;
	75:if (zon.a[x-1,y]=0)or(zon.a[x-1,y]=43)or(zon.a[x-1,y]=27) then if x>1 then begin
	  zon.a[x,y]:=0;gotoxy(x-1,y);write(#1,' ');x:=x-1;
	  if zon.a[x,y]=43 then l:=l+1;if zon.a[x,y]=27 then h:=true;zon.a[x,y]:=1;
	  if (zon.a[x-1,y]=0)and(x>1) then u[2]:=true end;
	72:if (zon.a[x,y-1]=0)or(zon.a[x,y-1]=43)or(zon.a[x,y-1]=27) then if y>1 then begin
	  zon.a[x,y]:=0;gotoxy(x,y);write(' ');y:=y-1;gotoxy(x,y);write(#1);
	  if zon.a[x,y]=43 then l:=l+1;if zon.a[x,y]=27 then h:=true;zon.a[x,y]:=1;
	  if (zon.a[x,y-1]=0)and(y>1) then u[3]:=true end;
	else begin gotoxy(x,y);write('?') end;
      end;case c of
	77,80,72,75:if u[0] then begin gotoxy(x+1,y);write(#16) end else
	  if u[1] then begin gotoxy(x,y+1);write(#31) end else
	  if u[2] then begin gotoxy(x-1,y);write(#17) end else
	  if u[3] then begin gotoxy(x,y-1);write(#30) end;
      end;
    end;for x1:=1 to 80 do for y1:=1 to 24 do begin
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
	  1:begin textcolor(4);gotoxy(x1,y1);write(' ',#1);l:=l-1;zon.a[x1,y1]:=0 end;
	  2,15,12:begin gotoxy(x1-1,y1);write('  ');v:=v-1;zon.a[x1,y1]:=0;zon.a[x1-1,y1]:=0 end;
	  else begin gotoxy(x1,y1);write(' ');zon.a[x1,y1]:=0 end;
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
	  1:begin textcolor(4);gotoxy(x1,y1);write(' ');gotoxy(x1,y1-1);write(#1);l:=l-1;zon.a[x1,y1]:=0 end;
	  2,15,12:begin gotoxy(x1,y1);write(' ');gotoxy(x1,y1-1);
	    write(' ');v:=v-1;zon.a[x1,y1-1]:=0;zon.a[x1,y1]:=0 end;
	  else begin gotoxy(x1,y1);write(' ');zon.a[x1,y1]:=0 end;
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
	 if (x2+x1>1)and(x1+x2<80)and(y1+y2>1)and(y1+y2<24) then if zon.a[x1+x2,y1+y2]=0 then begin
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
	    if zon.a[x1,y1-1]<>10 then if x=x1 then begin
	      case zon.a[x1,y1-1] of
		2,15,12:v:=v-1;
		1:l:=l-1;
	      end;zon.a[x1,y1-1]:=30 end;
	    if zon.a[x1,y1+1]<>10 then if x=x1 then begin
	      case zon.a[x1,y1+1] of
		1:l:=l-1;
		2,15,12:v:=v-1;
	      end;zon.a[x1,y1+1]:=31 end;
	    if zon.a[x1-1,y1]<>10 then if y=y1 then begin
	      case zon.a[x1-1,y1] of
		1:l:=l-1;
		2,15,12:v:=v-1;
	      end;zon.a[x1-1,y1]:=17 end;
	    if zon.a[x1+1,y1]<>10 then if y=y1 then begin
	      case zon.a[x1+1,y1] of
		1:l:=l-1;
		2,15,12:v:=v-1;
	      end;zon.a[x1+1,y1]:=16 end;
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
    end;for x1:=80 downto 1 do for y1:=24 downto 1 do begin
      case zon.a[x1,y1] of
	1:if (x1<>x)and(y1<>y) then zon.a[x1,y1]:=0;
	16:case zon.a[x1+1,y1] of
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
	  1:begin textcolor(4);gotoxy(x1-1,y1);write(#1,' ');l:=l-1;zon.a[x1,y1]:=0 end;
	  2,15,12:begin gotoxy(x1,y1);write('  ');v:=v-1;zon.a[x1,y1]:=0;zon.a[x1+1,y1]:=0 end;
	  else begin gotoxy(x1,y1);write(' ');zon.a[x1,y1]:=0 end;
	end;
	31:case zon.a[x1,y1+1] of
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
	  1:begin textcolor(4);gotoxy(x1,y1);write(' ');
	    gotoxy(x1,y1+1);write(#1);l:=l-1;zon.a[x1,y1]:=0 end;
	  2,15,12:begin gotoxy(x1,y1);write(' ');gotoxy(x1,y1+1);
	    write(' ');v:=v-1;zon.a[x1,y1+1]:=0;zon.a[x1,y1]:=0 end;
	  else begin gotoxy(x1,y1);write(' ');zon.a[x1,y1]:=0 end;
	end;
      end;
    end;delay(p);textcolor(15);
    gotoxy(10,25);write(l:3);gotoxy(25,25);write(v:3);
    if v=0 then goto 1;if l=0 then b:=27;
  until b=27;
end.