`timescale 1ns/1ps
module mux1bit(
     input Y,
     input [1:0] sel,
     input en,
     output reg A, B, C, D
);
always @(*) begin 
    case(sel)
        2'b00: {D, C, B, A} <= {1'b0, 1'b0, 1'b0, Y}; 
        2'b01: {D, C, B, A} <= {1'b0, 1'b0, Y, 1'b0};
        2'b10: {D, C, B, A} <= {1'b0, Y, 1'b0, 1'b0};
        2'b11: {D, C, B, A} <= {Y, 1'b0, 1'b0, 1'b0};
    endcase
end

endmodule