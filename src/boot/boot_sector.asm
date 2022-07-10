; Read some sectors from the boot disk using our disk_read function
[ org 0x7c00 ]

    mov [ BOOT_DRIVE ], dl ; save DL for boot drive location
    mov bp, 0x8000         ; put stack in safe location 
    mov sp, bp 

    mov bx, 0x9000         ; load 5 sectors between 0x0000 and 0x9000 (ES:BX)
    mov dh, 5
    mov dl, [ BOOT_DRIVE ]
    call disk_load 

    ; finish from page 33