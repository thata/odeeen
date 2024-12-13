test:
	cd rtl && iverilog -g 2012 -s cpu_test cpu_test.sv cpu.sv bram_controller.sv && ./a.out
