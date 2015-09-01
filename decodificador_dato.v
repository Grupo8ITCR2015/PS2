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
module decodificador_dato(
input flag, clk_rx,reset, input[7:0] datain,
output wire Temp0, Temp1, Humo, Elec
    );
	
//declaracion de parametros
localparam [7:0] A=8'h1C,Z=8'h1A,X=8'h22,D=8'h23,C=8'h21,F=8'h2B,V=8'h2A;


//señales
reg T0,T1,H0,E0;
reg [7:0] Data;


//toma de dato
always@(negedge clk_rx)
begin
	if(reset)
		Data=8'h00;
	else
		Data=datain;
end
		
//salidas	
always@*
begin
	T0=0;   //
	T1=0;   //
	H0=0;   //inicializa datos
	E0=0;   //
	if(flag)begin //bandera alta
		if(Data==A)begin
			T0=1'b1;
			T1=1'b1;
			H0=H0;
			E0=E0;
			end
		else if(Data==Z) begin
				T0=1'b0;
				T1=1'b1;
				H0=H0;
				E0=E0;
				end
			else if(Data==X) begin
						T0=1'b0;
						T1=1'b0;
						H0=H0;
						E0=E0;
						end
					else if(Data==D)
						begin
						H0=1'b1;
						T0=T0;
						T1=T1;
						E0=E0;
						end
						else if(Data==C) 
							begin
							H0=1'b0;
							T0=T0;
							T1=T1;
							E0=E0;
							end
							else if(Data==F)
								begin
								E0=1'b1;
								T0=T0;
								T1=T1;
								H0=H0;
								end
								else if(Data==V)
									begin
									E0=1'b0;
									T0=T0;
									T1=T1;
									H0=H0;
									end
									else begin
									T0=T0;
									T1=T1;
									H0=H0;
									E0=E0;
									end
	end
	else begin
		T0=T0;
		T1=T1;
		H0=H0;
		E0=E0;
		end
end	
	
//asignaciones	
assign Elec=E0;
assign Temp0=T0;
assign Temp1=T1;
assign Humo=H0;

endmodule
