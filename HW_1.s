/*
Calculator 
Programming Assignment #1
*/

.global main
.func main

main:
    BL _prompt
    B _exit


_prompt:
    MOV R7, #4              @ write syscall, 4 (R7 is an operation. 4 iswrite, one of R7 funct).
    MOV R0, #1              @ output stream to monitor, 1  ( which stream to go to ex. #1).
    MOV R2, #23             @ print string length
    LDR R1, =prompt_str     @ string at label prompt_str: (R1 system call to print)
    SWI 0                   @ execute syscall
    MOV PC, LR              @ return (back to main).

_exit:  
    MOV R7, #4              @ write syscall, 4  
    MOV R0, #1              @ output stream to monitor, 1
    MOV R2, #21             @ print string length
    LDR R1, =exit_str       @ string at label exit_str:
    SWI 0                   @ execute syscall
    MOV R7, #1              @ terminate syscall, 1
    SWI 0                   @ execute syscall


.data		
read_char:      .ascii      " "
prompt_str:     .ascii      "Enter the @ character: "
equal_str:      .asciz      "CORRECT \n"
nequal_str:     .asciz      "INCORRECT: %c \n"
exit_str:       .ascii      "Terminating program.\n"