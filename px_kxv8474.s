.global main
.func main

main:
	BL _scanf
	MOV R3,R0

	BL _getchar 
	MOV R2,R0

	CMP R2, #'a'
	BEQ _ABS
	CMP R2, #'p'
	CMP R2, #'i'
	CMP R2, #'s'
	


_getchar:
    	MOV R7, #3              @ write syscall, 3 (3 is getting something).
    	MOV R0, #0              @ input stream from monitor, 0 
    	MOV R2, #1              @ read a single character
    	LDR R1, =read_char      @ store the character in data memory
    	SWI 0                   @ execute the system call
    	LDR R0, [R1]            @ move the character to the return register
    	AND R0, #0xFF          @ mask out all but the lowest 8 bits   ( mask using 0xFF= 0000 0000 0000 0000 0000 0000 1111 1111) taking only the last 8 bit
    	MOV PC, LR              @ return

_scanf:
	PUSH {LR}                @ store LR since scanf call overwrites
    	SUB SP, SP, #4          @ make room on stack
    	LDR R0, =format_str     @ R0 contains address of format string
    	MOV R1, SP              @ move SP to R1 to store entry on stack
    	BL scanf                @ call scanf
    	LDR R0, [SP]            @ load value at SP into R0
    	ADD SP, SP, #4          @ restore the stack pointer
    	POP {PC}                 @ return
_ABS:
	CMP R3, #0
	BLT _less
	
	#MOV R1,R0
	MOV R1, R3
	LDR R0, =awr
	BL printf
	B main

		_less:
			MOV R1, #-1
			MUL R3, R3, R1
			MOV PC,LR


.data 

prompt_str:     .ascii	"Calculator:\n "
read_char:	.ascii	" "
format_str:	.ascii	"%f"
awr:		.asciz	"Answer is %f \n"	
.end 
