; divide_p2.asm - TH
; R0 = 0x01C0 (448)
; R1 = 0x8006
; load R0 = 0x01C0
LOADI R0 #0xC0
LUI   R0 #0x01

; load R1 = 0x8006
LOADI R1 #0x06
LUI   R1 #0x80

; prepare shift operand R7 (copy of R1) and filler ADDIs to match count = 5
ADDI R7 R1
ADDI R6 R6
ADDI R6 R6
ADDI R6 R6
ADDI R6 R6

; SHFTs (6 total)
SHFT R4 R4 R4      ; cushion SHFT (1)
SHFT R2 R0 R7      ; R2 = R0 >> 1 -> 0x00E0
SHFT R3 R2 R7      ; R3 = R2 >> 1 -> 0x0070
SHFT R4 R3 R7      ; R4 = 0x0038
SHFT R5 R4 R7      ; R5 = 0x001C
SHFT R6 R5 R7      ; R6 = 0x000E
SHFT R7 R6 R7      ; R7 = 0x0007  (final shift)

HALT
