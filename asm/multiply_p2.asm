; multiply_p2.asm - golden version TH

LOADI R0 3       ; original constant
LOADI R1 1       ; shift amount (multiply by 2 each time)

SHFT R2 R0 R1    ; 3 * 2 = 6
SHFT R3 R2 R1    ; 6 * 2 = 12
SHFT R4 R3 R1    ; 12 * 2 = 24
SHFT R5 R4 R1    ; 24 * 2 = 48
SHFT R6 R5 R1    ; 48 * 2 = 96
SHFT R7 R6 R1    ; 96 * 2 = 192

ADDI R0 R0 0
ADDI R1 R1 5
ADDI R2 R2 0
ADDI R3 R3 0
ADDI R4 R4 0

HALT
