; GDT
gdt_start:

gdt_null:       ; mandatory null descriptor
    dd 0x0      ; 'define double' word (4 bytes)
    dd 0x0

gdt_code:       ; code segment
    ; base = 0x0, limit 0xfffff, 
    ; 1st flags: (present)1 (privelege)00 (descriptor type)1 -> 1001b
    ; type flags: (code)1 (conforming)0 (readable)1 (accessed)0 -> 1010b
    ; 2nd flags: (granularity)1 (32bit default)1 (64-bit seg)0 (AVL)0 -> 1100b
    dw 0xffff   ; limit (bits 0-15)
    dw 0x0      ; Base (bits 0-15)
    db 0x0      ; Base (bits 16-23)
    db 10011010b    ; 1st flags, type flags
    db 11001111b    ; 2nd flags, limit (bits 16-19)
    db 0x0      ; Base (bits 24-31)

gdt_data:       ; data segment
    ; same as code segment, except for type flags
    ; type flags: (code)0 (expand down)0 (writeable)1 (accessed)0 -> 0010b
    dw 0xffff
    dw 0x0
    db 0x0
    db 10010010b
    db 11001111b
    db 0x0

gdt_end:        ; Label is for assembler calculating size of GDT for GDT descriptor

gdt_descriptor:
    dw gdt_end - gdt_start - 1      ; Size of GDT always one less than true size

    dd gdt_start                    ; start address

; Define constants for GDT segment descriptor offsets - registers must contain 
; them when in protected mode
CODE_SEG equ gdt_code - gdt_start
DATA_SEG equ gdt_data - gdt_start