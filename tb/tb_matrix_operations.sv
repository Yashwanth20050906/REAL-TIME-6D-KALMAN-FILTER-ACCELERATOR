module matrix_tb;

parameter N=6;
parameter DW=32;
parameter TESTS=50;

logic signed [DW-1:0] A[N][N];
logic signed [DW-1:0] B[N][N];
logic signed [DW-1:0] C[N][N];

matrix_mul #(N,N,N,DW) dut(A,B,C);

integer i,j,k,t;

integer pass=0;
integer fail=0;

// renamed from ref -> ref_mat
logic signed [DW-1:0] ref_mat[N][N];

initial begin

    $dumpfile("matrix.vcd");
    $dumpvars(0,matrix_tb);

    for(t=0;t<TESTS;t++) begin

        // random inputs
        for(i=0;i<N;i++)
        for(j=0;j<N;j++) begin
            A[i][j] = $urandom_range(-50,50);
            B[i][j] = $urandom_range(-50,50);
        end

        #1;

        /* reference model */

        for(i=0;i<N;i++)
        for(j=0;j<N;j++) begin

            ref_mat[i][j] = 0;

            for(k=0;k<N;k++)
                ref_mat[i][j] += A[i][k] * B[k][j];

        end

        /* compare */

        for(i=0;i<N;i++)
        for(j=0;j<N;j++) begin
            if(C[i][j] == ref_mat[i][j])
                pass++;
            else begin
                fail++;
                $display("Mismatch at [%0d][%0d]  C=%0d  REF=%0d",
                          i,j,C[i][j],ref_mat[i][j]);
            end
        end

    end

    $display("=====================================");
    $display("MATRIX PASS = %0d", pass);
    $display("MATRIX FAIL = %0d", fail);
    $display("=====================================");

    $finish;

end

endmodule
