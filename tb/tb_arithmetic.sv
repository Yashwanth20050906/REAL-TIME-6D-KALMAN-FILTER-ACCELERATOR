module arithmetic_tb;

parameter DW = 32;
parameter TESTS = 200;

logic signed [DW-1:0] a,b,c;

logic signed [DW-1:0] add_out;
logic signed [DW-1:0] sub_out;
logic signed [DW-1:0] mul_out;
logic signed [DW-1:0] div_out;
logic signed [DW-1:0] mac_out;

adder #(DW)      u1(a,b,add_out);
subtractor #(DW) u2(a,b,sub_out);
multiplier #(DW) u3(a,b,mul_out);
divider #(DW)    u4(a,b,div_out);
mac #(DW)        u5(a,b,c,mac_out);

integer i;
integer pass=0;
integer fail=0;

initial begin

$dumpfile("arithmetic.vcd");
$dumpvars(0,arithmetic_tb);

for(i=0;i<TESTS;i++) begin

a = $urandom_range(-10000,10000);
b = $urandom_range(-10000,10000);
c = $urandom_range(-10000,10000);

#1;

if(add_out == a+b) pass++; else fail++;
if(sub_out == a-b) pass++; else fail++;
if(mul_out == a*b) pass++; else fail++;

if(b!=0) begin
if(div_out == a/b) pass++; else fail++;
end

if(mac_out == (a*b)+c) pass++; else fail++;

end

$display("ARITHMETIC PASS=%0d FAIL=%0d",pass,fail);

$finish;

end

endmodule
