uses Graph,Crt,dos,graphics3D;
label 1,3;
var f,g,d2:file of byte;x,y,l,t:word;n1,del,ed,i:boolean;
    xm,ym,x1,y1,x2,y2,x3,y3,x4,y4,x5,y5:word;
    c,cc:char;b1,b2,k,d,p,h:byte;GD,GM:integer;nf,a1,home:longint;
    s,ss:string;s1,s4,s5:string[5];
function col(xc,yc:word;q:byte):byte;
begin
  if q and 1=1 then b2:=not b2;
  case (b2 and 6)shr 1 of
    0:col:=b2;
    1:col:=b2 or getpixel(xc,yc);
    2:col:=b2 and getpixel(xc,yc);
    3:col:=b2 xor getpixel(xc,yc);
  end;
end;
procedure readxy(xk,yk:word);
var e:byte;
begin
  reset(d2);b1:=0;
  seek(d2,xk*y5+yk);read(d2,b2);
  close(d2);
end;
procedure edit3D;
var xp,yp:integer;ch:char;
begin
  n:=20;a:=3;b:=3;setcolor(k);
  repeat
    if n=0 then n:=1;
    cleardevice;graph3d(0,0,func3D);
    ch:=readkey;case ch of
      ',','<':conx:=conx-0.1;
      '.','>':conx:=conx+0.1;
      '/','?':cony:=cony-0.1;
      '"',#39:cony:=cony+0.1;
      '_','-':fun:=fun-$40;
      '=','+':fun:=fun+$40;
      'w':b:=b-0.1;
      'x':b:=b+0.1;
      'd':a:=a+0.1;
      'a':a:=a-0.1;
      '4':xs:=xs-1;
      '6':xs:=xs+1;
      '8':ys:=ys-1;
      '2':ys:=ys+1;
      #9:fun:=fun+1;
      '7','1':begin xs:=xs-1;ys:=ys+1 end;
      '9','3':begin xs:=xs+1;ys:=ys-1 end;
      #0:case ord(readkey) of
	73:n:=n-1;
	81:n:=n+1;
	72:yp:=yp-5;
	80:yp:=yp+5;
	75:xp:=xp-5;
	77:xp:=xp+5;
	71:fun:=0;
	79:fun:=$1FF;
	82:fun:=fun+8;
	83:fun:=fun-8;
	15:fun:=fun-1;
      end end
  until ch=#13
end;
procedure edpic(h:byte);
var a,b1,s1,s2,t1,t2,x6,y6:word;
begin
  x5:=x3;y5:=y3;
  if x<x2 then begin x4:=x2;x3:=x end else begin x4:=x;x3:=x2 end;
  s1:=x3 div x5;x3:=x4-x3;
  if s1=0 then s1:=x5-x3 else if x5*s1<x3 then begin
    a:=s1+1;s1:=(x5*a)-(x3-(s1+1)*x5) end else begin
    a:=s1;s1:=(x5*a)-(x3-(s1)*x5) end;t1:=0;
  if y<y2 then begin y4:=y2;y3:=y end else begin y4:=y;y3:=y2 end;
  s2:=y3 div y5;y3:=y4-y3;
  if s2=0 then s2:=y5-y3 else if y5*s2<y3 then begin
    b1:=s2+1;s2:=(y5*b1)-(y3-(s2+1)*y5) end else begin
    b1:=s2;s2:=(y5*b1)-(y3-(s2)*y5) end;t2:=0;
  for x1:=0 to x5 do for x6:=0 to a do if t1=x1*a+x6 then t1:=t1+s1 else
    for y1:=0 to y5 do for y6:=0 to b1 do if t2=y1*b1+y6 then t2:=t2+s2 else begin
      readxy(x1,y1);putpixel(x1*a+x6+x3,y1*b1+y6+y3,col(x1*a+x6+x3,y1*b1+y6+y3,h)) end;
  x3:=x5;y3:=y5;
