`include "defines.v"

module priority_encoder(a,y);

input [`NUM_STAGES-1:0] a;
output integer y;
integer i;

always@(a) begin : disable_block
	for(i=0; i<= `NUM_STAGES-1; i=i+1)begin
		$display("a[i] = %b, i = %d",a[i],i);
		if(a[i] == 1 && i == 0)begin
			y = 0;
			disable disable_block;
		end
		else if(a[i] == 1)begin
			y = i+1;
			disable disable_block;
		end
	end
end
//$display("y = %d",y);

endmodule