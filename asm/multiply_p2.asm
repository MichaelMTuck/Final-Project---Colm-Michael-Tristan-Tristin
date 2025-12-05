; multiply_p2.asm
; multiply 3 by powers of two, store in R0-R7

LOADI R0, #3        ; original constant
LOADI R1, #1        ; will hold shift amount 1
SHFT R2, R0, R1     ; 3 * 2^1 = 6
SHFT R3, R2, R1     ; 6 * 2^1 = 12
SHFT R4, R3, R1     ; 12 * 2^1 = 24
SHFT R5, R4, R1     ; 24 * 2^1 = 48
SHFT R6, R5, R1     ; 48 * 2^1 = 96
SHFT R7, R6, R1     ; 96 * 2^1 = 192
HALT
