;
; A simple boot sector program to learn addressing
; Will run several variations on a similar code to check behavior
;

mov ah, 0x0e                    ; BIOS routine 

; First attempt 
mov al, the_secret
int 0x10

; Second attempt 
mov al, [the_secret]
int 0x10

; Third attempt 
mov bx, the_secret 
add bx, 0x7c00
mov al, [bx]
int 0x10

; Fourth attempt 
mov al, [0x7c00]
int 0x10

jmp $                           ; Jump forever 

the_secret:
db "X"

; Padding and magic BIOS boot number 

times 510-($-$$) db 0
dw 0xaa55