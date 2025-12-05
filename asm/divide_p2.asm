; divide_p2.asm - divide 448 by powers of 2

; Initialize R0 with 448
LOADI R0 0xC0       ; lower byte
LUI  R0 0x01        ; upper byte → R0 = 0x01C0 = 448

LOADI R1 0x06       ; lower byte shift amount
LUI  R1 0x80        ; upper byte → R1 = 0x8006

SHFT R2 R0 R1       ; R2 = R0 >> 1 = 224
SHFT R3 R2 R1       ; R3 = R2 >> 1 = 112
SHFT R4 R3 R1       ; R4 = R3 >> 1 = 56
SHFT R5 R4 R1       ; R5 = R4 >> 1 = 28
SHFT R6 R5 R1       ; R6 = R5 >> 1 = 14
SHFT R7 R6 R1       ; R7 = R6 >> 1 = 7

ADDI R0 R0 0        ; placeholder
ADDI R1 R1 0        ; placeholder
ADDI R2 R2 0        ; placeholder
ADDI R3 R3 0        ; placeholder
ADDI R4 R4 0        ; placeholder

HALT
