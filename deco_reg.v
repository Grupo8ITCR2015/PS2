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
module deco_reg(
input [7:0] datain,
input flag, clk, reset,
output wire T0,T1,H1,E
    );
	
//señales
reg A_reg, B_reg, C_reg, D_reg, A_next, B_next, C_next, D_next;


//parametros
localparam  s0=0,
				s1=1;
localparam [7:0]  A=8'h1C, S=8'h1B, D=8'h23, F=8'h2B, G=8'h34,
						H=8'h33, J=8'h3B, K=8'h42, L=8'h4B, Z=8'h1A,
						X=8'h22, C=8'h21, V=8'h2A, B=8'h32, N=8'h31,
						M=8'h3A;
						
// Secuencial
always @(posedge clk, posedge reset)
	if (reset)
		begin
		A_reg<=1'b0;
		B_reg<=1'b0;
		C_reg<=1'b0;
		D_reg<=1'b0;
		end
	else 
		begin
		A_reg<=A_next;
		B_reg<=B_next;
		C_reg<=C_next;
		D_reg<=D_next;
		end

//combinacional
always @*
begin
	A_next=T1;
	B_next=T0;     
	C_next=H1;
	D_next=E;
	
	if (flag)
		begin
		if(datain==A)
			begin
			A_next=1'b1;
			B_next=1'b1;		
			end
		else 
			if(datain==Z)
			begin
			A_next=1'b1;
			B_next=1'b0;		
			end
			else
				if(datain==X)
				begin
				A_next=1'b0;
				B_next=1'b0;		
				end
				else begin
					if(datain==D)
					C_next=1'b1;
					else
						if(datain==C)
						C_next=1'b0;
						else
							if(datain==F)
							D_next=1'b1;
							else
								if(datain==V)
								D_next=1'b0;
				end
						
			
		end
	
end

assign T1= A_reg;
assign T0= B_reg;
assign H1= C_reg;
assign E = D_reg;


endmodule
