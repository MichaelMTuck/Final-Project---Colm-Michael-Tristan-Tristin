; add_and_or.asm - TH


 LOADI R0 0xAA     ; operand A
 LOADI R1 0x55     ; operand B
 LOADI R4 0x00     ; zero register

 AND   R3 R0 R1    ; R3 = R0 & R1  -> zero if safe

 BEQ   R3 R4 safe  ; if R3 == 0, no overlapping bits -> safe
 LOADI R2 0x00     ; not safe: store 0 in R2
 B     end

 safe:
 OR    R2 R0 R1    ; safe: result is OR

 end:
 HALT
