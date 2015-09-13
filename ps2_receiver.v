`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    16:53:20 09/07/2015 
// Design Name: 
// Module Name:    ps2_receiver 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module ps2_receiver(
    input clk,
    input reset,
    input ps2d,
    input ps2c,
    input rx_en,
    output T0,
    output T1,
    output H1,
    output E,
    output [10:0] out_reg 
    );
wire rx_tick;
wire [7:0] data;
Reception_Module Data_control(
    .din(data), 
    .rx_done_tick(rx_tick), 
    .reset(reset), 
    .clk(clk), 
    .T0(T0), 
    .T1(T1), 
    .E(E), 
    .H1(H1)
    );

ps2_rx  Data_reception(
    .clk(clk), 
    .reset(reset), 
    .ps2d(ps2d), 
    .ps2c(ps2c), 
    .rx_en(rx_en), 
    .rx_done_tick(rx_tick), 
    .b_reg(out_reg), 
    .dout(data)
    );



endmodule
