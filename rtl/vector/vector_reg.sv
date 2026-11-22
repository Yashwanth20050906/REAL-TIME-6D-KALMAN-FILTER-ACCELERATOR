module vector_reg #(parameter N=6, DW=32)
(
input  logic clk,
input  logic rst,
input  logic en,
input  logic signed [DW-1:0] d [N],
output logic signed [DW-1:0] q [N]
);

integer i;

always_ff @(posedge clk or posedge rst) begin
    if (rst) begin
        for (i=0; i<N; i++)
            q[i] <= 0;
    end
    else if (en) begin
        for (i=0; i<N; i++)
            q[i] <= d[i];
    end
end

endmodule
