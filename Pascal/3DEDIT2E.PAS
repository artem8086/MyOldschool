uses graph3d,graph,crt;
label 1;
var gd,gm,x2,y2,x3,y3:integer;ch:char;s:string;
begin
  gd:=detect;
  if 1=paramcount then begin s:=paramstr(1);goto 1 end;
  write('working file:');read(s);
  1:if 0=pos('.',s) then s:=s+'.3D';assign(fil,s);
  initgraph(gd,gm,'d:\tp7\bgi');
  {rewrite(fil);wr:=true;
  graph3De(0,0,sqr3D);close(fil);}
  {$I-}reset(fil);
  if (eof(fil))or(ioresult<>0) then begin
    rewrite(fil);wr:=true;write(fil,a,b);
    graph3De(0,0,clear3D);wr:=false
  end;close(fil);{$I+}
  reset(fil);read(fil,a,b);
  wr:=false;mouse:=true;
  repeat
    seek(fil,2);graph3de(x2,y2,read3D);
    ch:=readkey;cleardevice;case ch of
      ',':conx:=conx-0.1;
      '.':conx:=conx+0.1;
      '/','?':cony:=cony-0.1;
      '"',#39:cony:=cony+0.1;
      '+','=':readwrite3d(x2,y2,1);
      '-','_':readwrite3d(x2,y2,-1);
      'W','w':yp:=yp-10;
      'X','x':yp:=yp+10;
      'A','a':xp:=xp-10;
      'd','D':xp:=xp+10;
      '4':xs:=xs-1;
      '6':xs:=xs+1;
      '8':ys:=ys-1;
      '2':ys:=ys+1;
      'n','N':begin close(fil);rewrite(fil);
	write(fil,a,b);
	wr:=true;graph3De(x2,y2,clear3D);
	close(fil);reset(fil);wr:=false
      end;
      '7','1':begin xs:=xs-1;ys:=ys+1 end;
      '9','3':begin xs:=xs+1;ys:=ys-1 end;
      #0:case ord(readkey) of
	73:readwrite3d(x2,y2,50);
	81:readwrite3d(x2,y2,-50);
	75:if y2>-b then y2:=y2-1;
	77:if y2<b then y2:=y2+1;
	72:if x2>-a then x2:=x2-1;
	80:if x2<a then x2:=x2+1;
      end;
    end
  until ch=#27;close(fil)
end.