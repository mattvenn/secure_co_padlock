`default_nettype none
`timescale 1ns/1ns

module top (
    input   wire    clk,
    input   wire    reset,
    input   wire    but_0,
    input   wire    but_1,
    input   wire    but_2,
    input   wire    but_3,
    input   wire    but_4,
    input   wire    but_5,
    input   wire    but_6,
    input   wire    but_7,
    input   wire    but_8,
    input   wire    but_9,
    input   wire    open,
    output  reg     lock);

    reg correct_q;

    wire correct = (
        but_0 == 1'b1 &&
        but_1 == 1'b0 &&
        but_2 == 1'b1 &&
        but_3 == 1'b0 &&
        but_4 == 1'b1 &&
        but_5 == 1'b0 &&
        but_6 == 1'b1 &&
        but_7 == 1'b0 &&
        but_8 == 1'b0 &&
        but_9 == 1'b0);

    always @(posedge clk) begin
        if(reset) begin
            lock <= 1'b1;
            correct_q <= 1'b0;
        end else begin 
            correct_q <= correct;
            // if correct buttons pressed, open the lock
            if(correct_q && open)
                lock <= 1'b0;
            else
                lock <= 1'b1;
        end
    end
endmodule
