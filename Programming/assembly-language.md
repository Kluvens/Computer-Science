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

Jump instructions
| instruction | description |
| ----------- | ----------- |
| j           | jump to label |
| jal         | jump and back |
| jr $ra      | jump to return address |

Syscall
| service | $v0 | arguments | returns |
| ------- | --- | --------- | ------- |
| printf("%d") | 1 | int in $a0 | |
| fputs | 4 | string in $a0 | |
| scanf("%d") | 5 | none | int in $v0 |
| fgets | 8 | line in $a0, length in $a1
| exit(0) | 10 | none
| printf("%c") | 11 | char in $a0
| scanf("%c") | 12 | none | char in $v0

Accessing Memory on the MIPS
- addresses are 32 bit
- 1 byte loaded/stored with lb/sb
- 2 bytes called a half-word, loaded/stored with lh/sh
- 4 bytes called a word, loaded/stored with lw/sw

Specifying addresses:
``` mips
sb $t0, x # store $t0 in byte at address labelled x
sb $t1, x+15 # store $t1 15 bytes past address labelled x
sb $t2, x($t3) # store $t2 $t3 bytes past address labelled x
```

MIPS example:
``` mips
# Constants
ARRAY_LEN = 10

main:

	# Registers:
	#   - $t0: int x
	#   - $t1: int i
	#   - $t2: int n_seen
	#   - $t3: temporary result
	#   - $t4: temporary result

slow_loop__init:
	li	$t2, 0				# n_seen = 0;
slow_loop__cond:
	bge	$t2, ARRAY_LEN, slow_loop__end	# while (n_seen < ARRAY_LEN) {

slow_loop__body:
	li	$v0, 4				#   syscall 4: print_string
	la	$a0, prompt_str			#
	syscall					#   printf("Enter a number: ");

	li	$v0, 5				#   syscall 5: read_int
	syscall					#
	move	$t0, $v0			#   scanf("%d", &x);

fast_loop__init:
	li	$t1, 0				#   i = 0
fast_loop__cond:
	bge	$t1, $t2, fast_loop__end	#   while (i < n_seen) {

fast_loop__body:
	mul	$t3, $t1, 4
	lw	$t4, numbers($t3)
	beq	$t4, $t0, slow_loop__cond	#     if (x == numbers[i]) break;

	addi	$t1, $t1, 1			#     i++;
	j	fast_loop__cond			# 
fast_loop__end:					#   }

	bne	$t1, $t2, slow_loop__cond	#   if (i == n_seen) {
	mul	$t3, $t2, 4			#
	sw	$t0, numbers($t3)		#     numbers[n_seen] = x;
	addi	$t2, $t2, 1			#     n_seen++;
	j	slow_loop__cond			#   }
slow_loop__end:					# }

	li	$v0, 4				# syscall 4: print_string
	la	$a0, result_str			#
	syscall					# printf("10th different number was: ");

	li	$v0, 1				# syscall 1: print_int
	move	$a0, $t0			#
	syscall					# printf("%d", x);

	li	$v0, 11				# syscall 11: print_char	
	li	$a0, '\n'			#
	syscall					# putchar('\n');

	li	$v0, 0
	jr	$ra				# return 0;

	.data
numbers:
	.space 4 * ARRAY_LEN			# int numbers[ARRAY_LEN];

prompt_str:
	.asciiz	"Enter a number: "
result_str:
	.asciiz	"10th different number was: "
```

