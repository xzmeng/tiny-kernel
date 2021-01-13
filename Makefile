.PHONY: run clean

run:
	make clean
	make hd.img
	bochs -f bochsrc.txt -rc skip.txt -q

debug:
	make clean
	make hd.img
	bochs -f bochsrc.txt -q

%.bin: %.asm
	nasm -o $@ $^

hd.img: mbr.bin program.bin
	bximage -mode=create -hd=10M -imgmode=flat -q hd.img
	dd if=mbr.bin of=hd.img bs=512 count=1 conv=notrunc
	dd if=program.bin of=hd.img bs=512 count=1 seek=1 conv=notrunc

clean:
	rm -f *.bin hd.img
