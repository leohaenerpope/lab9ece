`timescale 1ns/1ps
module mux(
     input [7:0] A, B, C, D,
     input [1:0] sel,
     input en,
     output reg [7:0] Y

);
always @(*) begin 
    Y <= (en) ? ((sel == 2'b00) ? 
    A : (sel == 2'b01) ? B : (sel == 2'b10) ?
    C : (sel == 2'b11) ? D : 8'b0) : 8'b0;
end
endmodule