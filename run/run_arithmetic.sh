#!/bin/bash
# ==============================================================================
# Simulation Script: Arithmetic Unit Test
# ==============================================================================
set -e

echo "Compiling Arithmetic modules with VCS..."
vcs -full64 -sverilog -kdb -debug_access+all \
  ../rtl/arithmetic/adder.sv \
  ../rtl/arithmetic/divider.sv \
  ../rtl/arithmetic/mac.sv \
  ../rtl/arithmetic/multiplier.sv \
  ../rtl/arithmetic/subtractor.sv \
  ../tb/tb_arithmetic.sv

echo "Running Arithmetic Simulation..."
./simv
