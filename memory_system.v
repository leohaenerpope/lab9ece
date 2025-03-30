`timescale 1ns/1ps
module memory_system(
    input [7:0] data,
    input store,
    input [1:0] addr,
    output reg [7:0] memory
);

    // This should instantiate 4 instances of
    // byte_memory, and then demultiplex
    // data and store into the one selected by
    // addr
    reg [7:0] bytes [3:0];
    reg byteEn [3:0];
    wire [7:0] byteOut [3:0];
    always @(*) begin 
    case(addr)
        2'b00: {bytes[3], bytes[2], bytes[1], bytes[0]} <= {8'b0, 8'b0, 8'b0, data}; 
        2'b01: {bytes[3], bytes[2], bytes[1], bytes[0]} <= {8'b0, 8'b0, data, 8'b0};
        2'b10: {bytes[3], bytes[2], bytes[1], bytes[0]} <= {8'b0, data, 8'b0, 8'b0};
        2'b11: {bytes[3], bytes[2], bytes[1], bytes[0]} <= {data, 8'b0, 8'b0, 8'b0};
    endcase
    end
    always @(*) begin 
    case(addr)
        2'b00: {byteEn[3], byteEn[2], byteEn[1], byteEn[0]} <= {1'b0, 1'b0, 1'b0, store}; 
        2'b01: {byteEn[3], byteEn[2], byteEn[1], byteEn[0]} <= {1'b0, 1'b0, store, 1'b0};
        2'b10: {byteEn[3], byteEn[2], byteEn[1], byteEn[0]} <= {1'b0, store, 1'b0, 1'b0};
        2'b11: {byteEn[3], byteEn[2], byteEn[1], byteEn[0]} <= {store, 1'b0, 1'b0, 1'b0};
    endcase
    end
    
    //figure out a way to keep the memory?
    always @(*) begin 
    memory <= (store) ? ((addr == 2'b00) ? 
    byteOut[0] : (addr == 2'b01) ? byteOut[1] : (addr == 2'b10) ?
    byteOut[2] : (addr == 2'b11) ? byteOut[3] : 8'b0) : 8'b0;
    end
    
    genvar i; 
    generate
        for (i = 0; i < 4; i = i + 1) begin 
            byte_memory mem1(
                .data(bytes[i]),
                .store(byteEn[i]),
                .memory(byteOut[i])
            );
        end
    endgenerate
    

    // It should then multiplex the output of the
    // memory specified by addr into the memory
    // output for display on the LEDs

    // you will need 2 demultiplexers:
    // 1. Demultiplex data -> selected byte
    // 2. Demultiplex store -> selected byte

    // and one multiplexer:
    // 1. Multiplex selected byte -> memory

endmodule