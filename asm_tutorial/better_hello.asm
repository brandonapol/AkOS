;
; A simple boot sector that uses a BIOS routine to print a message
;

mov ah, 0x0e                ; int 10/ ah = 0eh -> scrolling teletype BIOS routine

mov al, 'H'
int 0x10
mov al, 'e'
int 0x10
mov al, 'l'
int 0x10
mov al, 'l'
int 0x10
move al, 'o'
int 0x10

jmp $                       ; jump to current address (indefinitely)

;
; Padding and magic BIOS num 
;

times 510-($-$$) db 0 

dw 0xaa55

