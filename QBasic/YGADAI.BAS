10 PRINT "������ �᫮"
INPUT n%: k% = RND(1) * 10
IF n% = k% THEN PRINT "������  :) !" ELSE PRINT "�� 㣠��� :( !"; k%
PRINT "��室 (y/n) ?"
INPUT m$
IF m$ = "y" THEN GOTO 90 ELSE GOTO 10
90 END

