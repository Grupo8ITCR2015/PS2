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
module ps2_rx(
input wire clk, reset,   //Clock y reset de la maquina
input wire ps2d, ps2c, rx_en,   // Ps2d: datos que llegan; Ps2c: clk del ps2;rx_en: enable del receptor.
output reg rx_done_tick,// Rx_done_tick:el dato se encuentra listo
output reg [10:0] b_reg,//dato de salida
output wire [7:0] dout 		  
) ;
//Symbolic state declaration
localparam [1:0] //parametros de la maquina de estados   
	idle = 2 'b00,      
	dps = 2'b01,      
	load = 2'b10;       
//signal declaration
reg [1:0] state_reg,state_next; 
reg [7:0] filter_reg; 
wire [7:0] filter_next;
reg f_ps2c_reg;  
wire f_ps2c_next;  
reg [3:0] n_reg, n_next;   
reg [10:0] b_next;    
wire fall_edge;   

//detector de flancos
always @(posedge clk, posedge reset)  
if (reset)
	begin
		filter_reg<=0;     
		f_ps2c_reg <=0;      
	end
else 
	begin
		filter_reg<= filter_next;   //captura el estado del reloj del ps2
		f_ps2c_reg<= f_ps2c_next;   //copia del clock del ps2

	end

assign filter_next = {ps2c,filter_reg[7:1]};    // le asigna filter_next el estado del reloj  
assign f_ps2c_next = (filter_reg==8'b11111111) ? 1'b1:   //si el actual valor del filtro son puros 1; pone al reloj ps2 en 1
					 (filter_reg==8'b00000000) ? 1'b0:   //si filter reg son puros 0 pone al reloj ps2 en 0
					 f_ps2c_reg;  // si no hay ninguno de los 2 casos le asigna el valor que tenia antes
 assign fall_edge = f_ps2c_reg & ~f_ps2c_next;   // si el valor del reloj actual es 1 y el proximo es 0 hay un fall_edge
 //maquina de estados
always @(posedge clk, posedge reset)    
	if (reset)
		begin
		state_reg <= idle;
		n_reg <= 4'b0000;
		b_reg <= 4'b0000;
		end
	else
		begin
			state_reg <= state_next;
			n_reg <= n_next;
			b_reg <= b_next;

		end
				

always @*
begin 
	state_next <= state_reg;   //incializa todas la variables de la maquina 
	rx_done_tick = 1'b0;    // salida de la maquina que indica que el dato esta listo para tomarse
	n_next = n_reg;    //es el contador que inicia en nueve y deciende a 0
	b_next = b_reg;    // es la salida de la maquina que va guardando el dato que llega
	case(state_reg)

		idle:
			if (fall_edge & rx_en)// Estado de espera del fall_edge
				begin
				b_next = {ps2d, b_reg[10:1]}; 
				n_next = 4'b1001;     // le da el valor de nueve al contador para comenzara recibir el dato
				state_next<= dps;  
				end

		dps:  
			if (fall_edge)//cada fall_edge esta el dato
				begin
					b_next= {ps2d, b_reg[10:1]};   					
					if (n_reg==0)	// si el contador no ha llegado a cero significa que debe seguir recibiendo el dato				
						state_next <= load;
					else
						n_next = n_reg-4'b0001;
				end

		load: 

			begin 
				state_next<=idle;       
				rx_done_tick=1'b1;// el dato es listo para recibirse 
			end
		
		endcase
	end
	assign dout = b_reg[8:1];  //le asigna la salida
	
	endmodule 
