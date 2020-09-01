org 0x7C00                      ; BIOS loads our programm at this address
bits 16 

start:

    mov si, hello1     ; Put string position into SI
    call print_hello1       ; Call our string-printing routine
    call print_hello2

    call print_hello3
    call print_hello4
   
   hello1 db 'salut World!', 0
   msg db 'halo ', 0
   len equ $ - msg


print_hello1:                   ; Routine: output string in SI to screen

 .repeat:                   ;AL = Character
    mov ah, 09h             ; int 10h 'print char' function
    mov bh, 0x00            ; Page Number
    mov bl, 0x03            ; Color
    mov cx, 01h             ; Number of times to print character

    lodsb                   ; Get character from string, from  si to al
    cmp al, 0               ; check if character is 0 (end of string) 
    je .done                ; If char is zero, end of string
    int 10h                 ; Otherwise, print it

   ;  mov bh, 00h           ; page 
    mov ah, 03h             ; Get cursor position and shape
    int 10h
    mov ah, 02h             ; Set cursor position
    mov bh, 00h             ; page Number
    inc dh                  ; DL = Column
    int 10h
    jmp .repeat

 .done:
    ret

print_hello2:                  

    mov ah, 02h             ; Set cursor position
    mov bh, 00h             ; page Number
    mov dl, 7               ; DL = Column 
    mov dh, 12               ; DH = Row
    int 10h

   mov ah, 0Ah
   mov bh, 0x00            ; Page Number
   mov cx, 03h             ; Number of times to print character
   mov al, '3'             ; character to print
   int 10h

 .done:
    ret

print_hello3:                   

   mov ah, 02h             ; Set cursor position
    mov bh, 00h             ; page Number
    mov dl, 7               ; DL = Column 
    mov dh, 15               ; DH = Row
    int 10h

   mov ah, 0Eh
   mov bh, 0x00            ; Page Number
   ; mov bl, 04h
   mov cx, 01h             ; Number of times to print character
   mov al, '5'
   int 10h


 .done:
    ret

print_hello4:                  

   mov ah, 13h             ; 
   mov al, 01h               ; Write mode
   mov bh, 0x00            ; Page Number
   mov bl, 89              ; color
   mov cx, len             ; Number of characters in string
   mov bh, 00h             ; page Number
   mov dl, 10              ; DL = Column 
   
   mov bp, msg             ; ES:BP = Offset of string
   int 10h

 .done:
    ret

times 510-($-$$) db 0   ; Pad remainder of boot sector with 0s
dw 0xAA55               ; The string to make bootable