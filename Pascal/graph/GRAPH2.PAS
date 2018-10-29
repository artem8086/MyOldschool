uses Graph,Crt,dos;
label 3;
var f,g:file of byte;x,y,l:word;n,del:boolean;xm,ym,x1,y1:word;
    c:char;b,k,d:byte;GD,GM:integer;nf,a,home:longint;s:string;
procedure readmax;
begin
  read(f,b);x1:=b shl 4;
  read(f,b);x1:=x1+((b and $F0)shr 4);y1:=(b and $F)shl 8;
  read(f,b);y1:=y1+b
end;
procedure writemax;
begin
  b:=(x1 and $FF0)shr 4;write(g,b);
  b:=(x1 and $F)shl 4+(y1 and $F00)shr 8;write(g,b);
  b:=y1 and $FF;write(g,b)
end;
procedure open;
begin
  a:=0;reset(f);
  while not eof(f) do begin
    readmax;a:=a+1;
    if nf=a then for x:=0 to x1 do for y:=0 to y1 do begin xm:=x1;ym:=y1;read(f,b);putpixel(x,y,b) end
    else for x:=0 to x1 do for y:=0 to y1 do read(f,b);
  end;close(f);home:=nf;
end;
procedure save;
begin
  reset(f);rewrite(g);
  while not eof(f) do begin
    read(f,b);write(g,b) end;
  x1:=xm;y1:=ym;writemax;
  for x:=0 to xm do for y:=0 to ym do begin b:=getpixel(x,y);write(g,b) end;
  close(f);close(g);
  rewrite(f);reset(g);
  while not eof(g) do begin
    read(g,b);write(f,b) end;
  close(f);close(g);
  erase(g);
end;
procedure delet;
begin
  reset(f);rewrite(g);a:=0;
  while not eof(f) do begin
    readmax;a:=a+1;
    if a=nf then for x:=0 to x1 do for y:=0 to y1 do read(f,b) else begin
      writemax;for x:=0 to x1 do for y:=0 to y1 do begin read(f,b);write(g,b) end;
    end;
  end;
  close(f);close(g);
  rewrite(f);reset(g);
  while not eof(g) do begin
    read(g,b);write(f,b) end;
  close(f);close(g);
  erase(g);
end;
procedure endf;
begin
  reset(f);nf:=0;
  while not eof(f) do begin
    readmax;nf:=nf+1;
    for x:=0 to x1 do for y:=0 to y1 do read(f,b)
  end;
end;
procedure insert;
begin
  reset(f);rewrite(g);a:=0;
  while not eof(f) do begin
    a:=a+1;
    if a=nf then begin x1:=xm;y1:=ym;writemax;readmax;for x:=0 to x1 do for y:=0 to y1 do read(f,b);
      for x:=0 to xm do for y:=0 to ym do begin b:=getpixel(x,y);write(g,b) end end else begin
      readmax;writemax;for x:=0 to x1 do for y:=0 to y1 do begin read(f,b);write(g,b) end;
    end;
  end;
  close(f);close(g);
  rewrite(f);reset(g);
  while not eof(g) do begin
    read(g,b);write(f,b) end;
  close(f);close(g);
  erase(g);
end;
procedure insertf;
begin
  reset(f);rewrite(g);a:=0;
  while not eof(f) do begin
    a:=a+1;
    if a=nf then begin
      x1:=xm;y1:=ym;writemax;for x:=0 to xm do for y:=0 to ym do begin b:=getpixel(x,y);write(g,b) end end;
    readmax;writemax;for x:=0 to x1 do for y:=0 to y1 do begin read(f,b);write(g,b) end;
  end;if a=0 then begin
    x1:=xm;y1:=ym;writemax;for x:=0 to xm do for y:=0 to ym do begin b:=getpixel(x,y);write(g,b) end end;
  close(f);close(g);
  rewrite(f);reset(g);
  while not eof(g) do begin
    read(g,b);write(f,b) end;
  close(f);close(g);
  erase(g);
