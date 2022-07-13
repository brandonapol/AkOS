; Read some sectors from the boot disk using our disk_read function
[ org 0x7c00 ]

    mov [ BOOT_DRIVE ], dl ; save DL for boot drive location
    mov bp, 0x8000         ; put stack in safe location 
    mov sp, bp 

    mov bx, 0x9000         ; load 5 sectors between 0x0000 and 0x9000 (ES:BX)
    mov dh, 5
    mov dl, [ BOOT_DRIVE ]
    call disk_load 

   mov dx , [0x9000 ]     ; print first loaded word (declared at bottom)
   call print_hex 

   mov dx [0x9000 + 512]  ; print second loaded word (second sector)
   call print_hex 

   jmp $                  ; loop 
   % include "../helpers/print_hex.asm"
   % include "../helpers/print.asm"
   % include "disk.asm"

   BOOT_DRIVE: db 0

   times 510-($-$$) db 0
   dw 0xaa55

   ; We know that BIOS will load only the first 512 - byte sector from the disk ,
   ; so if we purposely add a few more sectors to our code by repeating some
   ; familiar numbers , we can prove to ourselves that we actually loaded those
   ; additional two sectors from the disk we booted from.
   times 256 dw 0 xdada
   times 256 dw 0 xface
