`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/03/26 22:10:42
// Design Name: 
// Module Name: top
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


module top(
    input clk,
    input reset,
    input [2:0] op,
    input [7:0] num1,
    output [7:0] ans,
    output [6:0] seg
    );

    wire [31:0] s;
    ALU_test U1(.num1(num1),.op(op),.result(result));
    display U2(.clk(clk),.reset(reset),.s(s),.seg(seg),.ans(ans));
endmodule
