
`timescale 1ns/1ps
module iiitb_sipo_tb();
reg d,clk,rst;
wire [3:0]q;
iiitb_sipo a(d, rst, clk, q);
 
initial
begin
$dumpfile ("sipo.vcd");
 $dumpvars (0,iiitb_sipo_tb);

clk=1'b0;
forever #5 clk=~clk;
end
initial
begin
rst = 1;d=1;
#10 rst = 0; d=1;
#10 d=0;
#10 d=1;
#10 d=1;
#50 $finish;
end 
endmodule
