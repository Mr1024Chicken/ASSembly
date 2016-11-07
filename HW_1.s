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

    	BL _getchar             @get first number store in R4
    	MOV R4,[R0]

	BL _getchar             @get operand store in R5
    	MOV R5,[R0]

	BL _getchar             @get second number store in R3
    	MOV R3,[R0]

	CMP R5, #'+'
	BEQ _add

    	CMP R5, #'*'
    	BEQ _mul

    	CMP R5, #'-'
    	BEQ _sub

    	CMP R5, #'M'
    	BEQ _max
	
_add:
	add R4, R4, R3
	mov R1,R4
	ldr R0, =.Lout
	bl printf
	b main

_sub:
	sub R4,R3,R4
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
    	AND R0, #0xFFFF           @ mask out all but the lowest 8 bits   ( mask using 0xFF= 0000 0000 0000 0000 0000 0000 1111 1111) taking only the last 8 bit
    	MOV PC, LR              @ return


_prompt:
    	MOV R7, #4              @ write syscall, 4 (R7 is an operation. 4 iswrite, one of R7 funct).
    	MOV R0, #1              @ output stream to monitor, 1  ( which stream to go to ex. #1).
    	MOV R2, #23             @ print string length
    	LDR R1, =prompt_str     @ string at label prompt_str: (R1 system call to print)
    	SWI 0                   @ execute syscall
    	MOV PC, LR              @ return (back to main).



.data 

prompt_str:     .ascii      "Calculator "

.end 