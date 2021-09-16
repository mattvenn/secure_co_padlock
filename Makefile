# COCOTB variables
export COCOTB_REDUCED_LOG_FMT=1
export PYTHONPATH := test:$(PYTHONPATH)

all: test

# if you run rules with NOASSERT=1 it will set PYTHONOPTIMIZE, which turns off assertions in the tests
test:
	rm -rf sim_build/
	mkdir sim_build/
	iverilog -o sim_build/sim.vvp -s top -s dump -g2012 src/top.v test/dump_top.v
	PYTHONOPTIMIZE=${NOASSERT} MODULE=test.test vvp -M $$(cocotb-config --prefix)/cocotb/libs -m libcocotbvpi_icarus sim_build/sim.vvp
	! grep failure results.xml

show_%: %.vcd %.gtkw
	gtkwave $^

lint:
	verible-verilog-lint src/*v --rules_config verible.rules

clean:
	rm -rf *vcd sim_build fpga/*log fpga/*bin test/__pycache__

.PHONY: clean test
