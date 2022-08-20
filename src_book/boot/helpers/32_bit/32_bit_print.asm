[bits 32]  ; 32-bit protected mode

VIDEO_MEMORY equ 0 xb8000           ; define some constants
WHITE_ON_BLACK equ 0 x0f

printStringPM :
    pusha
    mov edx , VIDEO_MEMORY 

printStringPMLoop:
    mov al, [ebx]       ; Store char at ebx in al
    ov ah, WHITE_ON_BLACK   ; store attributes at ah

    cmp al, 0               ; check for end of string
    je done

    mov [edx], ax

    add ebx, 1              ; increment char in string
    add edx, 2

    jmp printStringPMLoop


printStringPMDone:
    popa
    ret

