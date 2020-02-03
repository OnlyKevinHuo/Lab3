`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    21:22:06 02/02/2020 
// Design Name: 
// Module Name:    alu_control 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module alu_control  (
    input wire [1:0] alu_op , 
    input wire [5:0] instr_5_0 , 
	 output reg [3:0] alu_out);
	 
	 always @(posedge clk)begin
		case(alu_op)
			2'b00: alu_out = 4'b0010;
				
			2'b01: alu_out = 4'b0110;
			
			2'b10:begin
				case(instr_5_0)
					6'b100000: alu_out = 4'b0010;
					
					6'b100010: alu_out = 4'b0110;
					
					6'b100100: alu_out = 4'b0000;
					
					6'b100101: alu_out = 4'b0001;
					
					6'b100111: alu_out = 4'b1100;
					
					6'b101010: alu_out = 4'b0111;
				endcase

			end
			
			2'b11: alu_out = 4'b0110;
		endcase
	end
endmodule
