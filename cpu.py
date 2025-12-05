"""
Catamount Processing Unit
A toy 16-bit Harvard architecture CPU.

CS 2210 Computer Organization
Clayton Cafiero <cbcafier@uvm.edu>

STARTER CODE
"""

from alu import Alu
from constants import STACK_TOP
from instruction_set import Instruction
from memory import DataMemory, InstructionMemory
from register_file import RegisterFile


class Cpu:
    """
    Catamount Processing Unit
    """

    def __init__(self, *, alu, regs, d_mem, i_mem):
        """
        Constructor
        """
        self._i_mem = i_mem
        self._d_mem = d_mem
        self._regs = regs
        self._alu = alu
        self._pc = 0  # program counter
        self._ir = 0  # instruction register
        self._sp = STACK_TOP  # stack pointer
        self._decoded = Instruction()
        self._halt = False

    @property
    def running(self):
        return not self._halt

    @property
    def pc(self):
        return self._pc

    @property
    def sp(self):
        return self._sp

    @property
    def ir(self):
        return self._ir

    @property
    def decoded(self):
        return self._decoded

    def get_reg(self, r):
        """
        Public accessor (getter) for single register value.
        Added 2025-11-15. Notify students.
        """
        return self._regs.execute(ra=r)[0]

    def tick(self):
        """
        Fetch-decode-execute
        Implementation incomplete.
        """
        if not self._halt:
            self._fetch()
            self._decode()

            # execute...
            match self._decoded.mnem:
                case "LOADI":
                    rd = self._decoded.rd
                    # 8 bit
                    imm8 = self._decoded.imm & 0xFF

                    # Write
                    self._regs.execute(
                        rd = rd,
                        data = imm8,
                        write_enable=True
                    )
                case "LUI":
                    # TODO Refactor for future semester(s) if any.
                    # Cheating for compatibility with released ALU tests
                    # and starter code. Leave as-is for 2025 Fall.
                    rd = self._decoded.rd
                    imm = self._decoded.imm & 0xFF
                    upper = imm << 8
                    lower, _ = self._regs.execute(ra=rd)
                    lower &= 0x00FF  # clear upper bits
                    data = upper | lower
                    self._regs.execute(rd=rd, data=data, write_enable=True)
                case "LOAD":
                    rd = self._decoded.rd
                    ra = self._decoded.ra

                    # Read base register
                    base_val, _ = self._regs.execute(ra=ra)

                    # sign extend
                    offset = self.sext(self._decoded.addr, 6)
                    # Address using aux adder
                    eff_addr = (base_val + offset) & 0xFFFF
                    # read data from memory
                    value = self._d_mem.read(eff_addr)
                    # write to rd
                    self._regs.execute(rd = rd, data = value, write_enable = True)
                case "STORE":
                    ra = self._decoded.ra
                    rb = self._decoded.rb

                    # read ra
                    src_val, _ = self._regs.execute(ra = ra)

                    # read rb
                    base_val, _ = self._regs.execute(ra = rb)

                    # sign extend offset
                    offset = self.sext(self._decoded.addr, 6)

                    # aux adder
                    eff_addr = (base_val + offset) & 0xFFFF

                    # STORE
                    self._d_mem.write(eff_addr, src_val)
                case "ADDI":
                    self._alu.set_op("ADD")
                    rd = self._decoded.rd
                    ra = self._decoded.ra
                    imm = self._decoded.imm & 0xFF

                    original, _ = self._regs.execute(ra=ra)
                    add_val, _ = self._regs.execute(imm=imm)

                    data = original + self.sext(add_val)

                    self._regs.execute(rd=rd, data=data, write_enable=True)
                case "ADD":
                    self._alu.set_op("ADD")
                    rd = self._decoded.rd
                    ra = self._decoded.ra
                    rb = self._decoded.rb

                    data = ra + rb

                    self._regs.execute(rd=rd, data=data, write_enable=True)
                case "SUB":
                    self._alu.set_op("SUB")
                    rd = self._decoded.rd
                    ra = self._decoded.ra
                    rb = self._decoded.rb

                    data = ra - rb

                    self._regs.execute(rd=rd, data=data, write_enable=True)
                # Perform bitwise AND on registers ra and rb - TH
                case "AND":
                    self._alu.set_op("AND")
                    rd = self._decoded.rd
                    ra = self._decoded.ra
                    rb = self._decoded.rb
                    op_a, op_b = self._regs.execute(ra=ra, rb=rb)
                    result = self._alu.execute(op_a, op_b)
                    self._regs.execute(rd=rd, data=result, write_enable=True)
                # ALU op is "OR" - TH
                case "OR":
                    self._alu.set_op("OR")
                    rd = self._decoded.rd
                    ra = self._decoded.ra
                    rb = self._decoded.rb
                    op_a, op_b = self._regs.execute(ra=ra, rb=rb)
                    result = self._alu.execute(op_a, op_b)
                    self._regs.execute(rd=rd, data=result, write_enable=True)
                case "SHFT":
                    self._alu.set_op("SHFT")
                    rd = self._decoded.rd
                    ra = self._decoded.ra
                    rb = self._decoded.rb
                    op_a, op_b = self._regs.execute(ra=ra, rb=rb)
                    result = self._alu.execute(op_a, op_b)
                    self._regs.execute(rd=rd, data=result, write_enable=True)
                case "BEQ":
                    if self._alu.zero:
                        offset = self.sext(self._decoded.imm, 8)
                        self._pc += offset  # take branch
                case "BNE":
                    pass  # complete implementation here
                case "B":
                    pass  # complete implementation here
                case "CALL":
                    self._sp -= 1  # grow stack downward
                    # PC is incremented immediately upon fetch so already
                    # pointing to next instruction, which is return address.
                    ret_addr = self._pc  # explicit
                    self._d_mem.write_enable(True)
                    # push return address...
                    self._d_mem.write(self._sp, ret_addr, from_stack=True)
                    offset = self._decoded.imm
                    self._pc += self.sext(offset, 8)  # jump to target
                case "RET":
                    # Get return address from memory via SP
                    # Increment SP
                    # Update PC
                    pass  # complete implementation here
                case "HALT":
                    pass  # complete implementation here
                case _:  # default
                    raise ValueError(
                        "Unknown mnemonic: " + str(self._decoded) + "\n" + str(self._ir)
                    )

            return True
        return False

    def _decode(self):
        """
        We're effectively delegating decoding to the Instruction class.
        """
        self._decoded = Instruction(raw=self._ir)

    def _fetch(self):
        # Fetch from program counter
        instr = self._i_mem.read(self._pc)

        # Load into instruction register
        self._ir = instr

        # Increment PC need to keep PC 16 bit
        self._pc = (self._pc + 1) & 0xFFFF
        
    def load_program(self, prog):
        self._i_mem.load_program(prog)

    @staticmethod
    def sext(value, bits=16):
        sign_bit = 1 << (bits - 1)
        return (value & (sign_bit - 1)) - (value & sign_bit)


# Helper function
def make_cpu(prog=None):
    alu = Alu()
    d_mem = DataMemory()
    i_mem = InstructionMemory()
    if prog:
        i_mem.load_program(prog)
    regs = RegisterFile()
    return Cpu(alu=alu, d_mem=d_mem, i_mem=i_mem, regs=regs)
