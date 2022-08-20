[org 0x7c00]

KERNEL_OFFSET equ 0x1000

    mov [BOOT_DRIVE], dl        ; BIOS sets boot drive in dl
    mov bp, 0x9000
    mov sp, bp

    mov bx, MSG_REAL_MODE 
    call print
    call printNewline

    ; Read the kernel from disk
    call loadKernel
    ; Disable interrupts, load GDT, etc. Finally jumps to 'BEGIN_PROTECTED_MODE'
    call switchToProtectedMode
    ; Never executed
    jmp $

%include "src/boot/helpers/print.asm"
%include "src/boot/helpers/print_hex.asm"
%include "src/boot/disk.asm"
%include "src/boot/32_bit/gdt.asm"
%include "src/boot/helpers/32_bit/32_bit_print.asm"
%include "src/boot/32_bit/switch_protected_mode.asm"

[bits 16]
loadKernel:
    mov bx, MSG_LOAD_KERNEL
    call print
    call printNewline

    ; Read from disk and store in 0x1000
    mov bx, KERNEL_OFFSET
    ; The future kernel will be larger, make this big
    mov dh, 16
    mov dl, [BOOT_DRIVE]
    call diskLoad

    ret

[bits 32]
BEGIN_PROTECTED_MODE:
    mov ebx, MSG_PROTECTED_MODE
    call printStringProtectedMode
    ; Give control to the kernel
    call KERNEL_OFFSET

    ; Stay here indefinitely in case kernel dies
    jmp $

; It is a good idea to store it in memory because 'dl' may get overwritten
BOOT_DRIVE db 0
MSG_REAL_MODE db "Started in 16-bit Real Mode", 0
MSG_PROTECTED_MODE db "Landed in 32-bit Protected Mode", 0
MSG_LOAD_KERNEL db "Loading kernel into memory", 0

; We know that BIOS will load only the first 512 - byte sector from the disk ,
; so if we purposely add a few more sectors to our code by repeating some
; familiar numbers , we can prove to ourselves that we actually loaded those
; additional two sectors from the disk we booted from.
times 510 - ($-$$) db 0
dw 0xaa55