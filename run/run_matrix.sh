#!/bin/bash
# ==============================================================================
# Simulation Script: Matrix Unit Test
# ==============================================================================
set -e

echo "Compiling Matrix modules with VCS..."
vcs -full64 -sverilog -kdb -debug_access+all \
  ../rtl/matrix/matrix_add.sv \
  ../rtl/matrix/matrix_copy.sv \
  ../rtl/matrix/matrix_identity.sv \
  ../rtl/matrix/matrix_mul.sv \
  ../rtl/matrix/matrix_scalar_mul.sv \
  ../rtl/matrix/matrix_sub.sv \
  ../rtl/matrix/matrix_transpose.sv \
  ../tb/tb_matrix_operations.sv

echo "Running Matrix Simulation..."
./simv
