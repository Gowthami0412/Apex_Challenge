`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 18.08.2023 22:00:29
// Design Name: 
// Module Name: test_bench
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

module testbench();

    // Inputs
    reg clk = 0;
    reg [7:0] DS1 ;
    reg [7:0] DS2 ;
    reg [7:0] DS3 ;
    reg [1:0] mode;
    reg [3:0] switch_clk_cycles ; // You can change this value for testing

    // Outputs
    wire [7:0] output_data;

    // Instantiate the data_multiplex module
    data_multiplex dut (
        .clk(clk),
        .DS1(DS1),
        .DS2(DS2),
        .DS3(DS3),
        .mode(mode),
        .switch_clk_cycles(switch_clk_cycles),
        .output_data(output_data)
    );

    // Clock generation
    initial begin
        clk=0; 
        mode =2'b01;
        switch_clk_cycles=4'd6;
        DS1=8'hAA;
        DS2=8'hBB;
        DS3=8'hCC;
        #40 DS1=8'hDD;
        #15 DS2=8'hEE;
        #30 DS3=8'hFF;
        
        #100
        mode=2'b10;
        switch_clk_cycles=4'd3;
    end
always #5 clk=~clk;
endmodule



