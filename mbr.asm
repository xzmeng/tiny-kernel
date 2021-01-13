section dummy vstart=0x7c00

; set ss: sp
mov ax, cs
mov ss, ax
mov es, ax
mov sp, 0x7c00


;-------clear screen--------
mov ah, 06h ; scroll up
mov al, 00h ; whole screen
mov ch, 0h ; left-up row
mov cl, 0h ; left-up col
mov dh, 24 ; rigth-down row
mov dl, 79 ; right-down col
int 10h

;-------print hello,world-------
mov ah, 13h
mov al, 00000001b ; bit 0: update cursor after writing
mov bh, 0h ; page 0
mov bl, 00001110b ; 0000 black bg, 1110 yellow font
mov cx, 12 ; len(string)
mov dx, 0 ; print start from (0, 0)
mov bp, string
int 0x10

jmp $

string db "hello,world!"

times 510-($-$$) db 0
db 0x55, 0xaa