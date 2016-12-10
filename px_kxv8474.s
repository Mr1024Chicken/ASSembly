.global main
.func main
   
main:
	BL  _prompt             @ branch to prompt procedure with return
	
	BL  _scanf              @ branch to scanf procedure with return

	VMOV S0, R0             @ move return value R0 to FPU register S0

	BL _getchar
    	MOV R2,R0
	
	CMP R2, #'a'
	BEQ _ABS
 	
	CMP R2 ,#'p'
	BEQ _POW

	CMP R2,#'s'
	BEQ _SQRT

	CMP R2, #'i'
	BEQ _INV

	B   _exit              
   
_ABS: 
        VABS.F32 S0,S0	
    	VCVT.F64.F32 D1, S0     
  	VMOV R1, R2, D1         
   	BL  _printf              
	B main

_POW:
	
	BL _scanf_norm
	MOV R3,R0
	MOV R1, #1
	VMOV S1,S0
		loop:
			CMP R1,R3
			BEQ _done
			VMUL.F32 S0, S0, S1
			ADD R1,#1
			B loop
		_done:
			VCVT.F64.F32 D1, S0     
  			VMOV R1, R2, D1     
			BL _printf
			B main
_SQRT:
	VSQRT.F32 S0,S0	
    	VCVT.F64.F32 D1, S0     
  	VMOV R1, R2, D1         
   	BL  _printf              
	B main
_INV:
	 MOV R1,#1
	VMOV S2,R1
	VCVT.F32.U32 S2,S2
	VDIV.F32 S0, S2, S0

	VCVT.F64.F32 D1, S0     
  	VMOV R1, R2, D1         
   	BL  _printf              
	B main

_exit:  
    MOV R7, #4              @ write syscall, 4
    MOV R0, #1              @ output stream to monitor, 1
    MOV R2, #21             @ print string length
    LDR R1, =exit_str       @ string at label exit_str:
    SWI 0                   @ execute syscall
    MOV R7, #1              @ terminate syscall, 1
    SWI 0                   @ execute syscall

_prompt:
    MOV R7, #4              @ write syscall, 4
    MOV R0, #1              @ output stream to monitor, 1
    MOV R2, #11             @ print string length
    LDR R1, =prompt_str     @ string at label prompt_str:
    SWI 0                   @ execute syscall
    MOV PC, LR              @ return
       
_printf:
    PUSH {LR}               @ push LR to stack
    LDR R0, =printf_str     @ R0 contains formatted string address
    BL printf               @ call printf
    POP {PC}                @ pop LR from stack and return

   _getchar:
    MOV R7, #3              @ write syscall, 3
    MOV R0, #0              @ input stream from monitor, 0
    MOV R2, #1              @ read a single character
    LDR R1, =read_char      @ store the character in data memory
    SWI 0                   @ execute the system call
    LDR R0, [R1]            @ move the character to the return register
    AND R0, #0xFF           @ mask out all but the lowest 8 bits
    MOV PC, LR              @ return

_scanf:
    PUSH {LR}               @ store LR since scanf call overwrites
    SUB SP, SP, #4          @ make room on stack
    LDR R0, =format_str     @ R0 contains address of format string
    MOV R1, SP              @ move SP to R1 to store entry on stack
    BL scanf                @ call scanf
    LDR R0, [SP]            @ load value at SP into R0
    ADD SP, SP, #4          @ restore the stack pointer
    POP {PC}                @ return

_scanf_norm:
    PUSH {LR}                @ store LR since scanf call overwrites
    SUB SP, SP, #4          @ make room on stack
    LDR R0, =format_norm     @ R0 contains address of format string
    MOV R1, SP              @ move SP to R1 to store entry on stack
    BL scanf                @ call scanf
    LDR R0, [SP]            @ load value at SP into R0
    ADD SP, SP, #4          @ restore the stack pointer
    POP {PC}                 @ return

.data
read_char:      .ascii      " "
format_str:     .asciz      "%f"
format_norm:	.asciz	"%d"
prompt_str:     .asciz      "Calculator: "
printf_str:     .asciz      "The number entered was: %f\n\0"
exit_str:       .ascii      "Terminating program.\n"
