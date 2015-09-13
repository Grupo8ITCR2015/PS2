`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   17:00:28 09/07/2015
// Design Name:   ps2_receiver
// Module Name:   C:/Users/Chico/Desktop/TEC/proyectosss/Proyectos/PS2/Test_ps2_receiver.v
// Project Name:  PS2
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: ps2_receiver
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module Test_ps2_receiver;

	// Inputs
	reg clk;
	reg reset;
	reg ps2d;
	reg ps2c;
	reg rx_en;

	// Outputs
	wire T0;
	wire T1;
	wire H1;
	wire E;
	wire [10:0] out_reg;

	// Instantiate the Unit Under Test (UUT)
	ps2_receiver uut (
		.clk(clk), 
		.reset(reset), 
		.ps2d(ps2d), 
		.ps2c(ps2c), 
		.rx_en(rx_en), 
		.T0(T0), 
		.T1(T1), 
		.H1(H1), 
		.E(E), 
		.out_reg(out_reg)
	);

integer i,j;
reg [10:0] temporal;//{1,8'H,2b'00}
reg [10:0] Mem [0:18];//Datos guardados en un archivo txt
reg enable_ps2c;// habilitador del clk del ps2
	
	
	
	initial begin
		// Initialize Inputs
		clk = 0;
		reset = 1;
		ps2d = 0;
		ps2c = 1;
		rx_en = 1;
		enable_ps2c=0;
		$readmemb("entradas.txt",Mem);
	repeat(5) @(posedge clk)
		reset=0;
	end
	
	
	initial begin
		@(negedge reset)// cuando el reset se hace 0
			for(j=0;j<20;j=j+1)
				begin
				temporal=Mem[j];
				repeat(5)@(posedge clk)// se espera 5 clks
				enable_ps2c=1;//habilita el CLK del ps2c
				for (i=0;i<11;i=i+1)
					begin
						@(negedge ps2c)
						ps2d=temporal[i];
					end
				ps2d=1;//para representar bien el ps2c
				enable_ps2c=0;		
				end
				$stop;
		end
initial begin 
	@(posedge enable_ps2c)
	while(enable_ps2c)
	#500 ps2c=~ps2c;
	end

		


	initial forever begin 
		#5 clk= ~clk;
		end
        
		// Add stimulus here


      
endmodule

