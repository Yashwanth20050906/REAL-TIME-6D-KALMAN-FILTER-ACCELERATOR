module tb_matrix_vector_mul;

parameter N  = 6;
parameter M  = 6;
parameter DW = 32;
parameter TESTS = 20;

logic signed [DW-1:0] A [N][M];
logic signed [DW-1:0] x [M];
logic signed [DW-1:0] y [N];

logic signed [DW-1:0] ref_y [N];

matrix_vector_mul #(N,M,DW) dut (
    .A(A),
    .x(x),
    .y(y)
);

integer i,j,t;

integer pass = 0;
integer fail = 0;

initial begin

    $dumpfile("matrix_vec_mul.vcd");
    $dumpvars(0,tb_matrix_vector_mul);

    for(t=0;t<TESTS;t++) begin

        // Random inputs
        for(i=0;i<N;i++)
        for(j=0;j<M;j++)
            A[i][j] = $urandom_range(-10,10);

        for(i=0;i<M;i++)
            x[i] = $urandom_range(-10,10);

        #1;

        // Reference model
        for(i=0;i<N;i++) begin
            ref_y[i] = 0;

            for(j=0;j<M;j++)
                ref_y[i] += A[i][j] * x[j];
        end

        // Compare results
        for(i=0;i<N;i++) begin
            if(y[i] !== ref_y[i]) begin
                fail++;
                $display("FAIL: test=%0d index=%0d DUT=%0d REF=%0d",
                         t,i,y[i],ref_y[i]);
            end
            else
                pass++;
        end

    end

    $display("=================================");
    $display("PASS = %0d",pass);
    $display("FAIL = %0d",fail);
    $display("=================================");

    $finish;

end

endmodule
