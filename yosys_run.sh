# read design

read_verilog iiitb_sipo.v

# generic synthesis
synth -top iiitb_sipo

# mapping to mycells.lib
dfflibmap -liberty /home/aditya/Documents/sipo_project/vlsi/sky130RTLDesignAndSynthesisWorkshop/lib/sky130_fd_sc_hd__tt_025C_1v80.lib
abc -liberty /home/aditya/Documents/sipo_project/vlsi/sky130RTLDesignAndSynthesisWorkshop/lib/sky130_fd_sc_hd__tt_025C_1v80.lib
clean
flatten
# write synthesized design
write_verilog -noattr iiitb_sipo_net.v
