DECLARE SUB PDOT (Whe AS DOUBLE)
DECLARE SUB Delay (X!)
DECLARE SUB CreatTemp ()
DECLARE SUB loadTMP ()
DECLARE FUNCTION Check! ()
DECLARE SUB PlayGame ()
DECLARE SUB SeeCredits ()
DECLARE SUB LoadLevel (Level AS INTEGER)
DECLARE SUB menu (Col1!, Col2!, Col3!)
DECLARE SUB FirstScreen ()
DECLARE SUB Man (Xcor AS DOUBLE, Ycor AS DOUBLE, Visible AS INTEGER)
DECLARE SUB initpath ()
DECLARE SUB dot (Xcor AS DOUBLE, Ycor AS DOUBLE, Visible AS INTEGER)
DECLARE SUB Wood (Xcor AS DOUBLE, Ycor AS DOUBLE, Visible AS INTEGER)
DECLARE SUB Split (Text AS STRING, Diameter AS STRING)
DECLARE SUB Doordot (Xcor AS DOUBLE, Ycor AS DOUBLE, Visible AS INTEGER)
DECLARE SUB Door (Xcor AS DOUBLE, Ycor AS DOUBLE, Visible AS INTEGER)

CLS 0
SCREEN 12
DIM SHARED SPT(90) AS STRING
DIM SHARED TR(89) AS STRING
DIM SHARED ManX AS DOUBLE, ManY AS DOUBLE
DIM SHARED Level AS INTEGER
DIM SHARED ManPos AS INTEGER
DIM SHARED UP(9) AS INTEGER, down(9) AS INTEGER, Left(8) AS INTEGER, Right(8) AS INTEGER

DATA 0,9,18,27,36,45,54,63,72,81
DATA 8,17,26,35,44,53,62,71,80,89
DATA 0,1,2,3,4,5,6,7,8
DATA 81,82,83,84,85,86,87,88,89

FOR X = 0 TO 9: READ A: UP(X) = A: NEXT
FOR X = 0 TO 9: READ A: down(X) = A: NEXT
FOR X = 0 TO 8: READ A: Left(X) = A: NEXT
FOR X = 0 TO 8: READ A: Right(X) = A: NEXT

'initpath
Level = 1
FirstScreen
END

Rasal:
        RESUME NEXT
Rasal1:
        
        CLS 0
        LOCATE 2, 1: PRINT "Level Ended:"
        DO: LOOP WHILE INKEY$ = ""
        END

FUNCTION Check
        F = 1
        FOR X = 0 TO 89
                IF (TR(X) = "dot" OR TR(X) = "door") THEN
                        F = 0: EXIT FOR
                END IF
        NEXT
        Check = F
END FUNCTION

SUB CreatTemp
        OPEN "rasal.tmp" FOR OUTPUT AS #1
                FOR X = 0 TO 89
                        PRINT #1, TR(X); ";";
                NEXT
                PRINT #1, ManPos;
        CLOSE
END SUB

SUB Delay (X)
        FOR X = 1 TO 1000: NEXT
END SUB

SUB Door (Xcor AS DOUBLE, Ycor AS DOUBLE, Visible AS INTEGER)
IF (Visible) THEN
        LINE (Xcor, Ycor)-(Xcor + 29, Ycor + 29), 7, B
        PAINT (Xcor + 5, Ycor + 5), 2, 7
ELSE
        PAINT (Xcor + 5, Ycor + 5), 0, 7
        LINE (Xcor, Ycor)-(Xcor + 29, Ycor + 29), 0, B
END IF
END SUB

SUB Doordot (Xcor AS DOUBLE, Ycor AS DOUBLE, Visible AS INTEGER)
IF (Visible) THEN
        LINE (Xcor, Ycor)-(Xcor + 29, Ycor + 29), 7, B
        PAINT (Xcor + 5, Ycor + 5), 1, 7
