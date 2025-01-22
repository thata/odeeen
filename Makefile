BOARD=tangprimer20k
FAMILY=GW2A-18
DEVICE=GW2A-LV18PG256C8/I7

.PHONY: clean prog test unit-test firmware disasm clean-firmware

all: odeeen.fs

clean:
	rm -rf odeeen.fs odeeen_pnr.json odeeen.json firmware/firmware.hex

odeeen.fs: odeeen_pnr.json firmware/firmware.hex
	gowin_pack -d ${FAMILY} -o odeeen.fs odeeen_pnr.json

odeeen_pnr.json: odeeen.json
	nextpnr-himbaechel --json odeeen.json --write odeeen_pnr.json --freq 27 --device ${DEVICE} --vopt family=${FAMILY} --vopt cst=rtl/${BOARD}.cst

odeeen.json: rtl/cpu.sv rtl/tangnano9k_top.sv rtl/bram_controller.sv rtl/sdram.v rtl/uart.v rtl/fpu_controller.sv rtl/fpu/float_to_int/float_to_int.v rtl/fpu/int_to_float/int_to_float.v rtl/fpu/divider/divider.v rtl/fpu/multiplier/multiplier.v rtl/fpu/adder/adder.v firmware/firmware_seed.hex
	yosys -p "synth_gowin -top tangnano9k_top -json odeeen.json" rtl/cpu.sv rtl/bram_controller.sv rtl/fpu_controller.sv rtl/fpu/float_to_int/float_to_int.v rtl/fpu/int_to_float/int_to_float.v rtl/fpu/divider/divider.v rtl/fpu/multiplier/multiplier.v rtl/fpu/adder/adder.v rtl/sdram.v rtl/tangnano9k_top.sv rtl/uart.v

prog: odeeen.fs
	openFPGALoader -b ${BOARD} odeeen.fs

prog_flash: ulx3s.bit
	openFPGALoader -b ${BOARD} odeeen.fs -f

firmware/firmware.hex:

FIRMWARE_TARGET = blink.S
firmware/firmware.hex: firmware/$(FIRMWARE_TARGET)
	riscv64-unknown-elf-gcc -march=rv32if -mabi=ilp32f -nostdlib -Wl,-Ttext=0x00000000 $< -o firmware/firmware.elf
	riscv64-unknown-elf-objcopy -O verilog --verilog-data-width 4 firmware/firmware.elf firmware/firmware.hex

# MinCaml のプログラムをビルド
# FIRMWARE_TARGET = test/read_float_test
# firmware/firmware.hex: Makefile firmware/$(FIRMWARE_TARGET).ml firmware/libmincaml.S firmware/stub.S
# 	firmware/bin/min-caml firmware/${FIRMWARE_TARGET}
# 	riscv64-unknown-elf-gcc -nostdlib -march=rv32if -mabi=ilp32f -Wl,-Tfirmware/custom.ld firmware/stub.S firmware/${FIRMWARE_TARGET}.s firmware/libmincaml.S -o firmware/firmware.elf
# 	riscv64-unknown-elf-objcopy -O verilog --verilog-data-width 4 firmware/firmware.elf firmware/firmware.hex

# min-rt をビルド
# firmware/firmware.hex: Makefile firmware/min-rt/min-rt.ml firmware/sld_data.s firmware/libmincaml.S firmware/stub.S
# 	firmware/bin/min-caml firmware/min-rt/min-rt
# 	riscv64-unknown-elf-gcc -nostdlib -march=rv32if -mabi=ilp32f -Wl,-Tfirmware/custom.ld firmware/stub.S firmware/min-rt/min-rt.s firmware/libmincaml.S firmware/min-rt/globals.s -o firmware/firmware.elf
# 	riscv64-unknown-elf-objcopy -O verilog --verilog-data-width 4 firmware/firmware.elf firmware/pre_firmware.hex
# 	cat firmware/pre_firmware.hex | grep -v "@" > firmware/firmware.hex

SLD_FILE = firmware/min-rt/contest.sld
firmware/sld_data.s: $(SLD_FILE) Makefile
	ruby firmware/bin/sld2asm.rb $(SLD_FILE) > firmware/sld_data.s

firmware: firmware/firmware.hex

clean-firmware:
	rm -f firmware/firmware.hex firmware/firmware.elf

# ファームウェア置き換え用のダミーデータを生成
firmware/firmware_seed.hex:
	ecpbram -g firmware/firmware_seed.hex -w 32 -d 65536

disasm:
	riscv64-unknown-elf-objdump -d firmware/firmware.elf
