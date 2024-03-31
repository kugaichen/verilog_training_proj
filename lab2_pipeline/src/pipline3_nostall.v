`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/03/30 17:21:18
// Design Name: 
// Module Name: pipline3_nostall
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


module pipline3_nostall #
    (
        parameter  WIDTH = 100
    )
    (
        input clk,
        input [WIDTH-1: 0 ] datain,
        output [WIDTH-1 : 0] dataout
    );

    reg [WIDTH-1:0] pipe1_data;
    reg [WIDTH-1:0] pipe2_data;
    reg [WIDTH-1:0] pipe3_data;

    always @(posedge clk) begin
        pipe1_data <= datain;        
    end

    always @(posedge clk) begin
        pipe2_data <= pipe1_data;
    end

    always @(posedge clk) begin
        pipe3_data <= pipe2_data;
    end

    assign dataout = pipe3_data;

endmodule