ELSE
        PAINT (Xcor + 5, Ycor + 5), 0, 7
        LINE (Xcor, Ycor)-(Xcor + 29, Ycor + 29), 0, B
END IF
END SUB

SUB dot (Xcor AS DOUBLE, Ycor AS DOUBLE, Visible AS INTEGER)
IF (Visible) THEN
        CIRCLE (Xcor + 15, Ycor + 15), 2, 7
        PAINT (Xcor + 15, Ycor + 15), 11, 7
ELSE
        PAINT (Xcor + 5, Ycor + 5), 0, 7
        CIRCLE (Xcor + 15, Ycor + 15), 2, 0
END IF
END SUB

SUB FirstScreen
Begning:
        CLS 0
        Where = 1
        menu 4, 6, 6
        DO
                Choose$ = INKEY$
                Choice$ = RIGHT$(Choose$, 1)
                SELECT CASE Choice$
                        CASE "P"
                                IF (Where = 1) THEN menu 6, 4, 6
                                IF (Where = 2) THEN menu 6, 6, 4
                                IF (Where < 3) THEN Where = Where + 1
                        CASE "H"
                                IF (Where = 3) THEN menu 6, 4, 6
                                IF (Where = 2) THEN menu 4, 6, 6
                                IF (Where > 1) THEN Where = Where - 1
                END SELECT
        LOOP WHILE Choose$ <> CHR$(13)
        IF (Where = 1) THEN PlayGame
        IF (Where = 2) THEN SeeCredits
        IF (Where = 3) THEN END
GOTO Begning
END SUB

