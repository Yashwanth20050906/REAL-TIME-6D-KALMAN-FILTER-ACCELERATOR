module state_update #(parameter N=6, DW=32, FRAC=16)(
    input  logic signed [DW-1:0] X_pred [N],
    input  logic signed [DW-1:0] K      [N][N],
    input  logic signed [DW-1:0] y      [N],
    output logic signed [DW-1:0] X_out  [N]
);

    integer i,j;
    logic signed [63:0] acc;
    logic signed [31:0] corr;

    always_comb begin
        for (i=0;i<N;i++) begin
            acc = 0;

            for (j=0;j<N;j++) begin
                acc += K[i][j] * y[j];   // Q32
            end

            corr = acc >>> FRAC;        // Q16
            X_out[i] = X_pred[i] + corr;
        end
    end

endmodule
