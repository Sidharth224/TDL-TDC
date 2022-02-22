module adder(cin,a,b,sum,cout);

input cin;
input a;
input b;
output sum;
output cout;

assign sum = a ^ b ^ cin;
assign cout = (a&b) | (b&cin) | (a&cin);
endmodule
