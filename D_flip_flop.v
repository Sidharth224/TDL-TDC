module DFF(Din,clk,q);

input Din;
input clk;
output reg q;

initial begin
     q = 0;
end

always@(posedge clk)
q <= Din;

endmodule
