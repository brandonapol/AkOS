;
; A simple boot sector program that demonstrates the stack.
;

mov ah, 0x0e                ; int 10/ ah = 0eh -> scrolling teletype BIOS routine

mov bp 0x8000               ; Set the base of the stack a little above where BIOS 
mov sp, bp                  ; loads the boot sector so it won't overwrite

push 'A'                    ; 16-bit values - translates to ASCII since the 
push 'B'                    ; stack only takes 16-bit values to the registers
push 'C'

pop bx                      ; pop 16 bit, copy bl to al and interrupt to print 
mov al, bl                  ; bl is 8 bit 
int 0x10

pop bx                      ; do it again with next value 
mov al, bl 
int 0x10

mov al, [0x7ffe]            ; fetch char two bytes beneath 0x8000 (where we set 
                            ; the stack to begin) to show stack growing down
int 0x10

jmp $

times 510-($-$$) db 0
dw 0xaa55