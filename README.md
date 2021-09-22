# Trojan paper

https://iacr.org/archive/ches2013/80860203/80860203.pdf

My tweets about it: https://twitter.com/matthewvenn/status/1383421016630722565

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

Takes less than 2 minutes.

Change one of the buttons and resimulate, now the lock stays shut.
Odd thing I noticed, if button 9 is set wrong, then the lock is open for a few ns before reset.
Button 8 does what I expect.

## spice bits

    display                 # show all vectors
    plot vector_name        # plot the vector. if you get a message about vector not existing, try putting in quotes

# Insert the trojan

open the spice file and find the references to sky130_fd_sc_hd__dfxtp_1
there are 2. We want to trojan only one, so copy the definition and rename it to sky130_fd_sc_hd__dfxtp_1_trojan
gt

In that subckt, we want to change the output's pfet to an nfet. Unfortunately we can't just change the def, because
only certain sizes of mosfets are 'recognised' in the PDK. This would not be a factor with a fabricated device.
So copy the nfet definition and adapt it to replace the pfet.

Then re-run the simulation and you should see the lock opening even though the combination is still wrong.

# Limitations

* spice takes ages to run even on small designs
* need to do analogue sim as we are doing a hw trojan
* we are lucky because the gds has cell names that makes them easier to identify
* after synthesis, logic is optimised so it can be much harder to work out the intent of the design
