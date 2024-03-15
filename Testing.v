`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/06/2023 03:38:05 PM
// Design Name: 
// Module Name: Testing
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


module ALU(a,b,aluc, r,z);
  input wire [31:0] a,b;
  input wire [3:0] aluc;
  //input wire clk;
  output wire z;
  output wire [31:0] r;
  
  wire [31:0] d_and = a & b;
  wire [31:0] d_or = a | b;
  wire [31:0] d_xor = a ^ b;
  wire [31:0] d_lui = {b[15:0], 16'h0};
  wire [31:0] d_and_or = aluc[2] ? d_or : d_and;
  wire [31:0] d_xor_lui = aluc[2] ? d_lui : d_xor;
  wire [31:0] d_as, d_sh;
  
  addsub32 as32 (a,b,aluc[2], d_as);
  
  shift shifter (b,a[4:0], aluc[2], aluc[3], d_sh);
  
  mux4x32 res (d_as, d_and_or, d_xor_lui, d_sh, aluc[1:0], r);
  assign z = ~|r;
  
endmodule

module mux4x32 (input [31:0] input1, 
                input [31:0] input2,
                input [31:0] input3,
                input [31:0] input4,
                input [1:0] select,
                output reg [31:0] out);
  always @(*) begin
    out <= select[1] ? (select[0]? input3 : input4) : (select[0] ? input2 : input1);
  end
endmodule

module addsub32(input [31:0] a,
                input [31:0] b,
                input aluc,
                output [31:0] s);
    wire [31:0] b_xor_sub = b^{32{aluc}};
    
    //always @(*) begin
        cla32 as32 (a,b_xor_sub, aluc, s);
    //end
endmodule

module cla32(input [31:0] a, 
             input [31:0] b,
             input aluc, 
             output wire [31:0] s);
             
    assign s = a + b;
endmodule

module shift (input [31:0] d,
              input [4:0] a,
              input right,
              input arith,
              output reg [31:0] sh);
    always @(*) begin
        if(!right) begin
            sh = d << a;
        end else if (!arith) begin
            sh = d >> a;
        end else begin
            sh = $signed(d) >>> a;
        end
    end
endmodule
