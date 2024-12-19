.PHONY: clean prog test

all: ulx3s.bit

clean:
	rm -rf odeeen.json ulx3s_out.config ulx3s.bit

ulx3s.bit: ulx3s_out.config
	ecppack ulx3s_out.config ulx3s.bit

ulx3s_out.config: odeeen.json
	nextpnr-ecp5 --85k --json odeeen.json --lpf rtl/ulx3s_v20.lpf --textcfg ulx3s_out.config

odeeen.json: rtl/cpu.sv rtl/ulx3s_top.sv rtl/bram_controller.sv
	yosys -p "hierarchy -top ulx3s_top" -p "synth_ecp5 -json odeeen.json" rtl/cpu.sv rtl/bram_controller.sv rtl/ulx3s_top.sv

prog: ulx3s.bit
	fujprog ulx3s.bit

test:
	cd rtl && iverilog -g 2012 -s cpu_test cpu_test.sv cpu.sv bram_controller.sv && ./a.out
