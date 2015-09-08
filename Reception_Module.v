`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Instituto Tecnologico de Costa Rica
// Laboratorio de diseño de sistemas digital
// Profesor: Alfonso Chacon
//
// Estudiantes:
// Edgar Solera Bolaños
// Diego Salazar Sibaja 
//
// Control PS2 Teclado
//
//////////////////////////////////////////////////////////////////////////////////
module Reception_Module(
input wire [7:0] din, 
input wire rx_done_tick, reset, clk,
output wire T0,T1,E,H1
    );
	 
	 
wire bandera;
wire [7:0] data,data2;	 
	 
// Analisis de datos
deco_reg data_detector (
    .datain(data), 
    .flag(bandera), 
    .clk(clk), 
    .reset(reset), 
    .T0(T0), 
    .T1(T1), 
    .H1(H1), 
    .E(E)
    );
	 
// Bandera
flag byflag (
    .clk(clk), 
    .reset(reset), 
    .Din(data2), 
    .bandera(bandera)
    );
	 
// Instantiate the module
register static_data1 (
    .din(din), 
    .dout(data), 
    .clk(clk), 
    .enable(rx_done_tick), 
    .reset(reset)
    );
	 
// Instantiate the module
register static_data2 (
    .din(data), 
    .dout(data2), 
    .clk(clk), 
    .enable(rx_done_tick), 
    .reset(reset)
    );


endmodule
