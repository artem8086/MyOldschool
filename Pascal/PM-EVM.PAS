uses crt;
label 1,2,3,4,5,6,7;
const s:array[1..16]of char=('0','1','2','3','4','5','6','7','C','M','И','П',' ',' ',' ',' ');
var r:array[0..7]of byte;f:file of byte;m:array[0..64511]of byte;
  pc,rsp,n,w:word;a,c,b,g,r1,r2,t:byte;
begin
  assign(f,'MONITOR.ROM');
  pc:=0;rsp:=0;textbackground(0);clrscr;
  reset(f);for n:=0 to 64511 do begin
    read(f,b);m[n]:=b end;close(f);
  window(1,1,34,14);textbackground(2);textcolor(14);
  write(#201);for b:=0 to 31 do write(#205);write(#187);
  for b:=0 to 9 do write(#186,#186:33);
  write(#200);for b:=0 to 31 do write(#205);write(#188);
  textcolor(15);write('Автор:Святоха А.');
  gotoxy(12,2);write('ПМ-ЭВМ');
  gotoxy(2,3);writeln(#218,#196,#194,#196,#194,#196,#194,#196,#191);
  for b:=0 to 3 do begin gotoxy(2,b*2+4);
    writeln(#179,s[b*4+1],#179,s[b*4+2],#179,s[b*4+3],#179,s[b*4+4],#179);
    gotoxy(2,b*2+5);writeln(#195,#196,#197,#196,#197,#196,#197,#196,#180);
  end;gotoxy(2,11);write(#192,#196,#193,#196,#193,#196,#193,#196,#217);
  gotoxy(15,4);write('Порт 0:');gotoxy(15,6);write('Порт 1:');gotoxy(15,8);write('Порт 2:');
  textbackground(0);textcolor(15);
  1:if (t mod 10)=0 then begin
    gotoxy(23,4);write(m[0]shr 6,' ',(m[0]shr 3)and 3,' ',m[0]and 3);
    gotoxy(23,6);write(m[1]shr 6,' ',(m[1]shr 3)and 3,' ',m[1]and 3);
    gotoxy(23,8);write(m[2]shr 6,' ',(m[2]shr 3)and 3,' ',m[2]and 3);
  end;if 0=c then if keypressed then c:=ord(readkey);case c of
    120..123:if (m[3]and (1 shl(c-120)))<>0 then m[4]:=1;
    16..20:if (m[3]and (1 shl(c-20)))<>0 then m[4]:=2;
    30..33:if (m[3]and (1 shl(c-30)))<>0 then m[4]:=4;
    44..48:if (m[3]and (1 shl(c-44)))<>0 then m[4]:=8;
    79:pc:=0;
  end;if pc>64511 then pc:=0;b:=m[pc];
  gotoxy(15,10);write(pc);
  r1:=b and 3;r2:=(b and $38)shr 3;
  case b of
    0:;
    $C3:begin
      5:pc:=m[pc+2]*$FF+m[pc+1]-1 end;
    $76:repeat until keypressed;
    $CD:begin
      6:m[rsp-1]:=(pc and $FF00)shr 8;m[rsp-2]:=pc and $FF;rsp:=rsp-2;goto 5 end;
    $C9:begin
      7:pc:=m[rsp]+m[rsp+1]*$FF;rsp:=rsp+2;goto 2 end;
    $F9:rsp:=r[5]*$FF+r[4];
    $E9:pc:=r[5]*$FF+r[4];
    $2F:r[7]:=not r[7];
    $27:begin a:=r[7];asm
	mov	al,a
	daa
	mov	a,al
      end;r[7]:=a end;
    $37:r[6]:=r[6] or 1;
    $E3:begin a:=r[4];r[4]:=m[rsp+1];m[rsp+1]:=a;a:=r[5];r[5]:=m[rsp];m[rsp]:=a end;
    $3F:r[6]:=r[6] or((not (r[6] and 1))and 1);
    $DB:begin r[7]:=m[m[pc+1]];pc:=pc+1 end;
    $D3:begin m[m[pc+1]]:=r[7];pc:=pc+1 end;
    $07:begin
      g:=r[6];a:=r[7];asm
	mov	ah,g
	sahf
	rol	a,1
	lahf
	mov	g,ah
	end;r[6]:=g;r[7]:=a;
      end;
    $0F:begin
      g:=r[6];a:=r[7];asm
	mov	ah,g
	sahf
	ror	a,1
	lahf
	mov	g,ah
	end;r[6]:=g;r[7]:=a;
      end;
    $17:begin
      g:=r[6];a:=r[7];asm
	mov	ah,g
	sahf
	rcl	a,1
	lahf
	mov	g,ah
	end;r[6]:=g;r[7]:=a;
      end;
    $C6:begin g:=r[6];a:=m[pc+1];c:=r[7];asm
	mov	ah,g
	sahf
	mov	ah,a
	add	c,ah
	lahf
	mov	g,ah
	end;r[6]:=g;r[7]:=c;pc:=pc+1;
      end;
    $CE:begin g:=r[6];a:=m[pc+1];c:=r[7];asm
	mov	ah,g
	sahf
	mov	ah,a
	adc	c,ah
	lahf
	mov	b,ah
	end;r[6]:=g;r[7]:=c;pc:=pc+1;
      end;
    $D6:begin g:=r[6];a:=m[pc+1];c:=r[7];asm
	mov	ah,b
	sahf
	mov	ah,a
	sub	c,ah
	lahf
	mov	g,ah
	end;r[6]:=g;r[7]:=c;pc:=pc+1;
      end;
    $DE:begin g:=r[6];a:=m[pc+1];c:=r[7];asm
	mov	ah,g
	sahf
	mov	ah,a
	sbb	c,ah
	lahf
	mov	g,ah
	end;r[6]:=g;r[7]:=c;pc:=pc+1;
      end;
    $EE:begin g:=r[6];a:=m[pc+1];c:=r[7];asm
	mov	ah,g
	sahf
	mov	ah,a
	xor	c,ah
	lahf
	mov	g,ah
	end;r[6]:=g;r[7]:=c;pc:=pc+1;
      end;
    $E6:begin g:=r[6];a:=m[pc+1];c:=r[7];asm
	mov	ah,g
	sahf
	mov	ah,a
	and	c,ah
	lahf
	mov	g,ah
	end;r[6]:=g;r[7]:=c;pc:=pc+1;
      end;
    $F6:begin g:=r[6];a:=m[pc+1];c:=r[7];asm
	mov	ah,g
	sahf
	mov	ah,a
	or	c,ah
	lahf
	mov	g,ah
	end;r[6]:=g;r[7]:=c;pc:=pc+1;
      end;
    $FE:begin g:=r[6];a:=m[pc+1];c:=r[7];asm
	mov	ah,g
	sahf
	mov	ah,a
	cmp	c,ah
	lahf
	mov	g,ah
	end;r[6]:=g;r[7]:=c;pc:=pc+1;
      end;
    $1F:begin
      g:=r[6];a:=r[7];asm
	mov	ah,g
	sahf
	rcr	a,1
	lahf
	mov	g,ah
	end;r[6]:=g;r[7]:=a;
      end;
    $32:begin m[m[pc+2]*$FF+m[pc+1]]:=r[7];pc:=pc+2 end;
    $3A:begin r[7]:=m[m[pc+2]*$FF+m[pc+1]];pc:=pc+2 end;
    $22:begin m[m[pc+2]*$FF+m[pc+1]]:=r[4];m[m[pc+2]*$FF+m[pc+1]+1]:=r[5];pc:=pc+2 end;
    $2A:begin r[4]:=m[m[pc+2]*$FF+m[pc+1]];r[5]:=m[m[pc+2]*$FF+m[pc+1]+1];pc:=pc+2 end;
    $EB:begin a:=r[4];r[4]:=r[2];r[2]:=a;a:=r[5];r[5]:=r[3];r[3]:=a end;
  else goto 3;
  end;goto  2;
  3:case (b and $C0)shr 6 of
    0:begin
      if (b and $2F)=2 then m[r[r2]+r[r2+1]*$FF]:=r[7];
      if (b and $2F)=$A then r[7]:=m[r[r2-1]+r[r2]*$FF];
      if (b and $F)=9 then if r2=7 then begin
	n:=r[4]*$FF+r[5];g:=r[6];asm
	mov	ah,g
	sahf
	mov	ax,n
	add	rsp,ax
	lahf
	mov	g,ah
	end;r[6]:=g end else begin
	n:=r[4]*$FF+r[5];w:=r[r2-1]*$FF+r[r2];g:=r[6];asm
	mov	ah,g
	sahf
	mov	ax,w
	add	n,ax
	lahf
	mov	g,ah
	end;r[6]:=g end;
      if (b and $F)=1 then begin
	if r2=6 then rsp:=m[pc+2]*$FF+m[pc+1] else begin
	  r[r2]:=m[pc+1];r[r2+1]:=m[pc+2] end;
	pc:=pc+2 end;
      if r1=6 then begin
	if r2=6 then m[r[r2+1]*$FF+r[r2]]:=m[pc+1] else r[r2]:=m[pc+1];
	pc:=pc+1 end;
      if 4=r1 then if r2=6 then begin g:=r[6];a:=m[r[5]*256+r[4]];asm
	mov	ah,g
	sahf
	inc	a
	lahf
	mov	g,ah
	end;r[6]:=g;m[r[5]*256+r[4]]:=a;goto 2;
      end else begin g:=r[6];a:=r[r2];asm
	mov	ah,g
	sahf
	inc	a
	lahf
	mov	g,ah
	end;r[6]:=g;r[r2]:=a;goto 2;
      end;
      if 5=r1 then if r2=6 then begin g:=r[6];a:=m[r[5]*256+r[4]];asm
	mov	ah,g
	sahf
	dec	a
	lahf
	mov	g,ah
	end;r[6]:=g;m[r[5]*256+r[4]]:=a;;goto 2;
      end else begin g:=r[6];a:=r[r2];asm
	mov	ah,g
	sahf
	dec     a
	lahf
	mov	g,ah
	end;r[r2]:=g;r[6]:=b;goto 2;
      end;
      if 3=(b and $F) then if r2=6 then begin g:=r[6];asm
	mov	ah,g
	sahf
	inc	rsp
	lahf
	mov	g,ah
	end;r[6]:=g;goto 2;
      end else begin g:=r[6];n:=m[r[r2+1]]*256+m[r[r2]];asm
	mov	ah,g
	sahf
	inc	n
	lahf
	mov	g,ah
	end;r[r2]:=g;m[r[r2+1]]:=(n and $FF00)shr 8;m[r[r2]]:=n and $FF;goto 2;
      end;
      if (3=r1)and(8=b and 8) then if r2=7 then begin g:=r[6];asm
	mov	ah,g
	sahf
	dec	rsp
	lahf
	mov	g,ah
	end;r[6]:=g;goto 2;
      end else begin g:=r[r2];n:=m[r[r2]]*256+m[r[r2-1]];asm
	mov	ah,g
	sahf
	dec	n
	lahf
	mov	g,ah
	end;r[r2]:=g;m[r[r2]]:=(n and $FF00)shr 8;m[r[r2-1]]:=n and $FF;goto 2;
      end;
    end;
    1:begin
      if r1=6 then r[r2]:=m[r[5]*$FF+r[4]] else
      if r2=6 then m[r[5]*$FF+r[4]]:=r[r1] else
      r[r1]:=r[r2] end;
    2:begin
      if 0=r2 then if r1=6 then begin g:=r[6];a:=m[r[5]*$FF+r[4]];c:=r[7];asm
	mov	ah,g
	sahf
	mov	ah,a
	add	c,ah
	lahf
	mov	g,ah
	end;r[6]:=g;r[7]:=c;goto 2;
      end else begin g:=r[6];a:=r[r1];c:=r[7];asm
	mov	ah,g
	sahf
	mov     ah,a
	add	c,ah
	lahf
	mov	g,ah
	end;r[6]:=g;r[7]:=c;goto 2;
      end;if 1=r2 then if r1=6 then begin g:=r[6];a:=m[r[5]*256+r[4]];c:=r[7];asm
	mov	ah,g
	sahf
	mov	ah,a
	sub	c,ah
	lahf
	mov	g,ah
	end;r[6]:=g;r[7]:=c;goto 2;
      end else begin g:=r[6];a:=r[r1];c:=r[7];asm
	mov	ah,g
	sahf
	mov     ah,a
	sub	c,ah
	lahf
	mov	g,ah
	end;r[6]:=g;r[7]:=c;goto 2;
      end;if 1=r2 then if r1=6 then begin g:=r[6];a:=m[r[5]*256+r[4]];c:=r[7];asm
	mov	ah,g
	sahf
	mov	ah,a
	sbb	c,ah
	lahf
	mov	g,ah
	end;r[6]:=g;r[7]:=c;goto 2;
      end else begin g:=r[6];a:=r[r1];c:=r[7];asm
	mov	ah,g
	sahf
	mov     ah,a
	sbb	c,ah
	lahf
	mov	g,ah
	end;r[6]:=g;r[7]:=c;goto 2;
      end;if 4=r2 then if r1=6 then begin g:=r[6];a:=m[r[5]*256+r[4]];c:=r[7];asm
	mov	ah,g
	sahf
	mov	ah,a
	and	c,ah
	lahf
	mov	g,ah
	end;r[6]:=g;r[7]:=c;goto 2;
      end else begin g:=r[6];a:=r[r1];c:=r[7];asm
	mov	ah,g
	sahf
	mov     ah,a
	and	c,ah
	lahf
	mov	g,ah
	end;r[6]:=g;r[7]:=c;goto 2;
      end;if 5=r2 then if r1=6 then begin g:=r[6];a:=m[r[5]*256+r[4]];c:=r[7];asm
	mov	ah,g
	sahf
	mov	ah,a
	xor	c,ah
	lahf
	mov	g,ah
	end;r[6]:=g;r[7]:=c;goto 2;
      end else begin g:=r[6];a:=r[r1];c:=r[7];asm
	mov	ah,g
	sahf
	mov     ah,a
	xor	c,ah
	lahf
	mov	g,ah
	end;r[6]:=g;r[7]:=c;goto 2;
      end;if 6=r2 then if r1=6 then begin g:=r[6];a:=m[r[5]*256+r[4]];c:=r[7];asm
	mov	ah,g
	sahf
	mov	ah,a
	or	c,ah
	lahf
	mov	g,ah
	end;r[6]:=g;r[7]:=c;goto 2;
      end else begin g:=r[6];a:=r[r1];c:=r[7];asm
	mov	ah,g
	sahf
	mov     ah,a
	or	c,ah
	lahf
	mov	g,ah
	end;r[6]:=g;r[7]:=c;goto 2;
      end;if 7=r2 then if r1=6 then begin g:=r[6];a:=m[r[5]*256+r[4]];c:=r[7];asm
	mov	ah,g
	sahf
	mov	ah,a
	cmp	c,ah
	lahf
	mov	g,ah
	end;r[6]:=g;r[7]:=c;goto 2;
      end else begin g:=r[6];a:=r[r1];c:=r[7];asm
	mov	ah,g
	sahf
	mov     ah,a
	cmp	c,ah
	lahf
	mov	g,ah
	end;r[6]:=g;r[7]:=c;goto 2;
      end;
    end;
    3:begin
    if r1=7 then pc:=(r2 shl 3)-1;
    if r1=2 then begin if r2=0 then begin
	g:=r[6];a:=0;asm
	mov	ah,g
	sahf
	jnz	@j0
	mov	ah,1
	mov	a,ah
@j0:
	  end;
	if a=0 then goto 5;pc:=pc+3;goto 4
      end;
      if r2=1 then begin
	g:=r[6];a:=0;asm
	mov	ah,g
	sahf
	jz	@j0
	mov	ah,1
	mov	a,ah
@j0:
	  end;if a=0 then goto 5;pc:=pc+3;goto 4
      end;
      if r2=2 then begin
	g:=r[6];a:=0;asm
	mov	ah,g
	sahf
	jnc	@j0
	mov	ah,1
	mov	a,ah
@j0:
	  end;
	if a=0 then goto 5;pc:=pc+3;goto 4
      end;
      if r2=3 then begin
	g:=r[6];a:=0;asm
	mov	ah,g
	sahf
	jc	@j0
	mov	ah,1
	mov	a,ah
@j0:
	  end;
	if a=0 then goto 5;pc:=pc+3;goto 4
      end;
      if r2=4 then begin
	g:=r[6];a:=0;asm
	mov	ah,g
	sahf
	jpo	@j0
	mov	ah,1
	mov	a,ah
@j0:
	  end;
	if a=0 then goto 5;pc:=pc+3;goto 4
      end;
      if r2=5 then begin
	g:=r[6];a:=0;asm
	mov	ah,g
	sahf
	jpe	@j0
	mov	ah,1
	mov	a,ah
@j0:
	  end;if a=0 then goto 5;pc:=pc+3;goto 4
      end;
      if r2=6 then begin
	g:=r[6];a:=0;asm
	mov	ah,g
	sahf
	jns	@j0
	mov	ah,1
	mov	a,ah
@j0:
	  end;
	if a=0 then goto 5;pc:=pc+3;goto 4
      end;
      if r2=7 then begin
	g:=r[6];a:=0;asm
	mov	ah,g
	sahf
	js	@j0
	mov	ah,1
	mov	a,ah
@j0:
	  end;
	if a=0 then goto 5;pc:=pc+3;goto 4
      end;
    end;
    if r1=0 then begin if r2=0 then begin
	g:=r[6];a:=0;asm
	mov	ah,g
	sahf
	jnz	@j0
	mov	ah,1
	mov	a,ah
@j0:
	  end;
	if a=0 then goto 7;pc:=pc+3;goto 4
      end;
      if r2=1 then begin
	g:=r[6];a:=0;asm
	mov	ah,g
	sahf
	jz	@j0
	mov	ah,1
	mov	a,ah
@j0:
	  end;if a=0 then goto 7;pc:=pc+3;goto 4
      end;
      if r2=2 then begin
	g:=r[6];a:=0;asm
	mov	ah,g
	sahf
	jnc	@j0
	mov	ah,1
	mov	a,ah
@j0:
	  end;
	if a=0 then goto 7;pc:=pc+3;goto 4
      end;
      if r2=3 then begin
	g:=r[6];a:=0;asm
	mov	ah,g
	sahf
	jc	@j0
	mov	ah,1
	mov	a,ah
@j0:
	  end;
	if a=0 then goto 7;pc:=pc+3;goto 4
      end;
      if r2=4 then begin
	g:=r[6];a:=0;asm
	mov	ah,g
	sahf
	jpo	@j0
	mov	ah,1
	mov	a,ah
@j0:
	  end;
	if a=0 then goto 7;pc:=pc+3;goto 4
      end;
      if r2=5 then begin
	g:=r[6];a:=0;asm
	mov	ah,g
	sahf
	jpe	@j0
	mov	ah,1
	mov	a,ah
@j0:
	  end;if a=0 then goto 5;pc:=pc+3;goto 4
      end;
      if r2=6 then begin
	g:=r[6];a:=0;asm
	mov	ah,g
	sahf
	jns	@j0
	mov	ah,1
	mov	a,ah
@j0:
	  end;
	if a=0 then goto 7;pc:=pc+3;goto 4
      end;
      if r2=7 then begin
	g:=r[6];a:=0;asm
	mov	ah,g
	sahf
	js	@j0
	mov	ah,1
	mov	a,ah
@j0:
	  end;
	if a=0 then goto 7;pc:=pc+3;goto 4
      end;
    end;
    if r1=4 then begin if r2=0 then begin
	g:=r[6];a:=0;asm
	mov	ah,g
	sahf
	jnz	@j0
	mov	ah,1
	mov	a,ah
@j0:
	  end;
	if a=0 then goto 6;pc:=pc+3;goto 4
      end;
      if r2=1 then begin
	g:=r[6];a:=0;asm
	mov	ah,g
	sahf
	jz	@j0
	mov	ah,1
	mov	a,ah
@j0:
	  end;if a=0 then goto 6;pc:=pc+3;goto 4
      end;
      if r2=2 then begin
	g:=r[6];a:=0;asm
	mov	ah,g
	sahf
	jnc	@j0
	mov	ah,1
	mov	a,ah
@j0:
	  end;
	if a=0 then goto 6;pc:=pc+3;goto 4
      end;
      if r2=3 then begin
	g:=r[6];a:=0;asm
	mov	ah,g
	sahf
	jc	@j0
	mov	ah,1
	mov	a,ah
@j0:
	  end;
	if a=0 then goto 6;pc:=pc+3;goto 4
      end;
      if r2=4 then begin
	g:=r[6];a:=0;asm
	mov	ah,g
	sahf
	jpo	@j0
	mov	ah,1
	mov	a,ah
@j0:
	  end;
	if a=0 then goto 6;pc:=pc+3;goto 4
      end;
      if r2=5 then begin
	g:=r[6];a:=0;asm
	mov	ah,g
	sahf
	jpe	@j0
	mov	ah,1
	mov	a,ah
@j0:
	  end;if a=0 then goto 5;pc:=pc+3;goto 4
      end;
      if r2=6 then begin
	g:=r[6];a:=0;asm
	mov	ah,g
	sahf
	jns	@j0
	mov	ah,1
	mov	a,ah
@j0:
	  end;
	if a=0 then goto 6;pc:=pc+3;goto 4
      end;
      if r2=7 then begin
	g:=r[6];a:=0;asm
	mov	ah,g
	sahf
	js	@j0
	mov	ah,1
	mov	a,ah
@j0:
	  end;
	if a=0 then goto 6;pc:=pc+3;goto 4
      end;
    end;
    if (b and $F)=1 then begin
      r[r2]:=m[rsp];r[r2+1]:=m[rsp-1];rsp:=rsp-2
    end;if (b and $F)=5 then begin
      m[rsp]:=r[r1];m[rsp+1]:=r[r1+1];rsp:=rsp+2
    end;
  end;
  end;
  2:pc:=pc+1;
  4:t:=t+1;if keypressed then if 27=ord(readkey) then if 0=ord(readkey) then c:=0 else c:=1 else goto 1 else goto 1;
end.