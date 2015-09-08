`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Instituto Tecnologico de Costa Rica
// Laboratorio de diseÃ±o de sistemas digital
// Profesor: Alfonso Chacon
//
// Estudiantes:
// Edgar Solera BolaÃ±os
// Diego Salazar Sibaja 
//
// Control PS2 Teclado
//
//////////////////////////////////////////////////////////////////////////////////
module Recepcio_PS2(
input clk,reset,ps2d,ps2c,rx_en,
output [10:0] out_reg,Y
    );

wire T1,T0, H1,E;
// Instantiate the module
Modulo_final salidas (
    .T_alta(T1), //wire
    .T_media(T0), //wire
    .clk(clk), //clock
    .reset_contador(reset),//input 
    .humo(H1), //wire
    .el(E), //wire
    .reset(reset), //input 
    .Y(Y)//output
    );
// Instantiate the module
ps2_receiver entradas (
    .clk(clk), //clock
    .reset(reset), //input
    .ps2d(ps2d), //input
    .ps2c(ps2c), //input
    .rx_en(rx_en), //input
    .T0(T0), //wire
    .T1(T1), //wire
    .H1(H1), //wire
    .E(E), //wire
    .out_reg(out_reg)//output
    );

	 
endmodule
