# To test the RTL

Run

    make

In the top level directory. To view the trace:

    make show_top

# To build the GDS

copy the whole directory to openlane/designs

in top level openlane directory:

    make mount
    ./flow.tcl -design secure_co_padlock

# To extract the netlist

Load the GDS with magic, 
    
    cd gds
    magic top.gds

then type these commands in the tcl window:

    extract
    ext2spice lvs
    ext2spice

This will give you a spice file with no blackboxed cells.

# To simulate the netlist

    cd gds
    ngspice simulation.spice
