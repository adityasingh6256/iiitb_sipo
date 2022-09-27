###############################################################################
# Created by write_sdc
# Tue Sep 27 18:10:01 2022
###############################################################################
current_design iiitb_sipo
###############################################################################
# Timing Constraints
###############################################################################
create_clock -name clk -period 65.0000 [get_ports {clk}]
set_clock_transition 0.1500 [get_clocks {clk}]
set_clock_uncertainty 0.2500 clk
set_propagated_clock [get_clocks {clk}]
set_input_delay 13.0000 -clock [get_clocks {clk}] -add_delay [get_ports {d}]
set_input_delay 13.0000 -clock [get_clocks {clk}] -add_delay [get_ports {rst}]
set_output_delay 13.0000 -clock [get_clocks {clk}] -add_delay [get_ports {q[0]}]
set_output_delay 13.0000 -clock [get_clocks {clk}] -add_delay [get_ports {q[1]}]
set_output_delay 13.0000 -clock [get_clocks {clk}] -add_delay [get_ports {q[2]}]
set_output_delay 13.0000 -clock [get_clocks {clk}] -add_delay [get_ports {q[3]}]
set_output_delay 13.0000 -clock [get_clocks {clk}] -add_delay [get_ports {qbar[0]}]
set_output_delay 13.0000 -clock [get_clocks {clk}] -add_delay [get_ports {qbar[1]}]
set_output_delay 13.0000 -clock [get_clocks {clk}] -add_delay [get_ports {qbar[2]}]
set_output_delay 13.0000 -clock [get_clocks {clk}] -add_delay [get_ports {qbar[3]}]
###############################################################################
# Environment
###############################################################################
set_load -pin_load 0.0334 [get_ports {q[3]}]
set_load -pin_load 0.0334 [get_ports {q[2]}]
set_load -pin_load 0.0334 [get_ports {q[1]}]
set_load -pin_load 0.0334 [get_ports {q[0]}]
set_load -pin_load 0.0334 [get_ports {qbar[3]}]
set_load -pin_load 0.0334 [get_ports {qbar[2]}]
set_load -pin_load 0.0334 [get_ports {qbar[1]}]
set_load -pin_load 0.0334 [get_ports {qbar[0]}]
set_driving_cell -lib_cell sky130_vsdinv -pin {Y} -input_transition_rise 0.0000 -input_transition_fall 0.0000 [get_ports {clk}]
set_driving_cell -lib_cell sky130_vsdinv -pin {Y} -input_transition_rise 0.0000 -input_transition_fall 0.0000 [get_ports {d}]
set_driving_cell -lib_cell sky130_vsdinv -pin {Y} -input_transition_rise 0.0000 -input_transition_fall 0.0000 [get_ports {rst}]
set_timing_derate -early 0.9500
set_timing_derate -late 1.0500
###############################################################################
# Design Rules
###############################################################################
set_max_fanout 10.0000 [current_design]
