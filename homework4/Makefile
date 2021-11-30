
default_target: all

all: main

main: main.obj
	gcc -no-pie out/main.obj -o out/main -lm

main.obj:
	mkdir out
	nasm -felf64 -o out/main.obj code/main.asm

clean:
	rm -rf out