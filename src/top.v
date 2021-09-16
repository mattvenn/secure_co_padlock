`default_nettype none
`timescale 1ns/1ns

module top (
    input   wire    clk,
    input   wire    reset,
    input   wire    but_0,
    input   wire    but_1,
    input   wire    but_2,
    input   wire    but_3,
    output  reg     lock);

    reg [1:0] index;
    reg [1:0] attempt [3:0];

    always @(posedge clk) begin
        if(reset) begin
            lock <= 1'b1;
            index <= 2'b0;
        end else begin 
            // if buttons pressed, store and advance index
            if(but_0) begin
                attempt[index] <= 2'd0;
                index <= index + 1'b1;
            end else if(but_1) begin
                attempt[index] <= 2'd1;
                index <= index + 1'b1;
            end else if(but_2) begin
                attempt[index] <= 2'd2;
                index <= index + 1'b1;
            end else if(but_3) begin
                attempt[index] <= 2'd3;
                index <= index + 1'b1;
            end
                
            // check the code and unlock if correct
            if(
                attempt[0] == 2 && 
                attempt[1] == 1 && 
                attempt[2] == 3 && 
                attempt[3] == 0)
                lock <= 1'b0;
        end
    end
endmodule
