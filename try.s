/*
Calculator 
Programming Assignment #1
*/

.global main
.func main

.Lout:
	.asciz "%d\n"

main:
	BL _prompt

    	BL _scanf             @get first number store in R4
    	MOV R4,R0

	BL _getchar             @get operand store in R5
    	MOV R3,R0

	BL _scanf             @get second number store in R3
    	MOV R5,R0
	
	BL _mod_unsigned
	
_mod_unsigned:
    cmp R5, R4          @ check to see if R1 >= R2
    MOVHS R0, R4        @ swap R1 and R2 if R2 > R1
    MOVHS R4, R5        @ swap R1 and R2 if R2 > R1
    MOVHS R5, R0        @ swap R1 and R2 if R2 > R1
    MOV R0, #0          @ initialize return value
    B _modloopcheck     @ check to see if
    _modloop:
        ADD R0, R0, #1  @ increment R0
        SUB R4, R4, R5  @ subtract R2 from R1
    _modloopcheck:
        CMP R4, R5      @ check for loop termination
        BHS _modloop    @ continue loop if R1 >= R2
    MOV R0, R4          @ move remainder to R0
    @MOV PC, LR          @ return

_add:
	add R4, R4, R3
	mov R1,R4
	ldr R0, =.Lout
	bl printf
	b main

_sub:
	sub R4,R4,R3
	mov R1,R4
	ldr R0, =.Lout
	bl printf
	b main
_mul:
	mul R4,R3,R4
	mov R1,R4
	ldr R0, =.Lout
	bl printf
	b main
_max:
	CMP R4,R3
	BGT _greater
	BLT _less

_greater: 
	mov R1,R4
	ldr R0, =.Lout
	bl printf
	b main

_less:
	mov R1,R3
	ldr R0, =.Lout
	bl printf
	b main
	
    
_getchar:
    	MOV R7, #3              @ write syscall, 3 (3 is getting something).
    	MOV R0, #0              @ input stream from monitor, 0 
    	MOV R2, #1              @ read a single character
    	LDR R1, =read_char      @ store the character in data memory
    	SWI 0                   @ execute the system call
    	LDR R0, [R1]            @ move the character to the return register
    	AND R0, #0xFF          @ mask out all but the lowest 8 bits   ( mask using 0xFF= 0000 0000 0000 0000 0000 0000 1111 1111) taking only the last 8 bit
    	MOV PC, LR              @ return


_prompt:
	MOV R7, #4              @ write syscall, 4 (R7 is an operation. 4 iswrite, one of R7 funct).
    	MOV R0, #1              @ output stream to monitor, 1  ( which stream to go to ex. #1).
    	MOV R2, #11             @ print string length
   	LDR R1, =prompt_str     @ string at label prompt_str: (R1 system call to print)
    	SWI 0                   @ execute syscall
    	MOV PC, LR              @ return (back to main).

_scanf:
	PUSH {LR}                @ store LR since scanf call overwrites
    	SUB SP, SP, #4          @ make room on stack
    	LDR R0, =format_str     @ R0 contains address of format string
    	MOV R1, SP              @ move SP to R1 to store entry on stack
    	BL scanf                @ call scanf
    	LDR R0, [SP]            @ load value at SP into R0
    	ADD SP, SP, #4          @ restore the stack pointer
    	POP {PC}                 @ return

.data 

prompt_str:     .ascii	"Calculator:\n "
read_char:	.ascii	" "
format_str:	.ascii	"%d"	
.end 