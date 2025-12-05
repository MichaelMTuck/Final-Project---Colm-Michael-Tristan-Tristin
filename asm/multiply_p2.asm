; multiply_p2.asm - TH

SHFT R0 R0 R0

LOADI R0
LOADI R1

ADDI R2 R1

; create R7 shift-amount register (set to 1) using ADDI (from zero)
ADDI R7 R7 #1      ; 2

; filler ADDI instructions to reach requested ADDI count = 5
ADDI R1 R1 #0      ; 3
ADDI R1 R1 #0      ; 4
ADDI R1 R1 #0      ; 5

; Create R3..R7 by repeatedly shifting left by 1 (six SHFTs total including cushion)
SHFT R3 R2 R7
SHFT R4 R3 R7
SHFT R5 R4 R7
SHFT R6 R5 R7
SHFT R7 R6 R7

HALT

