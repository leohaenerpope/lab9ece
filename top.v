`timescale 1ns / 1ps


module top(
    input [15:0] sw,
    input btnC,
    output [15:0] led
);

dlatch dlatch1(
    .D(sw[0]),
    .E(btnC),
    .Q(led[0]),
    .NotQ(led[1])
);

wire [7:0] byte0;
wire [7:0] byte1;
wire [7:0] byte2;
wire [7:0] byte3;
wire enable0;
wire enable1;
wire enable2;
wire enable3;
wire [7:0] byte0out;
wire [7:0] byte1out;
wire [7:0] byte2out;
wire [7:0] byte3out;

demux switchDemux(
    .Y(sw[15:8]),
    .sel(sw[7:6]),
    .A(byte0),
    .B(byte1),
    .C(byte2),
    .D(byte3)
);

mux1bit enableMux(
    .Y(btnC),
    .sel(sw[7:6]),
    .en(1'b1),
    .A(enable0),
    .B(enable1),
    .C(enable2),
    .D(enable3)
);

memory8 memory80(
    .Din(byte0),
    .Enable(enable0),
    .Dout(byte0out)
);
memory8 memory81(
    .Din(byte1),
    .Enable(enable1),
    .Dout(byte1out)
);
memory8 memory82(
    .Din(byte2),
    .Enable(enable2),
    .Dout(byte2out)
);
memory8 memory83(
    .Din(byte3),
    .Enable(enable3),
    .Dout(byte3out)
);

mux finalmux(
    .A(byte0out),
    .B(byte1out),
    .C(byte2out),
    .D(byte3out),
    .sel(sw[7:6]),
    .en(1'b1),
    .Y(led[15:8])
);
endmodule
