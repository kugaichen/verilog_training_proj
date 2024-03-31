`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/03/31 15:14:05
// Design Name: 
// Module Name: stallabe_tb
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


module stallabe_tb(

    );
    reg clk,rst;
    reg validin;
    reg [3:0] datain;
    reg out_allow;
    reg validout;
    wire [3:0] dataout;

    stallable_pipeline dut(
        .clk(clk),
        .rst(rst),
        .validin(validin),
        .datain(datain),
        .out_allow(out_allow),
        .validout(validout),
        .dataout(dataout)
    );

    initial begin
        clk = 1'b0;
        forever begin
            #5 clk = ~clk;
        end
    end

    initial begin
        validin = 1'b1;
        out_allow = 1'b1;
        datain = {{3{1'b0}},1'b1};

        #100 rst = 1;
		#50  rst = 0;
    end

    always @(posedge clk) begin
        datain <= datain + 1'b1;
    end

endmodule  