end;
begin{$S-}
  GD:=0;assign(g,'dopolnit.pcs');
  write('working file:');read(s);assign(f,s);

  InitGraph(GD,GM,'D:\TP7');home:=1;
  d:=100;k:=15;x:=0;y:=0;nf:=1;xm:=250;ym:=250;
  while 27<>ord(c) do begin
    SetColor(15);rectangle(-1,-1,xm+1,ym+1);
    str(xm,s);outtextxy(xm+2,ym+2,Concat(s,';'));b:=textwidth(concat(s,';'));str(ym,s);outtextxy(xm+2+b,ym+2,s);
    str(k,s);outtextxy(1,ym+2,concat('color:',s));
    str(nf,s);outtextxy(1,ym+2+textheight(s),concat('picture:',s));
    if keypressed then c:=readkey else c:=' ';
    case c of
      ' ':;
      '=':outtextxy(x,y,readkey);
      't':begin l:=0;c:=readkey;if ord(c)<>13 then repeat
	  outtextxy(x+l,y,c);l:=l+textwidth(c);c:=readkey
	until ord(c)=13 end;
      '-':putpixel(x,y,0);
      'r':begin del:=not del;repeat until not KeyPressed end;
      'w':y:=y-1;
      'a':x:=x-1;
      'x':y:=y+1;
      'd':x:=x+1;
      'i':insertf;
      '.':begin setcolor(0);str(k,s);outtextxy(1,ym+2,concat('color:',s));k:=k+1 end;
      ',':begin setcolor(0);str(k,s);outtextxy(1,ym+2,concat('color:',s));k:=k-1 end;
      'f':save;
      's':begin n:=not n;repeat until not KeyPressed end;
      'q':begin y:=y-1;x:=x-1 end;
      'z':begin x:=x-1;y:=y+1 end;
      'c':begin y:=y+1;x:=x+1 end;
      'e':begin y:=y-1;x:=x+1 end;
      'o':open;
      'n':if 'f'=readkey then begin
	rewrite(f);close(f) end else if 'c'=readkey then d:=100 else
	for x:=0 to xm do for y:=0 to ym do putpixel(x,y,0);
      '0'..'9':begin if d=0 then d:=100;
	setcolor(0);str(k,s);outtextxy(1,ym+2,concat('color:',s));
	if d=100 then k:=0;
	k:=(ord(c)-ord('0'))*d+k;d:=d div 10 end;
      else if 0=ord(c) then begin
	c:=readkey;setcolor(0);
	rectangle(-1,-1,xm+1,ym+1);
	str(k,s);outtextxy(1,ym+2,concat('color:',s));
	str(nf,s);outtextxy(1,ym+2+textheight(s),concat('picture:',s));
	str(xm,s);outtextxy(xm+2,ym+2,concat(s,';'));b:=textwidth(concat(s,';'));str(ym,s);outtextxy(xm+2+b,ym+2,s);
	case ord(c) of
	  72:ym:=ym-1;
	  75:xm:=xm-1;
	  80:ym:=ym+1;
	  77:xm:=xm+1;
	  83:delet;
	  79:endf;
	  71:nf:=home;
	  82:insert;
	  73:nf:=nf+1;
	  81:nf:=nf-1;
	  else break;
	end;
      end else break;
    end;
    if n then putpixel(x,y,k);
    if del then putpixel(x,y,0);
    if x>xm then X:=0;
    if y>ym then y:=0;
    PutPixel(x,y,not getpixel(x,y));
    for b:=1 to 15 do PutPixel(x,y+b,not getpixel(x,y+b));
    for b:=1 to 10 do PutPixel(x+b,y+b,not getpixel(x+b,y+b));
    for b:=7 to 11 do PutPixel(x+b,y+11,not getpixel(x+b,y+11));
    for b:=0 to 3 do begin
      PutPixel(x+b+4,y+b*2+12,not getpixel(x+b+4,y+b*2+12));
      PutPixel(x+b+4,y+b*2+13,not getpixel(x+b+4,y+b*2+13));
      PutPixel(x+b+7,y+b*2+12,not getpixel(x+b+7,y+b*2+12));
      PutPixel(x+b+7,y+b*2+13,not getpixel(x+b+7,y+b*2+13));
    end;for b:=1 to 3 do PutPixel(x+b,y-b+15,not getpixel(x+b,y-b+15));
    PutPixel(x+8,y+19,not getpixel(x+8,y+19));
    PutPixel(x+9,y+19,not getpixel(x+9,y+19));
    delay(25);PutPixel(x,y,not getpixel(x,y));
    for b:=1 to 15 do PutPixel(x,y+b,not getpixel(x,y+b));
    for b:=1 to 10 do PutPixel(x+b,y+b,not getpixel(x+b,y+b));
    for b:=7 to 11 do PutPixel(x+b,y+11,not getpixel(x+b,y+11));
    for b:=0 to 3 do begin
      PutPixel(x+b+4,y+b*2+12,not getpixel(x+b+4,y+b*2+12));
      PutPixel(x+b+4,y+b*2+13,not getpixel(x+b+4,y+b*2+13));
      PutPixel(x+b+7,y+b*2+12,not getpixel(x+b+7,y+b*2+12));
      PutPixel(x+b+7,y+b*2+13,not getpixel(x+b+7,y+b*2+13));
    end;for b:=1 to 3 do PutPixel(x+b,y-b+15,not getpixel(x+b,y-b+15));
    PutPixel(x+8,y+19,not getpixel(x+8,y+19));
    PutPixel(x+9,y+19,not getpixel(x+9,y+19));
  end;
end.