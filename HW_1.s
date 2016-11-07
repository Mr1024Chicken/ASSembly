/*
Calculator 
Programming Assignment #1
*/

.global main
.func main

main:
BL _prompt


_prompt:
    MOV R7, #4              @ write syscall, 4 (R7 is an operation. 4 iswrite, one of R7 funct).
    MOV R0, #1              @ output stream to monitor, 1  ( which stream to go to ex. #1).
    MOV R2, #23             @ print string length
    LDR R1, =prompt_str     @ string at label prompt_str: (R1 system call to print)
    SWI 0                   @ execute syscall
    MOV PC, LR              @ return (back to main).




.data		
prompt_str:	.ascii		"Calculator:\n"	