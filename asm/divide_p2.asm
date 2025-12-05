; divide_p2.asm
; divide 0x1C0 (448) by powers of two, store in R0-R7

LOADI R0, #0x1C0    ; 448
LOADI R1, #1        ; shift amount for right shifts

SHFT R2, R0, R1     ; 448 >> 1 = 224
SHFT R3, R2, R1     ; 224 >> 1 = 112
SHFT R4, R3, R1     ; 112 >> 1 = 56
SHFT R5, R4, R1     ; 56 >> 1 = 28
SHFT R6, R5, R1     ; 28 >> 1 = 14
LOADI R7, #7        ; last divisor
HALT
