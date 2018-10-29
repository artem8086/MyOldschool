uses crt;
type z=record
  a:array[1..80,1..24]of byte
end;
var s:string[5];zn:word;f:file of z;zon:z;x,y,x1,y1,b,c:byte;tab:boolean;
begin
  zn:=1;x:=1;y:=1;clrscr;tab:=true;
  gotoxy(1,25);
  write('Zone file:     1.zon');
  assign(f,'1.zon');
  repeat
    gotoxy(x,y);c:=0;
    b:=ord(readkey);
    if b=0 then case ord(readkey) of
      77:x:=x+1;
      80:y:=y+1;
      72:y:=y-1;
      75:x:=x-1;
      83:begin zon.a[x,y]:=0;write(' ') end;
      73:begin zn:=zn+1;
	str(zn,s);assign(f,s+'.zon');
	gotoxy(12,25);write(s:5) end;
      81:begin zn:=zn-1;if zn=0 then zn:=1;
	str(zn,s);assign(f,s+'.zon');
	gotoxy(12,25);write(s:5);
      end;
      104:begin reset(f);read(f,zon);close(f);
	for x1:=1 to 80 do for y1:=1 to 24 do begin
	  gotoxy(x1,y1);write(chr(zon.a[x1,y1])) end end;
      82:begin rewrite(f);write(f,zon);close(f) end;
    end else if tab then begin if b=9 then begin tab:=not tab;repeat until not keypressed end;
      zon.a[x,y]:=b;write(chr(b)) end else case chr(b) of
      '=','+':begin reset(f);read(f,zon);close(f);
	for x1:=1 to 80 do for y1:=1 to 24 do begin
	  gotoxy(x1,y1);write(chr(zon.a[x1,y1])) end end;
      '-','_':begin zon.a[x,y-1]:=0;write(' ') end;
      #9:begin tab:=not tab;repeat until not keypressed end;
      '0':begin zon.a[x,y]:=27;write(#27) end;
      '1':begin zon.a[x,y]:=1;write(#1) end;
      '2':begin zon.a[x,y]:=15;write(#15) end;
      '3':begin zon.a[x,y]:=16;write(#16) end;
      '4':begin zon.a[x,y]:=17;write(#17) end;
      '5':begin zon.a[x,y]:=30;write(#30) end;
      '6':begin zon.a[x,y]:=31;write(#31) end;
      '7':begin zon.a[x,y]:=2;write(#2) end;
      '8':begin zon.a[x,y]:=12;write(#12) end;
      '9':begin zon.a[x,y]:=43;write('+') end;
      'a'..'z':begin c:=176+(b-ord('a'));
	zon.a[x,y]:=c;write(chr(c)) end;
      'A'..'Z':begin c:=203+(b-ord('a'));
	zon.a[x,y]:=c;write(chr(c)) end;
    end;
    if x<1 then x:=1;
    if y<1 then y:=1;
    if x>80 then x:=80;
    if y>24 then y:=24;
  until b=27
end.