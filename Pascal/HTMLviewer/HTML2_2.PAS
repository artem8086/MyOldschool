uses crt,dos;
label 0,1;
type atype=string;
var n,name,n2,cd:string;b,sp,x,y,x2,y2,ax,ay,str1,str2,sp2:byte;d,t:word;
  col:array[0..255]of byte;f:file of byte;fp,dp:longint;obj:text;
  font:array[0..255]of boolean;a,an,ahr,cdr,teg:boolean;s:string[5];ch:char;
procedure page;
begin
  asm
	mov	ah,5
	mov	al,str2
	int	$10
  end;
end;
procedure gotoxya(xcur,ycur:byte);
begin
  asm
	mov	ah,2
	mov	bh,str2
	mov	dh,ycur
	mov	dl,xcur
	int	$10
  end
end;
function ansi(c:byte):byte;
var cb:byte;
begin
  if c>127 then cb:=c-64 else cb:=c;
  if c>239 then cb:=c-16;ansi:=cb
end;
procedure incd;
begin
  if str1<8 then begin
  d:=d+1;x:=x+1;
  if x>79 then begin
    x:=0;y:=y+1 end;
  if y>24 then begin
    y:=0;str1:=str1+1;writeln(obj,'[PAGE]');d:=d+48 end
  end
end;
function poisk(st:atype):boolean;
begin
  t:=0;poisk:=true;
  repeat
    if eof(f) then begin poisk:=false;break end;
    if t=65535 then begin poisk:=false;break end;
    if t<>0 then begin read(f,b);
    if (b>96)and(b<123)then b:=b-32;
    if copy(st,t,1)<>chr(b) then t:=0 end;
    t:=t+1
  until t=length(st)+1
end;
function tegpoisk(st:atype):boolean;
begin
  t:=0;tegpoisk:=true;
  repeat
    if eof(f) then begin tegpoisk:=false;break end;
    if t=65535 then begin tegpoisk:=false;break end;
    if t<>0 then begin read(f,b);
    if b=62 then begin tegpoisk:=false;break end;
    if (b>96)and(b<123)then b:=b-32;
    if copy(st,t,1)<>chr(b) then t:=0 end;
    t:=t+1
  until t=length(st)+1;
end;
procedure print(cl:byte);
begin
  ax:=ax+1;if ax>79 then begin ax:=79;ay:=ay+1 end;
  if ay>24 then ay:=24;
  mem[$b800:d*2+1]:=col[sp];
  mem[$b800:d*2]:=cl;
  incd
end;
procedure println;
begin
  repeat
    print(0)
  until x=0
end;
procedure gtxy(xcur,ycur:byte);
begin
  d:=(79*48+48)*str1;
  x:=xcur;y:=ycur;
  d:=d+xcur+158*y
end;
procedure readhex;
var cl:byte;
begin
  read(f,cl);
  case chr(cl) of
    '0'..'9':b:=(cl-ord('0'))shl 4;
    'A'..'F':b:=(cl-ord('A')+10)shl 4;
    else exit
  end;
  read(f,cl);
  case chr(cl) of
    '0'..'9':b:=b+cl-ord('0');
    'A'..'F':b:=b+cl-ord('A')+10;
    else exit
  end
end;
procedure text(cl:byte);
begin
  sp:=sp+1;
  col[sp]:=col[sp-1]or cl
end;
procedure bgcolor(cl:byte);
begin
  sp:=sp+1;
  col[sp]:=col[sp-1]or(cl shl 4)
end;
function tegread:atype;
var st:string;
begin
  teg:=true;st:='';
  repeat
    read(f,b);if (b>96)and(b<123)then b:=b-32;
    if (b=61)or(b=32) then begin teg:=false;break end;
    if b<>62 then st:=st+chr(b)
  until b=62;tegread:=st
end;
function color:byte;
var st:string;cl:byte;sc:boolean;
begin
  read(f,b);if b=34 then begin sc:=true;read(f,b) end else sc:=false;
  if b=35 then begin
    cl:=0;readhex;if b>31 then cl:=4;
    readhex;if b>31 then cl:=cl or 2;
    readhex;if b>31 then cl:=cl or 1;
    color:=cl;if sc then read(f,b) end
  else begin repeat
    if (b>96)and(b<123)then b:=b-32;
    if (b=62)or(b=34) then break;
    if b<>32 then begin st:=st+chr(b);read(f,b) end;
  until b=32;
  if st='BLACK' then color:=0 else
  if st='BLUE' then color:=1 else
  if st='GREAN' then color:=2 else
  if st='CYAN' then color:=3 else
  if st='RED' then color:=4 else
  if st='MAGENTA' then color:=5 else
  if st='BROWN' then color:=6 else
  if st='WHITE' then color:=7 else color:=0
  end
