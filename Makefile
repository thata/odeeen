.PHONY: clean prog test unit-test firmware disasm

all: ulx3s.bit

clean:
	rm -rf odeeen.json ulx3s_out.config ulx3s_out_final.config ulx3s.bit firmware/firmware.hex firmware/firmware.elf


ulx3s.bit: ulx3s_out.config firmware/firmware.hex
    # NOTE: BRAM上のダミーデータで埋めてる箇所を、実際のファームウェアに置き換える
	ecpbram -i ulx3s_out.config \
		-o ulx3s_out_final.config \
		-f firmware/firmware_seed.hex \
		-t firmware/firmware.hex

	ecppack ulx3s_out_final.config ulx3s.bit


ulx3s_out.config: odeeen.json
	nextpnr-ecp5 --85k --json odeeen.json --lpf rtl/ulx3s_v20.lpf --textcfg ulx3s_out.config

odeeen.json: rtl/cpu.sv rtl/ulx3s_top.sv rtl/bram_controller.sv rtl/sdram.v rtl/uart.v rtl/fpu_controller.sv rtl/fpu/float_to_int/float_to_int.v rtl/fpu/int_to_float/int_to_float.v rtl/fpu/divider/divider.v rtl/fpu/multiplier/multiplier.v rtl/fpu/adder/adder.v firmware/firmware_seed.hex
	yosys -p "hierarchy -top ulx3s_top" -p "synth_ecp5 -json odeeen.json" rtl/cpu.sv rtl/bram_controller.sv rtl/fpu_controller.sv rtl/fpu/float_to_int/float_to_int.v rtl/fpu/int_to_float/int_to_float.v rtl/fpu/divider/divider.v rtl/fpu/multiplier/multiplier.v rtl/fpu/adder/adder.v rtl/sdram.v rtl/ulx3s_top.sv rtl/uart.v

prog: ulx3s.bit
	fujprog -j SRAM ulx3s.bit

prog_flash: ulx3s.bit
	fujprog -j FLASH ulx3s.bit

unit-test:
	iverilog -g 2012 -s branch_unit_test rtl/instructions.sv rtl/cpu.sv rtl/branch_unit_test.sv && ./a.out
	iverilog -g 2012 -s alu_test rtl/instructions.sv rtl/cpu.sv rtl/alu_test.sv && ./a.out

test:
	iverilog -g 2012 -s cpu_test -I rtl rtl/cpu_test.sv \
	  rtl/bram_controller.sv \
	  rtl/fpu/adder/adder.v \
	  rtl/fpu/multiplier/multiplier.v \
	  rtl/fpu/divider/divider.v \
	  rtl/fpu/int_to_float/int_to_float.v \
	  rtl/fpu/float_to_int/float_to_int.v \
	  rtl/fpu_controller.sv \
	  rtl/cpu.sv \
	  && ./a.out

firmware/firmware.hex:

# FIRMWARE_TARGET = libmincaml_test.S
# firmware/firmware.hex: firmware/$(FIRMWARE_TARGET)
# 	riscv64-unknown-elf-gcc -march=rv32i -mabi=ilp32 -nostdlib -Wl,-Ttext=0x00000000 $< -o firmware/firmware.elf
# 	riscv64-unknown-elf-objcopy -O verilog --verilog-data-width 4 firmware/firmware.elf firmware/firmware.hex

# MinCaml のプログラムをビルド
FIRMWARE_TARGET = test/sum
firmware/firmware.hex: firmware/$(FIRMWARE_TARGET).ml firmware/libmincaml.S firmware/stub.S
	firmware/bin/min-caml firmware/${FIRMWARE_TARGET}
	riscv64-unknown-elf-gcc -nostdlib -march=rv32if -mabi=ilp32f -Wl,-Tfirmware/custom.ld firmware/stub.S firmware/${FIRMWARE_TARGET}.s firmware/libmincaml.S -o firmware/firmware.elf
	riscv64-unknown-elf-objcopy -O verilog --verilog-data-width 4 firmware/firmware.elf firmware/firmware.hex

firmware: firmware/firmware.hex

# ファームウェア置き換え用のダミーデータを生成
firmware/firmware_seed.hex:
	ecpbram -g firmware/firmware_seed.hex -w 32 -d 65536

disasm:
	riscv64-unknown-elf-objdump -d firmware/firmware.elf
