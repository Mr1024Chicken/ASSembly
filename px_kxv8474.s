.global main
.func main
   
main:
	BL  _prompt            
	
	BL  _scanf             

	VMOV S0, R0            
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
    MOV R7, #4           
    MOV R0, #1              
    MOV R2, #21          
    LDR R1, =exit_str       
    SWI 0                  
    MOV R7, #1              
    SWI 0                  

_prompt:
    MOV R7, #4              
    MOV R0, #1              
    MOV R2, #11             
    LDR R1, =prompt_str    
    SWI 0                   
    MOV PC, LR             
       
_printf:
    PUSH {LR}             
    LDR R0, =printf_str     
    BL printf               
    POP {PC}                

   _getchar:
    MOV R7, #3         
    MOV R0, #0              
    MOV R2, #1              
    LDR R1, =read_char      
    SWI 0                 
    LDR R0, [R1]            
    AND R0, #0xFF           
    MOV PC, LR             

_scanf:
    PUSH {LR}               
    SUB SP, SP, #4       
    LDR R0, =format_str     
    MOV R1, SP             
    BL scanf              
    LDR R0, [SP]            
    ADD SP, SP, #4        
    POP {PC}                

_scanf_norm:
    PUSH {LR}                
    SUB SP, SP, #4        
    LDR R0, =format_norm     
    MOV R1, SP              
    BL scanf               
    LDR R0, [SP]           
    ADD SP, SP, #4         
    POP {PC}                 

.data
read_char:      .ascii      " "
format_str:     .asciz      "%f"
format_norm:	.asciz	    "%d"
prompt_str:     .asciz      "Calculator: "
printf_str:     .asciz      "The number entered was: %f\n\0"
exit_str:       .ascii      "Terminating program.\n"
