`timescale 1ns / 1ps

module dlatch(
    input D, E,
    output reg Q,
    output NotQ
);
    always @(E) begin 
        if (E)
            Q <= D;
        else
            Q <= Q;
    end
    assign NotQ = ~Q;
endmodule
