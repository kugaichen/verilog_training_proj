`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/03/26 22:33:55
// Design Name: 
// Module Name: ALU_tb
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


module ALU_tb(
    
    );
    
    reg clk,reset;
    reg [7:0] num1;
    reg [2:0] op;
    wire [31:0] result;

    ALU_test dut(.num1(num1),.op(op),.result(result));

    initial begin
        clk = 1'b0;
        forever begin
            #50 clk = ~clk;
        end
    end

    initial begin
        reset = 1'b1;

        $monitor("num1=%b, op=%b, result=%b \n", num1, op, result);
        num1 = 8'b00000001;
        op = 3'b000;

        #50 reset = 0;
        
        num1 = 8'b00001111;
        op = 3'b000;
        #50

        num1 = 8'b00000001;
        op = 3'b001;
        #50
    
        op = 3'b100;

        #200 $stop;
    end

endmodule
