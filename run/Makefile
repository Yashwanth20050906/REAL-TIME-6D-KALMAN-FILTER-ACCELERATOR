# ==============================================================================
# Makefile for Kalman Filter 6D Simulation
# ==============================================================================

VCS = vcs -full64 -sverilog -kdb -debug_access+all

.PHONY: all core arithmetic vector matrix solver clean

all: core

core:
	@cp -n ../tb/*.mem . 2>/dev/null || true
	$(VCS) -f filelist.f
	./simv

arithmetic:
	$(VCS) ../rtl/arithmetic/*.sv ../tb/tb_arithmetic.sv
	./simv

vector:
	$(VCS) ../rtl/vector/*.sv ../tb/tb_vector_ops.sv
	./simv

matrix:
	$(VCS) ../rtl/matrix/*.sv ../tb/tb_matrix_operations.sv
	./simv

solver:
	$(VCS) ../rtl/solver/*.sv ../tb/tb_cholesky_solver.sv
	./simv

clean:
	rm -rf simv simv.daidir csrc verdiLog ucli.key *.vcd *.fsdb *.log novas.* verdi_config_file
