;-------print pg-------

mov ax, 0xb800
mov es, ax

mov byte [es:0], 'p'
mov byte [es:1], 0b00001110 ;blak bg; yellow font
mov byte [es:2], 'g'
mov byte [es:3], 0b00001110 ;blak bg; yellow font