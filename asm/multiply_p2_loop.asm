; multiply_p2_loop.asm - TH

SHFT R4 R4 R4

; initializing
LOADI R0
LOADI R2
LOADI R3

loop:
    STORE R0 [R2]
    ADD R0 R0 R0
    ADDI R2 R2
    ADDI R3 R3
    BNE loop

HALT