end;
procedure writepic(pic:atype);
begin
  sp:=sp+1;col[sp]:=15;
  n:='[äÄêíàçäÄ] '+pic;
  repeat
    s:=copy(n,1,1);delete(n,1,1);
    print(mem[seg(s):ofs(s)+1])
  until length(n)=0;sp:=sp-1;print(32)
end;
procedure cdback;
begin
  repeat
    s:=copy(cd,length(cd),1);
    delete(cd,length(cd),1);
    if length(cd)=0 then break;
  until s='\';
end;
begin
  clrscr;assign(obj,'D:\TP7\OBJECT.OBJ');sp2:=0;
  if paramcount=1 then n:=paramstr(1) else begin
    write('Open file:');read(n);
    end;
  if 0=pos('.',n) then n:=n+'.htm';assign(f,n);
  0:n2:=fexpand(n);assign(f,n2);rewrite(obj);
  cd:=n2;cdback;chdir(cd);n:=cd;
  x:=0;str1:=0;y:=0;d:=0;textmode(3);col[0]:=$1F;
  reset(f);font[sp2]:=true;
  if not poisk('<TITLE>') then exit;
  repeat
    read(f,b);if b=$D then begin read(f,b);read(f,b) end;
    if b<>60 then print(ansi(b));
  until (b=60)or(x=78);println;
  if not poisk('/TITLE>') then exit;col[0]:=$14;
  d:=79;x:=79;y:=0;print(ord('X'));col[0]:=$70;
  if not poisk('<BODY') then exit;read(f,b);
  if b=32 then begin
    fp:=filepos(f);
    if tegpoisk('TEXT=') then col[0]:=col[0] or color;seek(f,fp);
    if tegpoisk('BGCOLOR=') then col[0]:=col[0] or(color shl 4);
    seek(f,fp);if not poisk('>') then exit; end;
  repeat
    println
  until str1=8;rewrite(obj);
  x:=0;str1:=0;y:=1;d:=80;an:=false;
  a:=false;name:='';n2:='';
  while not eof(f) do begin
    read(f,b);n:='';getdir(0,cd);if b=38 then begin
      repeat
	read(f,b);if (b>96)and(b<123)then b:=b-32;
	if b<>59 then n:=n+chr(b)
      until b=59;
      if n='NBSP' then println else
      if n='QUOT' then print(34) else
      if n='AMP' then print(38) else
      if n='ACUTE' then print(96) else
      if n='NOT' then print(28) else
      if n='PARA' then print(20) else
      if n='CURREN' then print(253) else
      if n='FRASL' then print(47) else
      if n='SECT' then print(21) else
      if n='CIRC' then print(94) else
      if n='BRVBAR' then print(ord('|')) else
      if n='TILDE' then print(126) else
      if (n='JT')or(n='LSAQUO') then print(60) else
      if (n='GT')or(n='RSAQUO') then print(62) else
      if n='EURO' then print(242) else
      if n='SBQUO' then print(44) else
      if n='DAGGER' then print(216) else
      if n='SHY' then print(45) else print(8)
    end else if b=60 then begin n:=tegread;
      if not teg then fp:=filepos(f);
      if n='LI' then begin
	println;for b:=0 to 2 do print(32);
	print(4) end else
      if n='HR' then begin
	if x<>0 then println;font[sp2+1]:=true;
	if not teg then if tegpoisk('COLOR=') then begin
	  text(color);font[sp2+1]:=false end;
	for b:=0 to 79 do print(196);
	if not font[sp2+2] then sp:=sp-1
      end else
      if n='IMG' then begin
	if tegpoisk('SRC=') then begin
	  read(f,b,b);cdr:=false;n:='';
	  while b=ord('.') do begin
	    if cdr then read(f,b,b,b) else read(f,b,b);
	    cdback;cdr:=true
	  end;if cdr then n:=cd+'\';
	  repeat
	    if b<>34 then n:=n+chr(ansi(b));read(f,b)
	  until b=34;n2:=fexpand(n);writepic(n2)
	end
      end else
      if n='A' then begin
	if tegpoisk('HREF="') then begin
	  a:=true;ahr:=true;ax:=x;ay:=y;
	  read(f,b);if b=35 then begin
	    write(obj,'NAME ',chr(x),chr(y),'"');
	    an:=true;repeat
	      read(f,b);if b<>34 then write(obj,chr(b))
	    until b=34;write(obj,'",')
	  end else begin
	    write(obj,'FILE ',chr(x),chr(y),'"');
	    cdr:=false;
	    while b=ord('.') do begin
	      if cdr then read(f,b,b,b) else read(f,b,b);
	      cdback;cdr:=true
	    end;if cdr then write(obj,cd,'\');
	    repeat
	      if b=47 then b:=92;
	      if b<>34 then write(obj,chr(ansi(b)));
	      read(f,b)
	    until b=34;write(obj,'"')
	  end end else begin seek(f,fp);
	if (tegpoisk('NAME="'))and(an) then begin
	  name:='';repeat
	    read(f,b);
	    if b<>34 then name:=name+chr(b);
	  until b=34;
	  if n2='' then break;
	  1:ahr:=false;
	  if n2<>name then if not poisk('</A>') then exit;
	  a:=false;if n2<>name then fp:=filepos(f)-1
	end end;seek(f,fp)
      end else
      if n='/A' then begin
	if ahr then writeln(obj,chr(ax),chr(ay));
	a:=false end else
      if (n='UL')or(n='/UL') then println else
      if n='SCRIPT' then begin
	if not poisk('</SCRIPT') then exit
      end else
      if n='BR' then println else
      if n='FONT' then begin
	if not teg then
	if tegpoisk('COLOR=') then begin
	  text(color);font[sp2]:=false;
	  sp2:=sp2+1 end else begin
	  font[sp2]:=true;sp2:=sp2+1 end
      end else
      if n='P' then begin
	if teg then begin
	  println;for b:=0 to 8 do print(32)
	end end else
      if n='/P' then println else
      if n='/BODY' then break else
      if n='/FONT' then begin
	sp2:=sp2-1;
	if not font[sp2] then sp:=sp-1;
      end;if not teg then begin
	seek(f,fp);if not poisk('>') then exit end
    end else if b<>$D then begin
      print(ansi(b));
    end else begin read(f,b);read(f,b);
    while b=32 do read(f,b);
    seek(f,filepos(f)-1) end;
    if str1>7 then break;
    if keypressed then if readkey=#8 then break
  end;repeat
    page;gotoxya(x2,y2);case readkey of
      #0:case ord(readkey) of
	73:if str2=0 then str2:=7 else str2:=str2-1;
	81:if str2=7 then str2:=0 else str2:=str2+1;
	72:if y2=0 then begin
	  if str2=0 then str2:=7 else str2:=str2-1;
	  y2:=24 end else y2:=y2-1;
	80:if y2=24 then begin
	  if str2=7 then str2:=0 else str2:=str2+1;
	  y2:=0 end else y2:=y2+1;
	75:if x2=0 then x2:=79 else x2:=x2-1;
	77:if x2=79 then x2:=0 else x2:=x2+1;
      end;
      #13:begin if (x2=79)and(y2=0)and(str2=0) then break;
	n2:='';append(obj);reset(obj);
	for b:=0 to str2 do while n2='[PAGE]' do
	  if not eof(obj) then readln(obj,n2);
	repeat
	  if eof(obj) then break;
	  read(obj,s);if s='FILE ' then begin
	    read(obj,ch);ax:=ord(ch);
	    read(obj,ch);ay:=ord(ch);
	    read(obj,ch);
	    if (ax<=x2)and(ay<=y2) then begin
	      n:='';repeat
		read(obj,ch);if ch<>'"' then n:=n+ch
	      until ch='"';
	      read(obj,ch);ax:=ord(ch);
	      readln(obj,ch);ay:=ord(ch);
	      if (ax>=x2)and(ay>=y2) then goto 0
	    end
	  end else if s='NAME ' then begin
	    read(obj,ch);ax:=ord(ch);
	    read(obj,ch);ay:=ord(ch);
	    read(obj,ch);
	    if (ax<=x2)and(ay<=y2) then begin
	      n2:='';repeat
		read(obj,ch);if ch<>'"' then n2:=n2+ch
	      until ch='"';
	      read(obj,ch);ax:=ord(ch);
	      readln(obj,ch);ay:=ord(ch);
	      if (ax>=x2)and(ay>=y2) then begin
		close(obj);append(obj);goto 1 end
	  end end else readln(obj)
	until s='[PAGE]';
      end;
      #27:break;
    end;
    while keypressed do if readkey=#27 then exit
  until str2>8
end.