SUB initpath
        SHELL ("D:")
        SHELL ("cd\")
        SHELL ("Cd learn\Soukaban")
END SUB

SUB LoadLevel (Level AS INTEGER)
ON ERROR GOTO Rasal1
        DIM Y AS DOUBLE
        CLS 0
        
        OPEN "level" + LTRIM$(STR$(Level)) + ".lev" FOR INPUT AS #1
                LINE INPUT #1, T$
        CLOSE
       
        LOCATE 1, 1: PRINT "Loading Please Wait....."
        Delay .005
        CLS 0

        LOCATE 8, 17: COLOR 13: PRINT "Level "; Level
        Split T$, ";"
        FOR X = 0 TO 89: TR(X) = "": NEXT
        Y = 125: Tmp = 128: Tmp1 = 0: Count = 0
        FOR X = 0 TO 89
                IF (Count = 9) THEN Y = Y + 30: Tmp1 = 0: Count = 0
                IF (SPT(X) = "wood") THEN
                        TR(X) = "wood"
                        CALL Wood(Y, (Tmp1 * 30) + Tmp, 1)
                ELSEIF (SPT(X) = "door") THEN
                        TR(X) = "door"
                        CALL Door(Y, (Tmp1 * 30) + Tmp, 1)
                ELSEIF (SPT(X) = "doordot") THEN
                        TR(X) = "doordot"
                        CALL Doordot(Y, (Tmp1 * 30) + Tmp, 1)
                ELSEIF (SPT(X) = "dot") THEN
                        TR(X) = "dot"
                        CALL dot(Y, (Tmp1 * 30) + Tmp, 1)
                END IF
                Tmp1 = Tmp1 + 1
                Count = Count + 1
        NEXT
        RA = VAL(SPT(90))
        ManPos = RA
        ManX = ((RA \ 9) * 30) + 125
        WHILE RA > 9
                IF (RA > 9) THEN RA = RA - 9
        WEND
        ManY = (RA * 30) + 128
        CALL Man(ManX, ManY, 1)
END SUB

SUB loadTMP
'ON ERROR GOTO Rasal1
        OPEN "rasal.tmp" FOR INPUT AS #1
                LINE INPUT #1, Txt$
        CLOSE
        CLS 0
        LOCATE 8, 17: COLOR 13: PRINT "Level "; Level
        Split Txt$, ";"
        FOR X = 0 TO 89: TR(X) = "": NEXT
        Y# = 125: Tmp = 128: Tmp1 = 0: Count = 0
        FOR X = 0 TO 89
                IF (Count = 9) THEN Y# = Y# + 30: Tmp1 = 0: Count = 0
                IF (SPT(X) = "wood") THEN
                        TR(X) = "wood"
                        CALL Wood(Y#, (Tmp1 * 30) + Tmp, 1)
                ELSEIF (SPT(X) = "door") THEN
                        TR(X) = "door"
                        CALL Door(Y#, (Tmp1 * 30) + Tmp, 1)
                ELSEIF (SPT(X) = "doordot") THEN
                        TR(X) = "doordot"
                        CALL Doordot(Y#, (Tmp1 * 30) + Tmp, 1)
                ELSEIF (SPT(X) = "dot") THEN
                        TR(X) = "dot"
                        CALL dot(Y#, (Tmp1 * 30) + Tmp, 1)
                END IF
                Tmp1 = Tmp1 + 1
                Count = Count + 1
        NEXT
        RA = VAL(SPT(90))
        ManPos = RA
        ManX = ((RA \ 9) * 30) + 125
        WHILE RA > 9
                IF (RA > 9) THEN RA = RA - 9
        WEND
        ManY = (RA * 30) + 128
        CALL Man(ManX, ManY, 1)
END SUB

SUB Man (Xcor AS DOUBLE, Ycor AS DOUBLE, Visible AS INTEGER)
IF (Visible) THEN
        CIRCLE (Xcor + 15, Ycor + 6), 5, 7
        LINE (Xcor + 15, Ycor + 11)-(Xcor + 15, Ycor + 29), 7
        LINE (Xcor + 15, Ycor + 12)-(Xcor + 5, Ycor + 15), 7
        LINE (Xcor + 15, Ycor + 12)-(Xcor + 25, Ycor + 15), 7
        LINE (Xcor + 15, Ycor + 20)-(Xcor + 25, Ycor + 29), 7
        LINE (Xcor + 15, Ycor + 20)-(Xcor + 5, Ycor + 29), 7
ELSE
        CIRCLE (Xcor + 15, Ycor + 6), 5, 0
        LINE (Xcor + 15, Ycor + 11)-(Xcor + 15, Ycor + 29), 0
        LINE (Xcor + 15, Ycor + 12)-(Xcor + 5, Ycor + 15), 0
        LINE (Xcor + 15, Ycor + 12)-(Xcor + 25, Ycor + 15), 0
        LINE (Xcor + 15, Ycor + 20)-(Xcor + 25, Ycor + 29), 0
        LINE (Xcor + 15, Ycor + 20)-(Xcor + 5, Ycor + 29), 0
END IF
END SUB

SUB menu (Col1, Col2, Col3)
        LOCATE 12, 12: COLOR 12: PRINT "Choose Any"
        LOCATE 13, 15: COLOR Col1: PRINT "1. Play"
        LOCATE 14, 15: COLOR Col2: PRINT "2. See Credits"
        LOCATE 15, 15: COLOR Col3: PRINT "3. Exit"
END SUB

SUB PDOT (Whe AS DOUBLE)
        DIM Xval AS DOUBLE, Yval AS DOUBLE
        Rval = Whe
        Xval = ((Rval \ 9) * 30) + 125
        WHILE Rval > 9
                IF (Rval > 9) THEN Rval = Rval - 9
        WEND
        Yval = (Rval * 30) + 128
        dot Xval, Yval, 1
END SUB

SUB PlayGame
ON ERROR GOTO Rasal
        DIM A AS DOUBLE
        LoadLevel Level
        DO
                Choose$ = INKEY$
                Choice$ = RIGHT$(Choose$, 1)
                IF (LCASE$(Choose$) = "n") THEN loadTMP
                LOCATE 1, 1
                IF (Choose$ = "~") THEN INPUT "Enter Cheat Code:", Cheat$
                IF (Cheat$ = "Rasal") THEN : Level = Level + 1: LoadLevel Level: Cheat$ = ""

                SELECT CASE Choice$
                        CASE "H"
                                FOR X = 0 TO 9
                                        IF (ManPos = UP(X)) THEN
                                                GOTO bin
                                        ELSEIF (ManPos - 1 = UP(X) AND (TR(ManPos - 1) = "door" OR TR(ManPos - 1) = "doordot")) THEN
                                                GOTO bin
                                        END IF
                                NEXT
                        CASE "P"
                                FOR X = 0 TO 9
                                        IF (ManPos = down(X)) THEN
                                                GOTO bin
                                        ELSEIF (ManPos + 1 = down(X)) THEN
                                                IF (TR(ManPos + 1) = "door" OR TR(ManPos + 1) = "doordot") THEN
                                                        GOTO bin
                                                END IF
                                        END IF
                                NEXT

                        CASE "K"
                                FOR X = 0 TO 8
                                        IF (ManPos = Left(X)) THEN
                                                GOTO bin
                                        ELSEIF (ManPos - 9 = Left(X)) THEN
                                                IF (TR(ManPos - 9) = "door" OR TR(ManPos - 9) = "doordot") THEN GOTO bin
                                        END IF
                                NEXT
                        CASE "M"
                                FOR X = 0 TO 8
                                        IF (ManPos = Right(X)) THEN
                                                GOTO bin
                                        ELSEIF (ManPos + 9 = Right(X)) THEN
                                                IF (TR(ManPos + 9) = "door" OR TR(ManPos + 9) = "doordot") THEN
                                                        GOTO bin
                                                END IF
                                        END IF
                                NEXT
                END SELECT
                SELECT CASE Choice$
                        CASE "H"
                                CreatTemp
                                IF (TR(ManPos - 1) = "door") THEN
                                        IF (TR(ManPos - 2) <> "door" AND TR(ManPos - 2) <> "doordot" AND TR(ManPos - 2) <> "wood") THEN
                                                IF (TR(ManPos - 2) = "dot") THEN
                                                        Door ManX, ManY - 30, 0
                                                        dot ManX, ManY - 60, 0
                                                        Doordot ManX, ManY - 60, 1
                                                        TR(ManPos - 1) = ""
                                                        TR(ManPos - 2) = "doordot"

                                                        Man ManX, ManY, 0
                                                        Man ManX, ManY - 30, 1
                                                        ManY = ManY - 30
                                                        ManPos = ManPos - 1
                                                ELSEIF (TR(ManPos - 2) = "") THEN
                                                        Door ManX, ManY - 30, 0
                                                        Man ManX, ManY, 0
                                                        Door ManX, ManY - 60, 1
                                                        TR(ManPos - 1) = ""
                                                        TR(ManPos - 2) = "door"

                                                        Man ManX, ManY, 0
                                                        Man ManX, ManY - 30, 1
                                                        ManY = ManY - 30
                                                        ManPos = ManPos - 1

                                                END IF
                                        END IF
                                ELSEIF (TR(ManPos - 1) = "doordot") THEN
                                        IF (TR(ManPos - 2) <> "door" AND TR(ManPos - 2) <> "doordot" AND TR(ManPos - 2) <> "wood") THEN
                                                IF (TR(ManPos - 2) = "dot") THEN
                                                        Doordot ManX, ManY - 30, 0
                                                        dot ManX, ManY - 30, 1
                                                        dot ManX, ManY - 60, 0
                                                        Doordot ManX, ManY - 60, 1
                                                        TR(ManPos - 1) = "dot"
                                                        TR(ManPos - 2) = "doordot"
                                                        Man ManX, ManY, 0
                                                        Man ManX, ManY - 30, 1
                                                        ManY = ManY - 30
                                                        ManPos = ManPos - 1
                                                ELSEIF (TR(ManPos - 2) = "") THEN
                                                        Doordot ManX, ManY - 30, 0
                                                        dot ManX, ManY - 30, 1
                                                        Door ManX, ManY - 60, 1

                                                        TR(ManPos - 1) = "dot"
                                                        TR(ManPos - 2) = "door"

                                                        Man ManX, ManY, 0
                                                        Man ManX, ManY - 30, 1
                                                        ManY = ManY - 30
                                                        ManPos = ManPos - 1
                                                END IF
                                        END IF
                                ELSEIF (TR(ManPos - 1) = "" OR TR(ManPos - 1) = "dot") THEN
                                        Man ManX, ManY, 0
                                        Man ManX, ManY - 30, 1
                                        ManY = ManY - 30
                                        ManPos = ManPos - 1
                                END IF
                                IF (TR(ManPos + 1) = "dot") THEN PDOT (ManPos + 1)
                        CASE "K"
                                CreatTemp
                                IF (TR(ManPos - 9) = "door") THEN
                                        IF (TR(ManPos - 18) <> "door" AND TR(ManPos - 18) <> "doordot" AND TR(ManPos - 18) <> "wood") THEN
                                                IF (TR(ManPos - 18) = "dot") THEN
                                                        Door ManX - 30, ManY, 0
                                                        dot ManX - 60, ManY, 0
                                                        Doordot ManX - 60, ManY, 1
                                                        TR(ManPos - 9) = ""
                                                        TR(ManPos - 18) = "doordot"

                                                        Man ManX, ManY, 0
                                                        Man ManX - 30, ManY, 1
                                                        ManX = ManX - 30
                                                        ManPos = ManPos - 9
                                                ELSEIF (TR(ManPos - 18) = "") THEN
                                                        Door ManX - 30, ManY, 0
                                                        Door ManX - 60, ManY, 1
                                                        TR(ManPos - 9) = ""
                                                        TR(ManPos - 18) = "door"

                                                        Man ManX, ManY, 0
                                                        Man ManX - 30, ManY, 1
                                                        ManX = ManX - 30
                                                        ManPos = ManPos - 9

                                                END IF
                                        END IF
                                ELSEIF (TR(ManPos - 9) = "doordot") THEN
                                        IF (TR(ManPos - 18) <> "door" AND TR(ManPos - 18) <> "doordot" AND TR(ManPos - 18) <> "wood") THEN
                                                IF (TR(ManPos - 18) = "dot") THEN
                                                        Doordot ManX - 30, ManY, 0
                                                        dot ManX - 30, ManY, 1
                                                        dot ManX - 60, ManY, 0
                                                        Doordot ManX - 60, ManY, 1
                                                        TR(ManPos - 9) = "dot"
                                                        TR(ManPos - 18) = "doordot"

                                                        Man ManX, ManY, 0
                                                        Man ManX - 30, ManY, 1
                                                        ManX = ManX - 30
                                                        ManPos = ManPos - 9
                                                ELSEIF (TR(ManPos - 18) = "") THEN
                                                        Doordot ManX - 30, ManY, 0
                                                        dot ManX - 30, ManY, 1
                                                        Door ManX - 60, ManY, 1
                                                        TR(ManPos - 9) = "dot"
                                                        TR(ManPos - 18) = "door"

                                                        Man ManX, ManY, 0
                                                        Man ManX - 30, ManY, 1
                                                        ManX = ManX - 30
                                                        ManPos = ManPos - 9
                                                END IF
                                        END IF
                                ELSEIF (TR(ManPos - 9) = "" OR TR(ManPos - 9) = "dot") THEN
                                        Man ManX, ManY, 0
                                        Man ManX - 30, ManY, 1
                                        ManX = ManX - 30
                                        ManPos = ManPos - 9
                                END IF
                                IF (TR(ManPos + 9) = "dot") THEN PDOT (ManPos + 9)
                        CASE "M"
                                CreatTemp
                                IF (TR(ManPos + 9) = "door") THEN
                                        IF (TR(ManPos + 18) <> "door" AND TR(ManPos + 18) <> "doordot" AND TR(ManPos + 18) <> "wood") THEN
                                                IF (TR(ManPos + 18) = "dot") THEN
                                                        Door ManX + 30, ManY, 0
                                                        dot ManX + 60, ManY, 0
                                                        Doordot ManX + 60, ManY, 1
                                                        TR(ManPos + 9) = ""
                                                        TR(ManPos + 18) = "doordot"

                                                        Man ManX, ManY, 0
                                                        Man ManX + 30, ManY, 1
                                                        ManX = ManX + 30
                                                        ManPos = ManPos + 9
                                                ELSEIF (TR(ManPos + 18) = "") THEN
                                                        Door ManX + 30, ManY, 0
                                                        Door ManX + 60, ManY, 1
                                                        TR(ManPos + 9) = ""
                                                        TR(ManPos + 18) = "door"

                                                        Man ManX, ManY, 0
                                                        Man ManX + 30, ManY, 1
                                                        ManX = ManX + 30
                                                        ManPos = ManPos + 9

                                                END IF
                                        END IF
                                ELSEIF (TR(ManPos + 9) = "doordot") THEN
                                        IF (TR(ManPos + 18) <> "door" AND TR(ManPos + 18) <> "doordot" AND TR(ManPos + 18) <> "wood") THEN
                                                IF (TR(ManPos + 18) = "dot") THEN
                                                        Doordot ManX + 30, ManY, 0
                                                        dot ManX + 30, ManY, 1
                                                        dot ManX + 60, ManY, 0
                                                        Doordot ManX + 60, ManY, 1
                                                        TR(ManPos + 9) = "dot"
                                                        TR(ManPos + 18) = "doordot"

                                                        Man ManX, ManY, 0
                                                        Man ManX + 30, ManY, 1
                                                        ManX = ManX + 30
                                                        ManPos = ManPos + 9
                                                ELSEIF (TR(ManPos + 18) = "") THEN
                                                        Doordot ManX + 30, ManY, 0
                                                        dot ManX + 30, ManY, 1
                                                        dot ManX + 60, ManY, 0
                                                        Door ManX + 60, ManY, 1
                                                        TR(ManPos + 9) = "dot"
                                                        TR(ManPos + 18) = "door"

                                                        Man ManX, ManY, 0
                                                        Man ManX + 30, ManY, 1
                                                        ManX = ManX + 30
                                                        ManPos = ManPos + 9
                                                END IF
                                        END IF
                                ELSEIF (TR(ManPos + 9) = "" OR TR(ManPos + 9) = "dot") THEN
                                        Man ManX, ManY, 0
                                        Man ManX + 30, ManY, 1
                                        ManX = ManX + 30
                                        ManPos = ManPos + 9
                                END IF
                                IF (TR(ManPos - 9) = "dot") THEN PDOT (ManPos - 9)
                        CASE "P"
                                CreatTemp
                                IF (TR(ManPos + 1) = "door") THEN
                                        IF (TR(ManPos + 2) <> "door" AND TR(ManPos + 2) <> "doordot" AND TR(ManPos + 2) <> "wood") THEN
                                                IF (TR(ManPos + 2) = "dot") THEN
                                                        Door ManX, ManY + 30, 0
                                                        dot ManX, ManY + 60, 0
                                                        Doordot ManX, ManY + 60, 1
                                                        TR(ManPos + 1) = ""
                                                        TR(ManPos + 2) = "doordot"

                                                        Man ManX, ManY, 0
                                                        Man ManX, ManY + 30, 1
                                                        ManY = ManY + 30
                                                        ManPos = ManPos + 1
                                                ELSEIF (TR(ManPos + 2) = "") THEN
                                                        Door ManX, ManY + 30, 0
                                                        Door ManX, ManY + 60, 1
                                                        TR(ManPos + 1) = ""
                                                        TR(ManPos + 2) = "door"

                                                        Man ManX, ManY, 0
                                                        Man ManX, ManY + 30, 1
                                                        ManY = ManY + 30
                                                        ManPos = ManPos + 1

                                                END IF
                                        END IF
                                ELSEIF (TR(ManPos + 1) = "doordot") THEN
                                        IF (TR(ManPos + 2) <> "door" AND TR(ManPos + 2) <> "doordot" AND TR(ManPos + 2) <> "wood") THEN
                                                IF (TR(ManPos + 2) = "dot") THEN
                                                        Doordot ManX, ManY + 30, 0
                                                        dot ManX, ManY + 30, 1
                                                        dot ManX, ManY + 60, 0
                                                        Doordot ManX, ManY + 60, 1
                                                        TR(ManPos + 1) = "dot"
                                                        TR(ManPos + 2) = "doordot"
                                                        Man ManX, ManY, 0
                                                        Man ManX, ManY + 30, 1
                                                        ManY = ManY + 30
                                                        ManPos = ManPos + 1
                                                ELSEIF (TR(ManPos + 2) = "") THEN
                                                        Doordot ManX, ManY + 30, 0
                                                        dot ManX, ManY + 30, 1
                                                        dot ManX, ManY + 60, 0
                                                        Door ManX, ManY + 60, 1
                                                        TR(ManPos + 1) = "dot"
                                                        TR(ManPos + 2) = "door"

                                                        Man ManX, ManY, 0
                                                        Man ManX, ManY + 30, 1
                                                        ManY = ManY + 30
                                                        ManPos = ManPos + 1
                                                END IF
                                        END IF
                                ELSEIF (TR(ManPos + 1) = "" OR TR(ManPos + 1) = "dot") THEN
                                        Man ManX, ManY, 0
                                        Man ManX, ManY + 30, 1
                                        ManY = ManY + 30
                                        ManPos = ManPos + 1
                                END IF
                                IF (TR(ManPos - 1) = "dot") THEN PDOT (ManPos - 1)
                END SELECT
                IF (Check) THEN
                        Level = Level + 1
                        LoadLevel Level
                END IF
bin:
        LOOP WHILE Choose$ <> CHR$(27)
END SUB

SUB SeeCredits
        CLS 0
        LINE (0, 20)-(650, 20), 7
        LOCATE 1, 30: PRINT "Hit Escape to exit"
        LINE (0, 450)-(650, 450), 7
        LOCATE 14, 20: PRINT "Created By:"
        LOCATE 15, 25: PRINT "1. Binayak Dhakal"
        LOCATE 16, 20: PRINT "Special Thansk to:"
        LOCATE 17, 25: PRINT "1. Microsoft QBasic 4.5 Team"

        DO: LOOP WHILE INKEY$ <> CHR$(27)
END SUB

SUB Split (Text AS STRING, Diameter AS STRING)
Lpd = 1: PF = -1
IP = 1
FOR X = 1 TO LEN(Text)
        N$ = MID$(Text, X, 1)
        IF (LCASE$(N$) = LCASE$(Diameter)) THEN
                PF = PF + 1: Lpd = X
                SPT(PF) = MID$(Text, IP, Lpd - IP)
                IP = X + 1
        END IF
NEXT
PF = PF + 1
SPT(PF) = MID$(Text, IP, (LEN(Text) + 1) - IP)
END SUB

SUB Wood (Xcor AS DOUBLE, Ycor AS DOUBLE, Visible AS INTEGER)
IF (Visible) THEN
        LINE (Xcor, Ycor)-(Xcor + 29, Ycor + 29), 7, B
        PAINT (Xcor + 5, Ycor + 5), 6, 7
ELSE
        PAINT (Xcor + 5, Ycor + 5), 0, 7
        LINE (Xcor, Ycor)-(Xcor + 29, Ycor + 29), 0, B
END IF
END SUB

