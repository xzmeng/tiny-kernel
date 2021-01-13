org 0x7c00

; set ss: sp and es
mov ax, cs
mov ss, ax
mov sp, 0x7c00

; set the es as the start of video memory(text mode)
mov ax, 0xb800
mov es, ax


;-------clear screen--------
mov ah, 06h ; scroll up
mov al, 00h ; whole screen
mov ch, 0h ; left-up row
mov cl, 0h ; left-up col
mov dh, 24 ; rigth-down row
mov dl, 79 ; right-down col
int 10h

;-------print hello,world-------
mov byte [es:00h], 'h'
mov byte [es:01h], 00001110b ;blak bg; yellow font
mov byte [es:02h], 'w'
mov byte [es:03h], 00001110b ;blak bg; yellow font

jmp $

times 510-($-$$) db 0
db 0x55, 0xaa