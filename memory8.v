`timescale 1ns / 1ps
module memory8(
    input [7:0] Din,
    input Enable,
    output [7:0] Dout
    );
wire [7:0] notQ;
genvar i; 
    generate
        for (i = 0; i < 8; i = i + 1) begin 
            dlatch dlatch1(
                .D(Din[i]),
                .E(Enable),
                .Q(Dout[i]),
                .NotQ(notQ[i])
            );
        end
    endgenerate
endmodule
