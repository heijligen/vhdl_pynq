# ----------------------------------------------------------------------------
# "THE BEER-WARE LICENSE" (Revision 42):
# <src@posteo.de> wrote this file.  As long as you retain this notice you
# can do whatever you want with this stuff. If we meet some day, and you think
# this stuff is worth it, you can buy me a beer in return.    Thomas Heijligen
# ----------------------------------------------------------------------------

name ?= blink
board := pynq

all : build/$(name).bit.bin

build/$(name).edif: $(shell ls lib/*vhd) $(shell ls $(name)/*vhd)
	@yosys -m ghdl -p "read_verilog +/xilinx/cells_xtra.v; ghdl --std=08 $^ -e top; synth_xilinx -top top -edif $@"

build/$(name).bit: build/$(name).edif
	@./vivado -nolog -nojournal -mode batch -source run_vivado.tcl -tclargs $(board).xdc $^ $@

build/$(name).bit.bin: build/$(name).bit
	@bit2bitbin $^ $@

clean:
	@rm -rf build/$(name).*
