# User config
set ::env(DESIGN_NAME) top

# Change if needed
set ::env(VERILOG_FILES) [glob $::env(DESIGN_DIR)/src/*.v]

set ::env(CLOCK_TREE_SYNTH) 0
set ::env(CLOCK_PORT) ""

set ::env(PL_SKIP_INITIAL_PLACEMENT) 1
set ::env(PL_RANDOM_GLB_PLACEMENT) 1

set ::env(FP_SIZING) absolute
set ::env(DIE_AREA) "0 0 50 50"
set ::env(PL_TARGET_DENSITY) 0.75

set ::env(PL_RESIZER_BUFFER_OUTPUT_PORTS) 0

set ::env(RUN_KLAYOUT_XOR) 0
set ::env(RUN_KLAYOUT_DRC) 0

set filename $::env(DESIGN_DIR)/$::env(PDK)_$::env(STD_CELL_LIBRARY)_config.tcl
if { [file exists $filename] == 1} {
	source $filename
}

