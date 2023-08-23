`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 18.08.2023 21:59:00
// Design Name: 
// Module Name: multiplex
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

module data_multiplex (clk,DS1,DS2,DS3,mode,switch_clk_cycles,output_data);
//Inputs
input clk;                   // Internal clock signal (100 MHz)
input [7:0] DS1;             // Data stream 1
input [7:0] DS2;             // Data stream 2
input [7:0] DS3;             // Data stream 3
input [1:0] mode;            // Mode
input [3:0] switch_clk_cycles; // Number of clock cycles to switch data

//Output
output reg [7:0] output_data; // Output_data

// Internal registers
reg [15:0] count = 0;
reg symbol_clk_prev = 0;
wire symbol_clk;

//Parameter
parameter clk_div=6;
// Symbol clock generation
always @(posedge clk) begin
    if (count == clk_div-1) begin
        count <= 0;
    end else begin
        count <= count + 1;
    end
end
assign symbol_clk = count<((clk_div/2)) ? 1 : 0;

// Modes of operation
always @ (symbol_clk) begin
    case (mode)
        2'b01:
            begin
                if (symbol_clk == 1 && symbol_clk_prev == 0) begin
                    output_data <= DS1;
                end
            end
        2'b10:
            begin
                if (symbol_clk == 1 && symbol_clk_prev == 0) begin
                    output_data <= DS1;
                end else if (symbol_clk == 0 && symbol_clk_prev == 1) begin
                    output_data <= DS2;
                end
            end
        2'b11:
            begin
                if (count < (switch_clk_cycles-1)) begin
                    output_data <= DS1;
                end else if (count < ( switch_clk_cycles +1)) begin
                    output_data <= DS2;
                end else begin
                    output_data <= DS3;
                end
            end
    endcase
    symbol_clk_prev <= symbol_clk;
end
endmodule




