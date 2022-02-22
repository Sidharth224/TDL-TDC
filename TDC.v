`include "adder.v"
`include "D_flip_flop.v"
`include "defines.v"
`include "encoder.v"

module TDC(start, stop, clk, TDCout);

genvar i;
//integer NUM_STAGES = 300;
wire [`NUM_STAGES-1:0] cout;
wire [`NUM_STAGES-1:0] Din; 
wire [`NUM_STAGES-1:0] Qout;

input start;
input stop;
input clk;

output [`NUM_STAGES-1:0] TDCout;
//output integer TDCout;
//configuring the delay chain
for(i = 0; i <= `NUM_STAGES - 1; i = i + 1)begin
	if(i == 0)
		//adder adder_1(start,0,1,Din[i],cout[i]);
		adder adder_1( 
			.cin (start),
		       	.a (0),
		       	.b (1),
		       	.sum (Din[i]),
		       	.cout (cout[i]));
	else 
		//adder adder_2(cout[i-1],0,1,Din[i],cout[i]);
		adder adder_2( 
			.cin (cout[i-1]),
			.a (0),
		       	.b (1),
		  	.sum (Din[i]),
		       	.cout (cout[i]));

end

for(i = 0; i <= `NUM_STAGES - 1; i = i + 1)begin
	DFF DFF1(
		.Din (Din[i]),
		.clk (stop),
		.q (Qout[i]));
end

priority_encoder encoder1(
		.a (Qout),
		.y (TDCout));

endmodule