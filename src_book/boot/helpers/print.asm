print:
    pusha

start:
    mov al, [bx] ; 'bx' is the base address for the string
    cmp al, 0    ; compare string end to null byte for terminating process
                 ; if char is 0 move to done otherwise increment and repeat loop
    je done


    mov ah, 0x0e    ; use BIOS interrupt to print 
    int 0x10        ; spits out al 

    add bx, 1
    jmp start

done:
    popa        ; exit stack and return 
    ret



printNewline:
    pusha
    
    mov ah, 0x0e
    mov al, 0x0a ; newline char
    int 0x10
    mov al, 0x0d ; carriage return
    int 0x10
    
    popa
    ret