end;
procedure mice;
begin
  PutPixel(x,y,not getpixel(x,y));
  setwritemode(1);setcolor($FF);
  line(x,y+1,x,y+15);line(x+1,y+1,x+10,y+10);
  line(x+7,y+11,x+11,y+11);line(x+4,y+12,x+7,y+18);
  line(x+7,y+12,x+10,y+18);line(x+1,y+14,x+3,y+12);
  setwritemode(0);PutPixel(x+8,y+19,not getpixel(x+8,y+19));
  PutPixel(x+9,y+19,not getpixel(x+9,y+19))
end;
procedure readmax;
begin
  read(f,b1);x1:=b1 shl 4;
  read(f,b1);x1:=x1+((b1 and $F0)shr 4);y1:=(b1 and $F)shl 8;
  read(f,b1);y1:=y1+b1
end;
procedure writemax;
begin
  b1:=(x1 and $FF0)shr 4;write(g,b1);
  b1:=(x1 and $F)shl 4+(y1 and $F00)shr 8;write(g,b1);
  b1:=y1 and $FF;write(g,b1)
end;
procedure writemaxf;
begin
  b1:=(x1 and $FF0)shr 4;write(f,b1);
  b1:=(x1 and $F)shl 4+(y1 and $F00)shr 8;write(f,b1);
  b1:=y1 and $FF;write(f,b1)
end;
procedure open;
begin
  a1:=0;reset(f);for x:=0 to xm do for y:=0 to ym do putpixel(x,y,0);
  while not eof(f) do begin
    readmax;a1:=a1+1;
    if nf=a1 then for x:=0 to x1 do for y:=0 to y1 do begin xm:=x1;ym:=y1;read(f,b1);putpixel(x,y,b1) end
    else for x:=0 to x1 do for y:=0 to y1 do read(f,b1);
  end;close(f);home:=nf;
end;
procedure save;
begin
  reset(f);seek(f,filesize(f));
  x1:=xm;y1:=ym;writemaxf;
  for x:=0 to xm do for y:=0 to ym do begin b1:=getpixel(x,y);write(f,b1) end;
  close(f)
end;
procedure delet;
begin
  reset(f);rewrite(g);a1:=0;
  while not eof(f) do begin
    readmax;a1:=a1+1;
    if a1=nf then for x:=0 to x1 do for y:=0 to y1 do read(f,b1) else begin
      writemax;for x:=0 to x1 do for y:=0 to y1 do begin read(f,b1);write(g,b1) end;
    end;
  end;
  close(f);close(g);
  rewrite(f);reset(g);
  while not eof(g) do begin
    read(g,b1);write(f,b1) end;
  close(f);close(g);
  erase(g);
end;
procedure endf;
begin
  reset(f);nf:=0;
  while not eof(f) do begin
    readmax;nf:=nf+1;
    for x:=0 to x1 do for y:=0 to y1 do read(f,b1)
  end;
end;
procedure insert;
begin
  reset(f);rewrite(g);a1:=0;
  while not eof(f) do begin
    a1:=a1+1;
    if a1=nf then begin x1:=xm;y1:=ym;writemax;readmax;for x:=0 to x1 do for y:=0 to y1 do read(f,b1);
      for x:=0 to xm do for y:=0 to ym do begin b1:=getpixel(x,y);write(g,b1) end end else begin
      readmax;writemax;for x:=0 to x1 do for y:=0 to y1 do begin read(f,b1);write(g,b1) end;
    end;
  end;
  close(f);close(g);
  rewrite(f);reset(g);
  while not eof(g) do begin
    read(g,b1);write(f,b1) end;
  close(f);close(g);
  erase(g);
end;
procedure insertf;
begin
  reset(f);rewrite(g);a1:=0;
  while not eof(f) do begin
    a1:=a1+1;
    if a1=nf then begin
      x1:=xm;y1:=ym;writemax;for x:=0 to xm do for y:=0 to ym do begin b1:=getpixel(x,y);write(g,b1) end end;
    readmax;writemax;for x:=0 to x1 do for y:=0 to y1 do begin read(f,b1);write(g,b1) end;
  end;if a1=0 then begin
    x1:=xm;y1:=ym;writemax;for x:=0 to xm do for y:=0 to ym do begin b1:=getpixel(x,y);write(g,b1) end end;
  close(f);close(g);
  rewrite(f);reset(g);
  while not eof(g) do begin
    read(g,b1);write(f,b1) end;
  close(f);close(g);
  erase(g);
