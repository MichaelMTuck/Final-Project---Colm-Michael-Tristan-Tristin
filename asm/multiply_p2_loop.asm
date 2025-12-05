; multiply_p2_loop.asm - TH

LOADI R0 0x05     ; R0 = 5 (base operand)
ADD   R1 R0 R0    ; R1 = 10 (5 * 2^1)  -- first result to store
LOADI R2 0x00     ; R2 = mem pointer (address 0)
LOADI R3 0x09     ; R3 = loop count (9 results)
LOADI R4 0x00     ; R4 = zero (used for branch compare)
LOADI R6 0x01     ; R6 = 1 (decrement amount)

loop:
STORE R1 [R2]     ; memory[R2] = R1
ADD   R1 R1 R1    ; R1 *= 2
ADDI  R2 R2 1     ; R2 = R2 + 1 (advance memory address)
SUB   R3 R3 R6    ; R3 = R3 - 1
BNE   R3 R4 loop  ; if R3 != 0, repeat

HALT


