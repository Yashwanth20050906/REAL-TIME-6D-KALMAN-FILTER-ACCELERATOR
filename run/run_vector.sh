#!/bin/bash
# ==============================================================================
# Simulation Script: Vector Unit Test
# ==============================================================================
set -e

echo "Compiling Vector modules with VCS..."
vcs -full64 -sverilog -kdb -debug_access+all \
  ../rtl/vector/dot_product.sv \
  ../rtl/vector/scalar_vector_mult.sv \
  ../rtl/vector/vector_add.sv \
  ../rtl/vector/vector_reg.sv \
  ../rtl/vector/vector_sub.sv \
  ../tb/tb_vector_ops.sv

echo "Running Vector Simulation..."
./simv
