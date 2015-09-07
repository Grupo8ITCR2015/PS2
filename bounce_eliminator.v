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
module bounce_eliminator(
   input din,     //Declaramos la entrada tipo bus de 4 bits inp
   input cclk,          //Declaramos la entrada clk
   input clr,           //Declaramos la entrada clr
   output outp    //Declaramos la salida tipo bus de 4 bits outp
   );

reg delay1;       //Declaramos la conexion auxiliar tipo reg delay1
reg delay2;       //Declaramos la conexion auxiliar tipo reg delay2
reg delay3;       //Declaramos la conexion auxiliar tipo reg delay3

always @(posedge cclk or posedge clr) begin
   if(clr) begin        //Si se activa clr
      delay1<=0;        //el siguiente valor de delay1 sera 0
      delay2<=0;        //el siguiente valor de delay2 sera 0
      delay3<=0;        //el siguiente valor de delay3 sera 0
   end
   else begin           //De lo contrario
      delay1<=din;      //el siguiente valor de delay1 sera inp
      delay2<=delay1;   //el siguiente valor de delay2 sera delay1
      delay3<=delay2;   //el siguiente valor de delay3 sera delay2
   end
end

//Si la entrada inp es 1 durante 3 ciclos de cclk  outp sera 1.
assign outp = delay1 & delay2 & delay3;   //outp sera 1 si delay1, delay2 y delay3 son 1.

endmodule
