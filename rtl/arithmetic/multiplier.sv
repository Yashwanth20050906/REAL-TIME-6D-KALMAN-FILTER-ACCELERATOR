module multiplier #(parameter DW=32, parameter FRAC=16)
(
input  logic signed [DW-1:0] a,
input  logic signed [DW-1:0] b,
output logic signed [DW-1:0] y
);

logic signed [2*DW-1:0] mult_full;
logic signed [DW-1:0] mult_scaled;

assign mult_full = a * b;

// SCALE BACK TO Q16.16
assign mult_scaled = mult_full >>> FRAC;

// Saturation
assign y = (mult_scaled > 32'sh7FFFFFFF) ? 32'sh7FFFFFFF :
           (mult_scaled < -32'sh80000000) ? -32'sh80000000 :
           mult_scaled;

endmodule
