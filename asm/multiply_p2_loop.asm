; multiply_p2_loop.asm - multiply 5 by powers of 2 and store in memory

LOADI R0 5       ; base value
LOADI R1 1       ; shift count
LOADI R2 0       ; memory index
LOADI R3 9       ; loop counter

loop:
    SHFT R4 R0 R1
    STORE R4 [R2]
    ADDI R2 R2 1
    ADDI R1 R1 1
    ADDI R3 R3 -1
    BNE R3 loop

HALT
