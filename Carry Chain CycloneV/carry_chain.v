module primitive_carry(
		input wire a,
		input wire b,
		input wire cin,
		output wire cout,
		output wire s
		);
		
cyclonev_lcell_comb #(
	.dont_touch("off")
	) mycarry ( 
						.dataa(),
						.datab(b),
						.datac(a),
						.datad(),
						.datae(),
						.dataf(),
						.datag(),
						.cin(cin),
						.sharein(),
						.combout(),
						.sumout(s),
						.cout(cout)
);

defparam mycarry.lut_mask = 64'h0000000000000000;

endmodule

module primitive_ff(
		input wire s,
		input wire clk,
		input wire clr,
		input wire ena,
		output wire q
		);

cyclonev_ff myff (
		.d(s),
		.clk(clk),
		.clrn(),
		.aload(),
		.sclr(clr),
		.sload(),
		.asdata(),
		.ena(ena),
		.devclrn(),
		.devpor(),
		.q(q)
);

endmodule

module primitive_carry_in(
		input wire datac,
		output wire cout
		);
		
cyclonev_lcell_comb #(
	.dont_touch("off")
	) mycarryin ( 
						.dataa(),
						.datab(b),
						.datac(datac),
						.datad(),
						.datae(),
						.dataf(),
						.datag(),
						.cin(0),
						.sharein(),
						.combout(),
						.sumout(s),
						.cout(cout)
);

defparam mycarryin.lut_mask=64'h000000000F0F0F0F;

endmodule

//module top(input clk)(
//	carry_chain




//endmodule


module carry_chain #(parameter N=32) (
		input wire [N-1:0] a,
		input wire [N-1:0] b,
		input wire carryin,
		input wire clk,
		input wire enable,
		input wire clear,
		output wire [N-1:0] regout,
		output wire carryout
);


wire [N:0] c_internal;

primitive_carry_in mycarry_in (
		.datac(carryin),
		.cout(c_internal[0]),
);

wire [N-1:0] s;

genvar i;

generate
for(i=1; i<N+1; i=i+1) begin : gen

	primitive_carry mycarry (
		.a(a[i-1]),
		.b(b[i-1]),
		.cin(c_internal[i-1]),
		.cout(c_internal[i]),
		.s(s[i-1])
	);

	primitive_ff myff(
		.s(s[i-1]),
		.clk(clk),
		.q(regout[i-1]),
		.clr(clear),
		.ena(enable)
		);
		
end
endgenerate
assign carryout=c_internal[N];
endmodule

