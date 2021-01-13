.PHONY: run clean

run:
	make clean
	make hd.img
	bochs -f bochsrc.txt -rc skip.txt -q

debug:
	make clean
	make hd.img
	bochs -f bochsrc.txt -q


mbr.bin: mbr.asm
	nasm -o mbr.bin mbr.asm -I include/

hd.img: mbr.bin
	bximage -mode=create -hd=10M -imgmode=flat -q hd.img
	dd if=mbr.bin of=hd.img bs=512 count=1 conv=notrunc

clean:
	rm -f mbr.bin hd.img
