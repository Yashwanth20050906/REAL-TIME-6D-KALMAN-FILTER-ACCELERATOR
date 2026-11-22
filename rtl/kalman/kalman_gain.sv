module kalman_gain #(parameter N=6, DW=32, FRAC=16)(
    input  logic signed [DW-1:0] P      [N][N],
    input  logic signed [DW-1:0] H      [N][N],
    output logic signed [DW-1:0] K      [N][N]
);

    integer i,j,k;
    logic signed [63:0] acc;

    always_comb begin
        for (i=0;i<N;i++) begin
            for (j=0;j<N;j++) begin
                acc = 0;

                for (k=0;k<N;k++) begin
                    acc += P[i][k] * H[k][j];   // H^T
                end

                K[i][j] = acc >>> FRAC;         // Q16
            end
        end
    end

endmodule
