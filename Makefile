.PHONY: clean prog test

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

odeeen.json: rtl/cpu.sv rtl/ulx3s_top.sv rtl/bram_controller.sv rtl/uart.v firmware/firmware_seed.hex
	yosys -p "hierarchy -top ulx3s_top" -p "synth_ecp5 -json odeeen.json" rtl/cpu.sv rtl/bram_controller.sv rtl/ulx3s_top.sv rtl/uart.v

prog: ulx3s.bit
	fujprog -j SRAM ulx3s.bit

prog_flash: ulx3s.bit
	fujprog -j FLASH ulx3s.bit

test:
	cd rtl && iverilog -g 2012 -s cpu_test cpu_test.sv cpu.sv bram_controller.sv && ./a.out

FIRMWARE_TARGET = helloworld.S

firmware/firmware.hex: firmware/$(FIRMWARE_TARGET)
	riscv64-unknown-elf-gcc -march=rv32i -mabi=ilp32 -nostdlib -Wl,-Ttext=0x00000000 $< -o firmware/firmware.elf
	riscv64-unknown-elf-objcopy -O verilog --verilog-data-width 4 firmware/firmware.elf firmware/firmware.hex

firmware: firmware/firmware.hex

# ファームウェア置き換え用のダミーデータを生成
firmware/firmware_seed.hex:
	ecpbram -g firmware/firmware_seed.hex -w 32 -d 2048
