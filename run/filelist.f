// ==============================================================================
// 6-Dimensional Kalman Filter - File List
// Paths are relative to the run/ directory
// ==============================================================================

// RTL - Arithmetic Modules
../rtl/arithmetic/adder.sv
../rtl/arithmetic/subtractor.sv
../rtl/arithmetic/multiplier.sv
../rtl/arithmetic/divider.sv
../rtl/arithmetic/mac.sv

// RTL - Vector Operations
../rtl/vector/vector_add.sv
../rtl/vector/vector_sub.sv
../rtl/vector/scalar_vector_mult.sv
../rtl/vector/dot_product.sv
../rtl/vector/vector_reg.sv

// RTL - Matrix Operations
../rtl/matrix/matrix_add.sv
../rtl/matrix/matrix_sub.sv
../rtl/matrix/matrix_mul.sv
../rtl/matrix/matrix_transpose.sv
../rtl/matrix/matrix_identity.sv
../rtl/matrix/matrix_copy.sv
../rtl/matrix/matrix_scalar_mul.sv

// RTL - Cholesky & Linear Solver
../rtl/solver/matrix_vector_mul.sv
../rtl/solver/cholesky_decomp.sv
../rtl/solver/forward_substitution.sv
../rtl/solver/backward_substitution.sv
../rtl/solver/cholesky_solver.sv

// RTL - Kalman Filter Pipeline Stages
../rtl/kalman/state_predictor.sv
../rtl/kalman/covariance_predictor.sv
../rtl/kalman/innovation.sv
../rtl/kalman/innovation_covariance.sv
../rtl/kalman/kalman_gain.sv
../rtl/kalman/state_update.sv
../rtl/kalman/covariance_update.sv

// RTL - Kalman Filter 6D Core Top
../rtl/kalman6d_core.sv

// Testbench
../tb/kalman6d_tb.sv
