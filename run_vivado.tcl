# vivado -nolog -nojournal -mode batch -source $(this file) -tclargs ...
# argv 0: location of xdc input file
# argv 1: location of edif input file
# argv 2: location of bit output file
#
# ----------------------------------------------------------------------------
# "THE BEER-WARE LICENSE" (Revision 42):
# <src@posteo.de> wrote this file.  As long as you retain this notice you
# can do whatever you want with this stuff. If we meet some day, and you think
# this stuff is worth it, you can buy me a beer in return.    Thomas Heijligen
# ----------------------------------------------------------------------------

read_xdc [lindex $argv 0]
read_edif [lindex $argv 1]
link_design -part xc7z020clg400
place_design
route_design
write_bitstream -force [lindex $argv 2]
