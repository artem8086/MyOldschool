CLS : s$ = "Ошибка!"
PRINT "Игра в 11 палочек."
6 PRINT "Введите кол-во палочeк": INPUT c%: n% = c%
IF c% < 1 THEN PRINT s$: GOTO 6 ELSE
5 n% = n% - 4
IF n% > 0 THEN GOTO 5 ELSE n% = n% + 3: c% = c% - n%
IF n% <> 0 THEN GOTO 1 ELSE
3 IF c% = 1 THEN GOTO 2 ELSE
4 PRINT "Ваш ход:": INPUT y%
IF y% < 1 THEN PRINT s$: GOTO 4 ELSE IF y% > 3 THEN PRINT s$: GOTO 4 ELSE
c% = c% - 4: n% = 4 - y%
1 PRINT "Ход ком:"; n%
PRINT "Палочек:"; c%: GOTO 3
2 PRINT "Ком выйграл!"
END




