; add_and_or.asm - TH

LOADI R0 #0xAA
LOADI R1 #0x55

; R3 = R0 & R1  (if R3 == 0 then safe)
AND R3 R0 R1
BEQ R3 safe      ; if zero -> safe

; not safe -> R2 = 0
LOADI R2
B done

safe:
OR R2 R0 R1      ; safe case: R2 = R0 | R1

done:
HALT
