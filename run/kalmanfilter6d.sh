#!/bin/bash
# ==============================================================================
# Simulation Script: Kalman Filter 6D Core
# ==============================================================================
set -e

# Ensure test memory files exist in run directory
cp -n ../tb/*.mem . 2>/dev/null || true

echo "Compiling Kalman Filter 6D Core and Testbench with VCS..."
vcs -full64 -sverilog -f filelist.f -debug_access+all -kdb

echo "Running Simulation..."
./simv
