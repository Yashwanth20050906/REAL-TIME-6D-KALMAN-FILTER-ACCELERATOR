#!/bin/bash
# ==============================================================================
# Simulation Script: Cholesky & Solver Unit Test
# ==============================================================================
set -e

echo "Compiling Solver modules with VCS..."
vcs -full64 -sverilog -kdb -debug_access+all \
  ../rtl/solver/matrix_vector_mul.sv \
  ../rtl/solver/cholesky_decomp.sv \
  ../rtl/solver/forward_substitution.sv \
  ../rtl/solver/backward_substitution.sv \
  ../rtl/solver/cholesky_solver.sv \
  ../tb/tb_cholesky_solver.sv

echo "Running Solver Simulation..."
./simv
