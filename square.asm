DATA SEGMENT
A DB ?
RES DW ?
NXT_LINE DB 10,13,'$'
DATA ENDS

CODE SEGMENT
ASSUME DS:DATA,CS:CODE
START:
        MOV AX,DATA
        MOV DS,AX

        CALL KB_RD
        MOV A,AL

        MUL AL
        PUSH AX
        LEA DX,NXT_LINE
        MOV AH,09H
        INT 21H
        POP AX
        PUSH AX

        MOV BL,AH
        CALL HEX_DISP
        POP AX
        MOV BL,AL
        CALL HEX_DISP

        MOV AH,4CH
        INT 21H
        KB_RD:
                MOV AH,01
                INT 21H
                CALL ASCII_HEX
                MOV BH,AL
                MOV AH,01
                INT 21H
                CALL ASCII_HEX
                MOV CL,04H
                SHL BH,CL
                ADD AL,BH
                RET
        ASCII_HEX:
                CMP AL,41H
                JC SKIP1
                SUB AL,07H
                SKIP1:SUB AL,30H
                RET
        HEX_ASCII:
                CMP DL,0AH
                JC SKIP
                ADD DL,07H
                SKIP:ADD DL,30H
                RET
        HEX_DISP:
                MOV DL,BL
                AND DL,0F0H
                MOV CL,04H
                ROR DL,CL
                CALL HEX_ASCII
                MOV AH,02
                INT 21H
                AND BL,0FH
                MOV DL,BL
                CALL HEX_ASCII
                MOV AH,02H
                INT 21H
                RET
                CODE ENDS
                END START
                
