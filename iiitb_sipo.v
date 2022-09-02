`timescale 1ns/1ps
module dff(d,rst,clk,q);
    input d,clk,rst;
    output reg q;
    always @ (posedge clk)
    begin
    if(~rst)
    q<=0;
    else
    q<=d;
    end
endmodule 

module iiitb_sipo(d, rst, clk, q, qbar);
    input d,clk,rst;
    output [3:0]q;
    output [3:0]qbar;
    dff aa(d, rst, clk, q[3]);
    dff bb(q[3], rst, clk, q[2]);
    dff cc(q[2], rst, clk, q[1]);
    dff dd(q[1], rst, clk, q[0]);
    assign qbar = ~q;
endmodule
