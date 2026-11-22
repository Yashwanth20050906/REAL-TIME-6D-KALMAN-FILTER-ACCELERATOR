#!/bin/bash
# ==============================================================================
# Clean generated simulation and log files
# ==============================================================================
echo "Cleaning simulation artifacts..."
rm -rf simv simv.daidir csrc verdiLog ucli.key *.vcd *.fsdb *.log novas.* verdi_config_file
echo "Clean complete."
