org 0x7c00

; set ss: sp and es
mov ax, 0
mov ss, ax
mov ds, ax
mov sp, 0x7c00

; set the es as the start of video memory(text mode)
mov ax, 0xb800
mov es, ax


;-------clear screen--------
mov ah, 0x06 ; scroll up
mov al, 0x00 ; whole screen
mov ch, 0x00 ; left-up row
mov cl, 0x00 ; left-up col
mov dh, 24 ; rigth-down row
mov dl, 79 ; right-down col
int 10h

;--------load program and jmp--------
PROGRAM_LBA equ 1
PROGRAM_LOAD_ADDR equ 0x900
READ_SECTOR_COUNT equ 1

mov eax, PROGRAM_LBA ; sector LBA (28 bit, so use eax)
mov bx, PROGRAM_LOAD_ADDR
mov cl, READ_SECTOR_COUNT

call read_disk
jmp PROGRAM_LOAD_ADDR

;-------read disk---------
read_disk:
; 1. write LBA
mov dx, 0x1F3 ; LBA low (0-7)
out dx, al

shr eax, 8
mov dx, 0x1F4 ; LBA mid (8-15)
out dx, al

shr eax, 8
mov dx, 0x1F5 ; LBA high (16-23)
out dx, al

shr eax, 8
mov dx, 0x1F6 ; device register (8 bits)
and al, 0x0F ; set 0-3 as LBA top, 4-7 as 0
or al, 0b11100000 ;4th as 0 (primary), 6th as 1 (LBA)
out dx, al

; 2. write sector count
mov dx, 0x1F2
mov al, cl
out dx, al

; 3. write command READ
mov dx, 0x1F7
mov al, 0x20
out dx, al

; 4. read status
read_status_until_ready:
in al, dx
and al, 0b00001000 ; get the ready bit
jz read_status_until_ready ; loop if zero (ready bit is not set)

; 5. read and loop 4
mov ax, 256
mul cx ; read times = read sector count * 256 (2 bytes every time)
mov cx, ax

read_2_bytes:
mov dx, 0x1f0
in ax, dx
mov [bx], ax
add bx, 2
loop read_2_bytes
ret

times 510-($-$$) db 0
db 0x55, 0xaa