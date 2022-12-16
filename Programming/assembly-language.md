CPU components:
- a set of data registers
- a set of control registers
- a control unit (CU)
- an arithmetic-logic unit (ALU)
- a floating-point unit (FPU)
- caches
  - caches normally range from L1 to L3
  - sometimes separate data and instruction caches
- access to memory (RAM)
  - address generation unit (AGU)
  - memory management unit (MMU)
- a set of simple instructions
  - transfer data between memory and registers
  - compute values using ALU/FPU
  - make tests and transfer control of execution

Fetch-Execute Cycle tells executing an instruction involves:
- determine what the operator is
- determine if/which registers are involved
- determine if/which memory location is involved
- carry out the operation with the relevant operands
- store result, if any, in appropriate register/memory location

``` mips
addi$t0,$zero,6   #$t0=6 
addi$t5,$t0,2     #$t5=8 
mul$t4,$t0,$t5    #$t4=48 
add$t4,$t4,$t5    #$t4=56 
addi$t6,$t4,-12   #$t6=42
```

![image](https://user-images.githubusercontent.com/95273765/207996927-3fb1d627-6918-4e45-bb14-a2f49f1e9c8c.png)

Instructions
| Instruction | Description | More |
| ----------- | ----------- | ---- |
| ADD         | Rd = Rs + Rt |  may cause integer overflow |
| ADDI        | Rt = Rs + integer | may cause integer overflow |
| ADDU        | Rd = Rs + Rt | |
| ADDIU       | Rt = Rs + integer | |
| SUB         | Rd = Rs - Rt | may cause integer overflow |
| SUBU        | Rd = Rs - Rt | |
| MUL         | Rd = Rs * Rt | |
| DIV         | Lo = Rs/Rt; Hi = Rs%Rt | |
| DIVU        | Lo = Rs/Rt; Hi = Rs%Rt | |
| REM         | Rd = Rs % Rt | |
| SEQ         | Rd = Rs == Rt | |
| SNE         | Rd = Rs != Rt | |
| SLE         | Rd = Rs <= Rt | |
| SLT         | Rd = Rs < Rt | |
| SGT         | Rd = Rs > Rt | |
| SGE         | Rd = Rs >= Rt | |
| SLTI        | Rt = Rs < integer | |
| ABS         | Rt = \|Rs\| | |
| AND         | Rd = Rs & Rt| |
| ANDI        | Rd = Rs & integer | |
| OR          | Rd = Rs \| Rt | |
| ORI         | Rt = Rs \| integer | |
| XOR         | Rd = Rs ^ Rt | |
| NOR         | Rd = ~(Rs | Rt) | |
| NOT         | Rd = ~Rs | |
| SLLV        | Rd = Rt << Rs | |
| SRLV        | Rd = Rt >> Rs | |
| SLL         | Rd = Rt << integer | |
| SRL         | Rd = Rt >> integer | |
| LI          | Rt = integer | |
| LA          | Rt = label | |
| MFHI        | Rd = HI | |
| MFLO        | Rd = LO | |
| MOVE        | Rt = Rs | |
| LUI         | Rt = integer * 65536 | |
| syscall     | system call | |

Branch instructions
| instruction | description |
| ----------- | ----------- |
| b           | go to label |
| beq         | if (Rs == R) then go to label |
| bne         | if (Rs != R) then go to label |
| ble         | if (Rs <= R) then go to label |
| blt         | if (Rs < R) then go to label |
| bge         | if (Rs >= R) then go to label |
| bgt         | if (Rs > R) then go to label |


