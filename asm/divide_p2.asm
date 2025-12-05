; divide_p2.asm - TH
; R0 = 0x01C0 (448), R1 = 0x8006 (shift operand)
; R2..R7 = 448 >> 1, >>2, ... >>6

; build R0 = 0x01C0
LOADI R0 0xC0     ; low byte 0xC0
LUI   R0 0x01     ; now R0 = 0x01C0

; build R1 = 0x8006 (MSB set + shift amount in low byte)
LOADI R1 0x06     ; low byte 0x06
LUI   R1 0x80     ; now R1 = 0x8006

; perform successive right shifts (SHFT uses R1 to indicate right shift)
SHFT  R2 R0 R1    ; R2 = R0 >> 1  => 0x00E0
SHFT  R3 R2 R1    ; R3 = R2 >> 1  => 0x0070
SHFT  R4 R3 R1    ; R4 = R3 >> 1  => 0x0038
SHFT  R5 R4 R1    ; R5 = R4 >> 1  => 0x001C
SHFT  R6 R5 R1    ; R6 = R5 >> 1  => 0x000E
SHFT  R7 R6 R1    ; R7 = R6 >> 1  => 0x0007

HALT
