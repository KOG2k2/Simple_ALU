`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/06/2023 03:39:40 PM
// Design Name: 
// Module Name: Test_tb
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01  - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

module Test_ALU();
    reg [31:0] input1, input2;
    reg [3:0] aluc;
    reg clk;
    wire z;
    wire [31:0] r;
    
    initial clk = 0;
    always #10 clk = ~clk;

    ALU dut(input1, input2, aluc,clk, r, z);
    
    initial begin
        input1 = 10;
        input2 = 3;
    end
    
    always @(posedge clk) begin
        aluc = 4'b0000; //ADD operation
        #50 aluc = 4'b0100;
        #50 aluc = 4'b0001;
        #50 aluc = 4'b0110;
        #50 aluc = 4'b0011;
        #50 aluc = 4'b0111;
        #50 aluc = 4'b1111;
    end

endmodule
