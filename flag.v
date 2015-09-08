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
module flag(
input wire clk,
input wire reset,
input wire [7:0] Din,
output reg bandera
    );
	 
always@(posedge clk)
		if(reset)
			bandera=1'b0;
		else if(Din==8'hF0)
			bandera=1'b1;
			else
			bandera=1'b0;
	 
	 
	 
	 
/*	 
//parametros locales

localparam	idle=1'b0, datanew=1'b1;
localparam [7:0] Senal=8'hF0;

//asignación de señales
reg flag_reg, flag_next, state, next_state;
wire [7:0]Datain;

//señal de entrada y uso
assign Datain=Din;

//secuencial
always@(negedge clk)
	if (reset)
		begin						//En esta sección secuencial se trabaja con una maquina de estados
		state<=idle;			//la cual esta registrando una bandera de salida y el estado en el que esta
		flag_reg<=idle;
		end
	else
		begin
		state<=next_state;
		flag_reg<=flag_next;
		end
			
		
//máquina de estados
always@*
	begin
	flag_next=bandera;
	case(state)
		idle:
			if(Datain==Senal) //si la entrada es F0 y se toma el negedge del rx_done_tick
				begin
				flag_next=datanew;
				next_state=datanew;
				end
			else
				begin
				next_state=idle; // de lo contrario espera
				end
		datanew:
			begin //bandera en 1 y se mantiene el rx_done_tick
				flag_next=datanew;
				next_state=idle; end
		default: next_state=idle;
	endcase
	end

assign bandera=flag_reg; //asignación de salidas
*/
endmodule
