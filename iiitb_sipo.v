module dff(d,clk,q);
    input d,clk;
    output q;
    reg q=0;
    always @ (posedge clk)
    begin
    q<=d;
    end
endmodule 

module sipo(d, clk, q);
    input d,clk;
    output [3:0]q;
    dff aa(d, clk, q[3]);
    dff bb(q[3], clk, q[2]);
    dff cc(q[2], clk, q[1]);
    dff dd(q[1], clk, q[0]);
endmodule
