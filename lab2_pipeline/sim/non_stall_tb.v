`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/03/30 19:30:10
// Design Name: 
// Module Name: non_stall_tb
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


module non_stall_tb
    #(
        parameter  WIDTH = 100
    )
    (
    );
    reg clk;
    reg [WIDTH-1 : 0] datain;
    wire [WIDTH-1 : 0] dataout; 

    pipline3_nostall dut(.clk(clk),.datain(datain),.dataout(dataout));

    initial begin
        clk = 1'b0;
        forever begin
            #50 clk = ~clk;
        end
    end

    initial begin
        datain = {100{1'b0}};
        #200

        datain = {100{1'b1}};
        #200

        datain = {50{2'b01}};
        #400

        $stop;

    end
endmodule
