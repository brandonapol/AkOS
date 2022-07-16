[bits 16]

switchToProtectedMode:
    cli         ; stops/disables interrupts
    lgdt [gdt_descriptor]       ; load GDT descriptor
    mov eax, cr0        ; set 32-bit mode in cr0
    or eax, 0x1
    mov cr0, eax        ; jump using different segment
    jmp CODE_SEG:init_protected_mode

[bits 32]       ; now using 32 bit instructions

init_protected_mode:
    mov ax, DATA_SEG
    mov ds, ax
    mov ss, ax
    mov es, ax
    mov fs, ax
    mov gs, ax          ; update segment registers

    ; update stack right at top of free space
    mov ebp, 0x90000
    mov esp, ebp

    ; call well-known label with useable code
    call BEGIN_PROTECTED_MODE