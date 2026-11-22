module kalman6d_core #(parameter N=6, DW=32, FRAC=16)(
    input  logic signed [DW-1:0] X_in  [N],
    input  logic signed [DW-1:0] Z_in  [N],
    input  logic signed [DW-1:0] F     [N][N],
    input  logic signed [DW-1:0] H     [N][N],
    input  logic signed [DW-1:0] P_in  [N][N],

    output logic signed [DW-1:0] X_out [N],
    output logic signed [DW-1:0] P_out [N][N]
);

    // Internal signals
    logic signed [DW-1:0] X_pred [N];
    logic signed [DW-1:0] y      [N];
    logic signed [DW-1:0] K      [N][N];

    // 1. State Prediction
    state_predictor #(N,DW,FRAC) u1(
        .F(F),
        .X_in(X_in),
        .X_pred(X_pred)
    );

    // 2. Innovation
    innovation #(N,DW,FRAC) u2(
        .z(Z_in),
        .H(H),
        .X_pred(X_pred),
        .y(y)
    );

    // 3. Kalman Gain
    kalman_gain #(N,DW,FRAC) u3(
        .P(P_in),
        .H(H),
        .K(K)
    );

    // 4. State Update
    state_update #(N,DW,FRAC) u4(
        .X_pred(X_pred),
        .K(K),
        .y(y),          // 🔥 SAME SIGNAL
        .X_out(X_out)
    );

    // 5. Covariance (pass-through)
    assign P_out = P_in;

endmodule
