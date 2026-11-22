module innovation #(parameter N=6, DW=32, FRAC=16)(
    input  logic signed [DW-1:0] z      [N],
    input  logic signed [DW-1:0] H      [N][N],
    input  logic signed [DW-1:0] X_pred [N],
    output logic signed [DW-1:0] y      [N]
);

    integer i,j;
    logic signed [63:0] acc;
    logic signed [31:0] hx;

    always_comb begin
        for (i=0;i<N;i++) begin
            acc = 0;

            for (j=0;j<N;j++) begin
                acc += H[i][j] * X_pred[j];  // Q32
            end

            hx = acc >>> FRAC;              // Q16
            y[i] = z[i] - hx;               // correct innovation
        end
    end

endmodule
