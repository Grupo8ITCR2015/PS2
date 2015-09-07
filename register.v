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
module register(
    input wire [7:0] din,
    output reg [7:0] dout,
	 input wire clk,
    input wire enable,
    input wire reset
    );

always @(posedge clk or posedge reset)
      if (reset) begin
         dout <= 8'h00;
      end else if (enable) begin
         dout <= din;
      end

endmodule
