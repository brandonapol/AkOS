;
; Load DH disk sectors to ES:BX from DL 
;

disk_load:
    push dx                         ; push dx on stack to recall sector request
                                    ; count later even if we change it 
    mov ah, 0x02                    ; BIOS read
    mov al, dh                      ; Read DH sectors 
    mov ch, 0x00                    ; Select cylinder 0
    mov dh, 0x00                    ; Select head 0
    mov cl, 0x02                    ; select second sector (after boot sector)
    int 0x13                        ; BIOS interrupt 

    jc disk_error                   ; Jump if error (flag)

    pop dx                          ; Restore DX from stack 
    cmp dx, al                      ; see if sectors read equal to expected
    jne disk_error

    ret 

disk_error:

    mov bx, DISK_ERROR
    call print 
    jmp $

; variables
DISK_ERROR db "Disk read error", 0