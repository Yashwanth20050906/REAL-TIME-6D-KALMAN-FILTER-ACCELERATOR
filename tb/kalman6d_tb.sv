

module kalman6d_tb;

    parameter N = 6;
    parameter DW = 32;

    // INPUTS
    logic signed [DW-1:0] X_in [N];
    logic signed [DW-1:0] Z_in [N];

    logic signed [DW-1:0] F [N][N];
    logic signed [DW-1:0] H [N][N];
    logic signed [DW-1:0] Q [N][N];
    logic signed [DW-1:0] R [N][N];
    logic signed [DW-1:0] P_in [N][N];

    // OUTPUTS
    logic signed [DW-1:0] X_out [N];
    logic signed [DW-1:0] P_out [N][N];

    // GOLDEN
    logic signed [DW-1:0] X_golden [N];
    logic signed [DW-1:0] P_golden [N][N];

    integer i,j;
    integer errors;

    // DUT
   kalman6d_core dut(
    .X_in (X_in),
    .Z_in (Z_in),
    .F (F),
    .H (H),
    .P_in (P_in),
    .X_out (X_out),
    .P_out (P_out)
);
    initial begin

        // =========================
        // FSDB DUMP
        // =========================
        $fsdbDumpfile("dump.fsdb");
        $fsdbDumpvars(0, kalman6d_tb);

        errors = 0;

        // =========================
        // INITIALIZE EVERYTHING
        // =========================
        for (i=0;i<N;i++) begin
            X_in[i] = 0;
            Z_in[i] = 0;
            X_golden[i] = 0;
        end

        for (i=0;i<N;i++) begin
            for (j=0;j<N;j++) begin
                F[i][j] = 0;
                H[i][j] = 0;
                Q[i][j] = 0;
                R[i][j] = 0;
                P_in[i][j] = 0;
                P_golden[i][j] = 0;
            end
        end

        // =========================
        // LOAD MEM FILES
        // =========================
        $readmemh("x_input.mem", X_in);
        $readmemh("z_input.mem", Z_in);

        $readmemh("F_input.mem", F);
        $readmemh("H_input.mem", H);
        $readmemh("Q_input.mem", Q);
        $readmemh("R_input.mem", R);
        $readmemh("P_input.mem", P_in);

        $readmemh("x_golden.mem", X_golden);
        $readmemh("P_golden.mem", P_golden);

        // =========================
        // WAIT FOR STABLE OUTPUT
        // =========================
        #50;
	
// ===== DEBUG INTERNAL SIGNALS =====
$display("\n===== INTERNAL DEBUG =====");
$display("X_pred[0] = %0d", dut.X_pred[0]);
$display("y[0]      = %0d", dut.y[0]);
$display("K[0][0]   = %0d", dut.K[0][0]);
$display("===========================\n");
        // =========================
        // DEBUG SAMPLE
        // =========================
        $display("\n===== DEBUG SAMPLE =====");
        $display("X_out[0] = %0d", X_out[0]);
        $display("Golden   = %0d\n", X_golden[0]);

        // =========================
        // CHECK X
        // =========================
        $display("===== CHECKING RESULTS =====");

        for (i=0;i<N;i++) begin
            if (X_out[i] !== X_golden[i]) begin
                $display("❌ X[%0d] FAIL: DUT=%0d GOLD=%0d",
                         i, X_out[i], X_golden[i]);
                errors++;
            end
        end

        // =========================
        // CHECK P
        // =========================
        for (i=0;i<N;i++) begin
            for (j=0;j<N;j++) begin
                if (P_out[i][j] !== P_golden[i][j]) begin
                    $display("❌ P[%0d][%0d] FAIL: DUT=%0d GOLD=%0d",
                             i,j,P_out[i][j],P_golden[i][j]);
                    errors++;
                end
            end
        end

        // =========================
        // FINAL RESULT
        // =========================
        if (errors == 0)
            $display("\n✅ ALL TESTS PASSED");
        else
            $display("\n❌ TOTAL ERRORS = %0d", errors);

        $finish;
    end

endmodule
