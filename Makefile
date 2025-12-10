# Build all programs by default
all: task1 task2_example task2_loops task2_welcome task2_array

# Assemble and link Task 1
task1: src/task1.o src/asm_io.o src/driver.o
	gcc -m32 src/driver.o src/task1.o src/asm_io.o -o task1

# Assemble and link Task 2 Example (if/else)
task2_example: src/task2_example.o src/asm_io.o src/driver.o
	gcc -m32 src/driver.o src/task2_example.o src/asm_io.o -o task2_example

# Assemble and link Task 2 Loops
task2_loops: src/task2_loops.o src/asm_io.o src/driver.o
	gcc -m32 src/driver.o src/task2_loops.o src/asm_io.o -o task2_loops

# Assemble and link Welcome Program
task2_welcome: src/task2_welcome.o src/asm_io.o src/driver.o
	gcc -m32 src/driver.o src/task2_welcome.o src/asm_io.o -o task2_welcome

# Assemble and link Array Program
task2_array: src/task2_array.o src/asm_io.o src/driver.o
	gcc -m32 src/driver.o src/task2_array.o src/asm_io.o -o task2_array

# Rules to assemble .asm into .o files
src/%.o: src/%.asm
	nasm -f elf -I src/ $< -o $@

# Rule to compile driver.c
src/driver.o: src/driver.c
	gcc -m32 -c src/driver.c -o src/driver.o

# Rule to assemble asm_io.asm
src/asm_io.o: src/asm_io.asm
	nasm -f elf -I src/ src/asm_io.asm -o src/asm_io.o

# Clean up generated files
clean:
	rm -f src/*.o task1 task2_example task2_loops task2_welcome task2_array
