# ---- User‑tunable knobs --------------------------------------------------
set ::env(CLOCK_PORT)          clk
set ::env(CLOCK_PERIOD)        12.000
set ::env(SYNTH_DRIVING_CELL)  sky130_fd_sc_hd__inv_16
set ::env(SYNTH_DRIVING_CELL_PIN) Y
set ::env(SYNTH_CAP_LOAD)      13.60
set IO_PCT                     0.2
# -------------------------------------------------------------------------

# 1. Clock ----------------------------------------------------------------
create_clock -name $::env(CLOCK_PORT) \
             -period $::env(CLOCK_PERIOD) \
             [get_ports $::env(CLOCK_PORT)]

# 2. I/O delays -----------------------------------------------------------
set input_delay_value  [expr $::env(CLOCK_PERIOD) * $IO_PCT]
set output_delay_value [expr $::env(CLOCK_PERIOD) * $IO_PCT]

# Filter input ports (remove clk & resetn)
set input_ports [all_inputs]
set inputs_wo_clk [lsearch -inline -all -not -exact $input_ports $::env(CLOCK_PORT)]
set inputs_wo_clk_rst [lsearch -inline -all -not -exact $inputs_wo_clk resetn]

# Set delays
set_input_delay $input_delay_value -clock [get_clocks $::env(CLOCK_PORT)] $inputs_wo_clk_rst
set_input_delay 0.0 -clock [get_clocks $::env(CLOCK_PORT)] [get_ports resetn]
set_output_delay $output_delay_value -clock [get_clocks $::env(CLOCK_PORT)] [all_outputs]

# 3. I/O models -----------------------------------------------------------
set_driving_cell -lib_cell $::env(SYNTH_DRIVING_CELL) \
                 -pin      $::env(SYNTH_DRIVING_CELL_PIN) \
                 [all_inputs]

set cap_load [expr $::env(SYNTH_CAP_LOAD) / 1000.0]
set_load $cap_load [all_outputs]
