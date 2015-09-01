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
input wire clk_rx, input wire reset,
input wire [7:0] Din,
output wire bandera
    );
	 
//parametros locales

localparam	idle=1'b0, datanew=1'b1;
localparam [7:0] Senal=8'hF0;

//asignación de señales
reg flag, state, next_state;
wire [7:0]Datain;

//señal de entrada y uso
assign Datain=Din;


//secuencial
always@(negedge clk_rx)
	if (reset)
		state<=idle;
	else
		begin
		state<=next_state;
		end
		
//máquina de estados
always@*
	begin
	case(state)
		idle:
			if(Datain==Senal) //si la entrada es F0
				begin
				flag=datanew;
				next_state=datanew;
				end
			else
				begin
				next_state=idle;
				end
		datanew:
			if(flag==datanew) begin //bandera en 1
				flag=idle;
				next_state=idle;
				end
			else begin
				flag=flag;
				next_state=idle; end
		default: next_state=idle;
	endcase
	end

assign bandera=flag; //asignación de salidas

endmodule