end;
begin{$S-}
  GD:=0;assign(g,'dopolnit.pcs');assign(d2,'dopolnit.pic');
  if 1=paramcount then begin s:=paramstr(1);goto 1 end;
  write('working file:');read(s);rewrite(d2);
  1:if 0=pos('.',s) then s:=s+'.pcs';assign(f,s);
  InitGraph(GD,GM,'');home:=1;mice;i:=false;
  d:=10;k:=15;x:=0;y:=0;nf:=1;xm:=250;ym:=250;h:=1;
  setcolor(15);setwritemode(0);rectangle(-1,-1,xm+1,ym+1);
  str(xm,s);outtextxy(xm+2,ym+2,s+';');
  b1:=textwidth(s+';');str(ym,s);outtextxy(xm+2+b1,ym+2,s);
  setcolor(k);str(k,s);outtextxy(1,ym+2,'color:'+s);setcolor(15);
  str(nf,s);outtextxy(1,ym+2+textheight('S'),'picture:'+s);
  str(x,s);str(y,s1);ed:=false;
  outtextxy(1,ym+2+textheight('S')*2,'PutPixel('+s+','+s1+')');
  while 27<>ord(c) do begin
    if keypressed then begin
      SetColor(0);setwritemode(0);
      str(xm,s);outtextxy(xm+2,ym+2,s+';');b1:=textwidth(s+';');str(ym,s);outtextxy(xm+2+b1,ym+2,s);
      str(k,s);outtextxy(1,ym+2,'color:'+s);
      b1:=textwidth('color:'+s);if n1 then outtextxy(1+b1,ym+2,' /S');
      b1:=b1+textwidth(' /S');if del then outtextxy(1+b1,ym+2,' /R');
      str(nf,s);outtextxy(1,ym+2+textheight('S'),'picture:'+s);
      str(x,s);str(y,s1);str(x2,s4);str(y2,s5);case p of
	0:outtextxy(1,ym+2+textheight('S')*2,'PutPixel('+s+','+s1+')');
	1:outtextxy(1,ym+2+textheight('S')*2,'Line('+s+','+s1+','+s4+','+s5+')');
	2:outtextxy(1,ym+2+textheight('S')*2,'Rectangle('+s+','+s1+','+s4+','+s5+')');
	3:outtextxy(1,ym+2+textheight('S')*2,'Circle('+s+','+s1+','+s4+')');
	4:outtextxy(1,ym+2+textheight('S')*2,'Ellipse('+s+','+s1+','+s4+','+s5+')');
      end;rectangle(-1,-1,xm+1,ym+1);setwritemode(1);setcolor($FF);
      setlinestyle(0,0,h);if not n1 then if not del then
      case p of
	 1:Line(x,y,x2,y2);
	 2:rectangle(x,y,x2,y2);
	 3:if not((n1)or(del)) then rectangle(x+x2,y+x2,x-x2,y-x2);
	 4:if not((n1)or(del)) then rectangle(x+x2,y+y2,x-x2,y-y2);
      end;setlinestyle(0,0,0);mice;i:=true;
      if ed then edit3D;ed:=false;c:=readkey end else c:=' ';
    case c of
      ' ':;
      #27:break;
      '=':outtextxy(x,y,readkey);
      'g':begin GM:=getpixel(x,y);GD:=0;
	repeat b1:=getpixel(x,y+GD);if GD+y>=ym then b1:=15;GD:=GD+1 until b1<>GM;
	setcolor(b1);rectangle(-1,-1,xm+1,ym+1);setfillstyle(1,k);floodfill(x,y,b1) end;
      't':begin l:=0;c:=readkey;if ord(c)<>13 then repeat
	  outtextxy(x+l,y,c);l:=l+textwidth(c);c:=readkey
	until ord(c)=13 end;
      '-':begin setcolor(0);case p of
	   0:putpixel(x,y,0);
	   1:Line(x,y,x2,y2);
	   2:rectangle(x,y,x2,y2);
	   3:if n1 or del then rectangle(x+x2,y+x2,x-x2,y-x2) else circle(x,y,x2);
	   4:if n1 or del then rectangle(x+x2,y+x2,x-x2,y-x2) else ellipse(x,y,0,359,x2,y2);
	end end;
      '+':begin setcolor(k);case p of
	   0:putpixel(x,y,k);
	   1:Line(x,y,x2,y2);
	   2:rectangle(x,y,x2,y2);
	   3:if n1 or del then rectangle(x+x2,y+x2,x-x2,y-x2) else circle(x,y,x2);
	   4:if n1 or del then rectangle(x+x2,y+x2,x-x2,y-x2) else ellipse(x,y,0,359,x2,y2);
	end end;
      'r':begin del:=not del;repeat until not KeyPressed end;
      #13:begin x2:=x;y2:=y end;
      'w':y:=y-1;
      'a':x:=x-1;
      'x':y:=y+1;
      'd':x:=x+1;
      'W':case p of
	0:y:=y-1;
	1,2,4:y2:=y2-1;
	4:x2:=x2-1;
      end;
      'A':case p of
	0:x:=x-1;
	1,2,3,4:x2:=x2-1;
      end;
      'X':case p of
	0:y:=y+1;
	1,2,4:y2:=y2+1;
	4:x2:=x2+1;
      end;
      'D':case p of
	0:x:=x+1;
	1,2,3,4:x2:=x2+1;
      end;
      #9:p:=p+1;
      'i':insertf;
      '.':k:=k+1;
      ',':k:=k-1;
      'f':save;
      'l':if h=1 then h:=3 else h:=1;
      'v':begin endf;a1:=nf;t:=65500;for nf:=1 to a1 do begin
	  open;if keypressed then cc:=readkey else cc:=' ';case c of
	    '.':t:=t+100;
	    ',':t:=t-100;
	    ' ':delay(t);
	    #13:repeat until not keypressed;
	    #0:begin b1:=ord(readkey);case b1 of
	      77:begin nf:=nf+1;b1:=79;open;repeat until not keypressed end;
	      75:begin nf:=nf-1;b1:=79;open;repeat until not keypressed end;
	  end end end;
	end end;
      's','S':begin n1:=not n1;repeat until not KeyPressed end;
      'm','M':for x1:=x to x2 do for y1:=y to y2 do putpixel(x1,y1,0);
      'q':begin y:=y-1;x:=x-1 end;
      'z':begin x:=x-1;y:=y+1 end;
      'c':begin y:=y+1;x:=x+1 end;
      'e':begin y:=y-1;x:=x+1 end;
      'P':p:=0;
      'O':begin x2:=0;y2:=0;p:=4 end;
      'K':begin x2:=0;p:=3 end;
      'L':begin x2:=x;y2:=y;p:=1 end;
      'R':begin x2:=x;y2:=y;p:=2 end;
      'Q':case p of
	0:begin y:=y-1;x:=x-1 end;
	1,2:begin y2:=y2-1;x2:=x2-1 end;
      end;
      'Z':case p of
	0:begin x:=x-1;y:=y+1 end;
	1,2:begin x2:=x2-1;y2:=y2+1 end;
      end;
      'C':case p of
	0:begin y:=y+1;x:=x+1 end;
	1,2:begin y2:=y2+1;x2:=x2+1 end;
      end;
      'E':case p of
	0:begin y:=y-1;x:=x+1 end;
	1,2:begin y2:=y2-1;x2:=x2+1 end;
      end;
      'o':open;
      'n':if 'f'=readkey then begin
	rewrite(f);close(f) end else if 'c'=readkey then d:=100 else
	for x:=0 to xm do for y:=0 to ym do putpixel(x,y,0);
      '0'..'9':begin if d=0 then d:=10;
	if d=10 then k:=0;
	k:=(ord(c)-ord('0'))*d+k;d:=d div 10;
      end;
      else if 0=ord(c) then begin
	c:=readkey;
	case ord(c) of
	  72:ym:=ym-1;
	  75:xm:=xm-1;
	  80:ym:=ym+1;
	  77:xm:=xm+1;
	  83:delet;
	  79:endf;
	  115:ed:=true;
	  104..112:edpic(ord(c)-104);
	  94..102:begin reset(d2);for x1:=0 to x3 do for y1:=0 to y3 do begin
	    read(d2,b2);if (x1+x<=xm)and(y1+y<=ym)then putpixel(x1+x,y1+y,col(x1+x,y1+y,ord(c)-94)) end;
	    close(d2) end;
	  71:nf:=home;
	  82:insert;
	  116:begin if x<x2 then begin x4:=x2;x3:=x end else begin x4:=x;x3:=x2 end;
	    if y<y2 then begin y4:=y2;y3:=y end else begin y4:=y;y3:=y2 end;
	    rewrite(d2);for x1:=x3 to x4 do for y1:=y3 to y4 do begin
	      b1:=getpixel(x1,y1);write(d2,b1) end;
	    close(d2);x3:=x4-x3;y3:=y4-y3 end;
	  73:nf:=nf+1;
	  81:nf:=nf-1;
	end;
      end;
    end;if i then begin
      if del then begin setwritemode(0);setcolor(0) end else
      if n1 then begin setwritemode(0);setcolor(k) end else begin setwritemode(1);setcolor($FF) end;
      if del then putpixel(x,y,0);
      if x>xm then x:=0;
      if y>ym then y:=0;
      if x2>xm then x2:=0;
      if y2>ym then y2:=0;
      if p>4 then p:=0;
      setlinestyle(0,0,h);
      case p of
	 0:begin if n1 then putpixel(x,y,k);
	   if del then putpixel(x,y,0) end;
	 1:Line(x,y,x2,y2);
	 2:rectangle(x,y,x2,y2);
	 3:if not((n1)or(del)) then rectangle(x+x2,y+x2,x-x2,y-x2) else circle(x,y,x2);
	 4:if not((n1)or(del)) then rectangle(x+x2,y+y2,x-x2,y-y2) else ellipse(x,y,0,359,x2,y2);
      end;setlinestyle(0,0,0);
      setcolor(15);setwritemode(0);rectangle(-1,-1,xm+1,ym+1);
      str(xm,s);outtextxy(xm+2,ym+2,s+';');
      b1:=textwidth(s+';');str(ym,s);outtextxy(xm+2+b1,ym+2,s);
      setcolor(k);str(k,s);outtextxy(1,ym+2,'color:'+s);setcolor(15);
      b1:=textwidth('color:'+s);if n1 then outtextxy(1+b1,ym+2,' /S');
      b1:=b1+textwidth(' /S');if del then outtextxy(1+b1,ym+2,' /R');
      str(nf,s);outtextxy(1,ym+2+textheight('S'),'picture:'+s);
      str(x,s);str(y,s1);str(x2,s4);str(y2,s5);case p of
	 0:outtextxy(1,ym+2+textheight('S')*2,'PutPixel('+s+','+s1+')');
	 1:outtextxy(1,ym+2+textheight('S')*2,'Line('+s+','+s1+','+s4+','+s5+')');
	 2:outtextxy(1,ym+2+textheight('S')*2,'Rectangle('+s+','+s1+','+s4+','+s5+')');
	 3:outtextxy(1,ym+2+textheight('S')*2,'Circle('+s+','+s1+','+s4+')');
	 4:outtextxy(1,ym+2+textheight('S')*2,'Ellipse('+s+','+s1+','+s4+','+s5+')');
      end;mice;i:=false end;
  end;erase(d2);
end.