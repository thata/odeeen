all: firmware.hex

TARGET = loopback
# TARGET = blink

firmware.hex: $(TARGET).S
	riscv64-unknown-elf-gcc -march=rv32i -mabi=ilp32 -nostdlib -Wl,-Ttext=0x00000000 $(TARGET).S -o firmware.elf
	riscv64-unknown-elf-objcopy -O verilog --verilog-data-width 4 firmware.elf firmware.hex

clean:
	rm -f firmware.elf firmware.hex
