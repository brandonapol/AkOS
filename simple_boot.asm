;
; A simple looping boot sector program
;

loop:                   ; start a loop - this is a label that we can jump back to forever

    jmp loop            ; Jump to a new memory address to continue execution


times 510-($-$$) db 0   ; allocate memory for the compiled code - 
                        ; should be less than 512 bytes, minus two for the last 
                        ; command

dw 0xaa55