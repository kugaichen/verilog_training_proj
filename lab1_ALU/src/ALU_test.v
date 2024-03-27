`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/03/26 10:08:33
// Design Name: 
// Module Name: ALU_test
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


module ALU_test(
    // input wire clk,reset,
    input wire [7:0] num1,
    input wire [2:0] op,
    output [31:0] result
    );
    wire [31:0] num2;
    wire [31:0] extend_num1;
    reg [31:0] result_reg;
    
    assign extend_num1 = {{24{1'b0}},num1[7:0]}; //extend num1 to 32'b
    assign num2 = 32'h00000001;

    always @( *) begin
        case (op)
            3'b000: result_reg = extend_num1 + num2;
            3'b001: result_reg = num2 - extend_num1;
            3'b010: result_reg = extend_num1 & num2;
            3'b011: result_reg = extend_num1 | num2;
            3'b100: result_reg = ~num2;
            3'b101: result_reg = {8{4'h0}};
        endcase
    end
    
    assign result = result_reg;

endmodule
