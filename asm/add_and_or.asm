; add_and_or.asm
; safe addition using OR
LOADI R0, #0xAA
LOADI R1, #0x55
AND R2, R0, R1
BEQ SAFE           ; if R0 & R1 == 0, safe
LOADI R2, #0       ; unsafe
B END
SAFE:
OR R2, R0, R1
END:
HALT
