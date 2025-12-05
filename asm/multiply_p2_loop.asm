; multiply_p2_loop.asm - fixed version

; initialize registers
LOADI R0 10       ; R0 = 10 (value to multiply)
LOADI R2 0        ; R2 = memory index / address
LOADI R3 9        ; R3 = loop counter (9 iterations for MEM[0..8])

loop:
    STORE R0 [R2]       ; store R0 into memory[R2]
    ADD R0 R0 R0        ; multiply R0 by 2
    ADDI R2 R2 1        ; increment memory address
    ADDI R3 R3 -1       ; decrement loop counter
    BNE R3 loop         ; if R3 != 0, repeat

HALT
