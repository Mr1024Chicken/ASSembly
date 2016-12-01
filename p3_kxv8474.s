.global main
.func main
  
.min:
	.ascii	"min = %d"
main:
    BL _seedrand            @ seed random number generator with current time
    MOV R0, #0              @ initialze index variable
writeloop:
    CMP R0, #10            @ check to see if we are done iterating
    BEQ writedone           @ exit loop if done
    LDR R1, =a              @ get address of a
    LSL R2, R0, #2          @ multiply index*4 to get array offset
    ADD R2, R1, R2          @ R2 now has the element address
    PUSH {R0}               @ backup iterator before procedure call
    PUSH {R2}               @ backup element address before procedure call
    BL _getrand             @ get a random number
    MOV R4,R0
    MOV R5,#1000
    BL _mod_unsigned
    
    POP {R2}                @ restore element address
    STR R0, [R2]            @ write the address of a[i] to a[i]
    POP {R0}                @ restore iterator
    ADD R0, R0, #1          @ increment index
    B   writeloop           @ branch to next loop iteration
writedone:
    MOV R0, #0              @ initialze index variable
readloop:
    CMP R0, #10             @ check to see if we are done iterating
    BEQ readdone            @ exit loop if done
    LDR R1, =a              @ get address of a
    LSL R2, R0, #2          @ multiply index*4 to get array offset
    ADD R2, R1, R2          @ R2 now has the element address
    LDR R1, [R2]            @ read the array at address 
    PUSH {R0}               @ backup register before printf
    PUSH {R1}               @ backup register before printf
    PUSH {R2}               @ backup register before printf
    MOV R2, R1              @ move array value to R2 for printf
    MOV R1, R0              @ move array index to R1 for printf
    BL  _printf             @ branch to print procedure with return
    POP {R2}                @ restore register
    POP {R1}                @ restore register
    POP {R0}                @ restore register
    ADD R0, R0, #1          @ increment index
    B   readloop            @ branch to next loop iteration
readdone:
    bl _max

    bl _min

    B _exit                 @ exit if done
    
_exit:  
    MOV R7, #4              @ write syscall, 4
    MOV R0, #1              @ output stream to monitor, 1
    MOV R2, #21             @ print string length
    LDR R1, =exit_str       @ string at label exit_str:
    SWI 0                   @ execute syscall
    MOV R7, #1              @ terminate syscall, 1
    SWI 0                   @ execute syscall
       
_printf:
    PUSH {LR}               @ store the return address
    LDR R0, =printf_str     @ R0 contains formatted string address
    BL printf               @ call printf
    POP {PC}                @ restore the stack pointer and return
    
_seedrand:
    PUSH {LR}               @ backup return address
    MOV R0, #0              @ pass 0 as argument to time call
    BL time                 @ get system time
    MOV R1, R0              @ pass sytem time as argument to srand
    BL srand                @ seed the random number generator

    POP {PC}                @ return 
    
_getrand:
    PUSH {LR}               @ backup return address
    BL rand                 @ get a random number
    POP {PC}                @ return 
   
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
    MOV PC, LR          @ return
_max:
	push {LR}
	mov r0,#0
	mov r2,#0
	ldr r1,=a
	ldr r1,[r1]
	mov r4,r1
	_compare_greater:
		cmp r0,#10
		beq done
		ldr r1,=a
		lsl r2,r0,#2
    		add r2,r1,r2
		ldr r1,[r2]
		mov r5,r1
		cmp r5,r4
		movhs r4,r5
		add r0,#1
		b _compare_greater
	done:
		mov r1,r4
		ldr r0,=max
    		bl printf
		pop {PC}
_min:
		push {LR}
	mov r0,#0
	mov r2,#0
	ldr r1,=a
	ldr r1,[r1]
	mov r4,r1
	_compare_less:
		cmp r0,#10
		beq ok
		ldr r1,=a
		lsl r2,r0,#2
    		add r2,r1,r2
		ldr r1,[r2]
		mov r5,r1
		cmp r4,r5
		movhs r4,r5
		add r0,#1
		b _compare_less
	ok:

		mov r1,r4
    		ldr r0,=min
    		bl printf
		pop {PC}	
	
.data

.balign 4
a:              .skip       40
printf_str:     .asciz      "a[%d] = %d\n"
debug_str:
.asciz "R%-2d   0x%08X  %011d \n"
exit_str:       .ascii      "Terminating program.\n"
min:		.ascii	    "min = %d.\n\0/0"
max:		.asciz	    "max = %d.\n"
.end
