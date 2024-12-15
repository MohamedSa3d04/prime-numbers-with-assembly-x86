.MODEL SMALL
.DATA
NPRIME DB " NOT PRIME",10,"$"
PRIME DB " IS PRIME",10,"$"
Buffer DB 6 DUP(0), '$'  
Temp DB 6 DUP(0)  
COUNTER DB ?


.CODE
    MAIN PROC FAR
        .STARTUP
        MOV CH, 0
        MOV CL , 100
        
        
        LOP:
            MOV BL, 2
            CMP CL, 2
            JLE OF
            
            CHECK:

            CMP BL, CL
            JGE PRIME_
            
            MOV AL, CL
            MOV AH, 0
            DIV BL
            
            CMP AH, 0
            JE NOTPRIME
            
            ADD BL, 1
            JMP CHECK
            
            
            PRIME_:
                
                MOV COUNTER, CL
                MOV AX, CX
                CALL PRINTNUM
                
                
                LEA DX, PRIME
                CALL PRINT
                JMP O
            NOTPRIME:
                MOV COUNTER, CL
                MOV AX, CX
                CALL PRINTNUM
                
                
                LEA DX, NPRIME
                CALL PRINT
                JMP O
            OF:
                .EXIT
            O:
              
        MOV CL, COUNTER     
        LOOP LOP
        .EXIT
    MAIN ENDP
    
    PRINT PROC NEAR
      MOV AH, 9H
      INT 21H
      
    RET
      
    PRINTNUM PROC NEAR
        
        LEA SI, Temp             
        XOR CX, CX               

    ConvertLoop:
        XOR DX, DX               
        MOV BX, 10               
        DIV BX                  
        ADD DL, '0'              
        MOV [SI], DL             
        INC SI                   
        INC CX                   
        CMP AX, 0                
        JNE ConvertLoop          

        ; Reverse the string to correct order
        LEA DI, Buffer           
        DEC SI                  
    ReverseLoop:
        MOV AL, [SI]           
        MOV [DI], AL            
        INC DI                 
        DEC SI                   
        LOOP ReverseLoop         

        ; Add string terminator
        MOV BYTE PTR [DI], '$'   

        ; Print the string
        LEA DX, Buffer           
        MOV AH, 9                
        INT 21H                  

        RET
   
END MAIN

