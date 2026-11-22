module matrix_mul #(parameter N=6, DW=32, FRAC=16)
(
    input  logic signed [DW-1:0] A [N][N],
    input  logic signed [DW-1:0] B [N][N],
    output logic signed [DW-1:0] Y [N][N]
);

    logic signed [63:0] acc;

    always_comb begin
        for (int i = 0; i < N; i++) begin
            for (int j = 0; j < N; j++) begin

                acc = 0;

                for (int k = 0; k < N; k++) begin
                    acc += A[i][k] * B[k][j];
                end

                Y[i][j] = acc >>> FRAC;  // ✅ ONLY scaling
            end
        end
    end

endmodule
