org 0x7c00                      ; BIOS loads our programm at this address

bits 16 

start:

    call print_prompt

    mov CX,0                ;length of input is 0
    mov di, [string]

beginning:

    mov ah,0                ;INT 16,0 reads one key input
    int 16h

    cmp ah,1Ch                  ;1 is the scan code for the Enter key
    je ender

    cmp ah,0Eh                  ;0E is the scan code for the Backspace key
    je backspace

    cmp cx,255                  ; compares if string exceeds limit
    je beginning

    inc cx

    mov [di], al            ; move charater into buffer
    inc di,                  ; increase pointer

    mov ah,0Eh                  ;INT 10,E outputs the character in AL
    int 10h
    jmp beginning

backspace:

    cmp cx,0
    je beginning

    mov al,8                    ;8 is Backspace!
    mov AH,0Eh                  ;INT 10,E outputs the character in AL
    int 10h

    mov AL,20h                  ;20h is Space!
    mov AH,9                    ;INT 10,9 outputs the character in AL without moving the cursor
    int 10h

    dec CX
    dec si 
jmp beginning

ender:

    call rand_nou

    cmp cx,0
    je start

    call rand_nou

    mov di, "0"

    mov ah, 13h             ; 
    mov al, 01h               ; Write mode
    mov bl, 7              ; color
    mov bh, 00h             ; page Number
    mov dl, 0              ; DL = Column 
    mov bp, [string]             ; ES:BP = Offset of string
    int 10h

    call rand_nou

jmp start

rand_nou:
; trece in rand nou
    mov ah,0xe
    mov al,0xa
    int 10h
    mov al,0xd
    inc dh                  ; Dh = row
    int 10h

 .done:
    ret

print_prompt:


    mov ah, 13h             ; 
    mov al, 01h               ; Write mode
    mov bl, 7              ; color
    mov cx, prlen             ; Number of characters in string
    mov bh, 00h             ; page Number
    mov dl, 0              ; DL = Column 
    ; mov dh, 20              ; Dh row 
    mov bp, pr             ; ES:BP = Offset of string
    int 10h

 .done:
    ret


pr db 'he- ', 0
prlen equ $-pr
string times 255 db '', 0

times 510-($-$$) db 0   ; Pad remainder of boot sector with 0s
dw 0xAA55               ; The string to make bootable