`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/03/31 11:15:18
// Design Name: 
// Module Name: stallable_pipeline
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


module stallable_pipeline
    #(
        parameter WIDTH = 4
    )
    (
        input clk,rst,
        input validin,
        input [WIDTH-1:0] datain,
        input out_allow,
        input validout,
        output [WIDTH-1:0] dataout
    );

    // pipeX_valid : 当前级是否存在有效的数据
    reg pipe1_valid;
    reg [WIDTH-1:0] pipe1_data;
    
    reg pipe2_valid;
    reg [WIDTH-1:0] pipe2_data;

    reg pipe3_valid;
    reg [WIDTH-1:0] pipe3_data;

    /* -----------------pipe1----------------- */
    // local parameter
    wire    pipe1_alllowin; // if=1, pipe1允许接收上一级的数据，被刷新
    wire    pipe1_ready_go; // if=1, pipe1允许传递数据给下一级
    wire    pipe1_to_pipe2_valid; //if =1, pipe1的数据可以传输给pipe2

    // conditional set 
    assign pipe1_ready_go = 1'b1; //一直允许pipe1传递数据给下一级
    assign pipe1_alllowin = !pipe1_valid || pipe1_ready_go && pipe2_allowin;
    assign pipe1_to_pipe2_valid = pipe1_valid && pipe1_ready_go;

    always @(posedge clk ) begin
        if (rst == 1'b1) pipe1_valid <= 1'b0;
        else if (pipe1_alllowin == 1'b1) pipe1_valid <= validin;
        if (validin == 1'b1 && pipe1_alllowin == 1'b1) pipe1_data <= datain;     
    end

    /* -----------------pipe2------------------ */
    // local parameter
    wire pipe2_allowin;
    wire pipe2_ready_go;
    wire pipe2_to_pipe3_valid;

    // conditional set
    assign pipe2_ready_go = 1'b1;
    assign pipe2_allowin = !pipe2_valid || pipe2_ready_go && pipe3_allowin;
    assign pipe2_to_pipe3_valid = pipe2_valid && pipe2_ready_go;

    always @(posedge clk) begin
        if (rst == 1'b1) pipe2_valid <= 1'b0;
        else if (pipe2_allowin == 1'b1) pipe2_valid <= pipe1_to_pipe2_valid;
        if (pipe1_to_pipe2_valid && pipe2_allowin) pipe2_data <= pipe1_data;
    end

    /* ----------------pipe3------------------- */
    //local parameter
    wire pipe3_allowin;
    wire pipe3_ready_go;
    
    //conditional set
    assign pipe3_ready_go = 1'b1;
    assign pipe3_allowin = !pipe3_valid || pipe3_ready_go && out_allow;

    always @(posedge clk) begin
        if (rst == 1'b1) pipe3_valid <= 1'b0;
        else if (pipe3_allowin) pipe3_valid <= pipe2_to_pipe3_valid;
        if (pipe2_to_pipe3_valid && pipe3_allowin) pipe3_data <= pipe2_data;
    end
    /* -----------------out--------------------- */

    assign validout = pipe3_ready_go && pipe3_valid;
    assign dataout = pipe3_data;

endmodule
