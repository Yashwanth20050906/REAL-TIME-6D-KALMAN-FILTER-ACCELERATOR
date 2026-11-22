# 6-Dimensional Kalman Filter (Fixed-Point Q16.16)

This repository contains a 6-Dimensional Kalman Filter hardware accelerator designed in SystemVerilog using fixed-point arithmetic ($Q16.16$, 32-bit width).

---

## Directory Organization

The project has been organized into standard ASIC/FPGA digital design directories:

```
kalmanfilter6d/
│
├── rtl/                        # Hardware RTL implementation files
│   ├── arithmetic/             # Basic fixed-point arithmetic primitives
│   │   ├── adder.sv
│   │   ├── subtractor.sv
│   │   ├── multiplier.sv
│   │   ├── divider.sv
│   │   └── mac.sv
│   │
│   ├── vector/                 # Vector math operations (length N=6)
│   │   ├── vector_add.sv
│   │   ├── vector_sub.sv
│   │   ├── scalar_vector_mult.sv
│   │   ├── dot_product.sv
│   │   └── vector_reg.sv
│   │
│   ├── matrix/                 # Matrix math operations (N×N)
│   │   ├── matrix_add.sv
│   │   ├── matrix_sub.sv
│   │   ├── matrix_mul.sv
│   │   ├── matrix_transpose.sv
│   │   ├── matrix_identity.sv
│   │   ├── matrix_copy.sv
│   │   └── matrix_scalar_mul.sv
│   │
│   ├── solver/                 # Linear equation solver & Cholesky decomposition
│   │   ├── matrix_vector_mul.sv
│   │   ├── cholesky_decomp.sv
│   │   ├── forward_substitution.sv
│   │   ├── backward_substitution.sv
│   │   └── cholesky_solver.sv
│   │
│   ├── kalman/                 # Kalman Filter specific stages
│   │   ├── state_predictor.sv        # Step 1: x_pred = F * x
│   │   ├── covariance_predictor.sv   # Step 2: P_pred = F * P * F' + Q
│   │   ├── innovation.sv             # Step 3: y = z - H * x_pred
│   │   ├── innovation_covariance.sv  # Step 4: S = H * P_pred * H' + R
│   │   ├── kalman_gain.sv            # Step 5: K = P_pred * H' * S^-1
│   │   ├── state_update.sv           # Step 6: x_new = x_pred + K * y
│   │   └── covariance_update.sv      # Step 7: P_new = (I - K * H) * P_pred
│   │
│   └── kalman6d_core.sv        # Top-level Kalman filter hardware module
│
├── tb/                         # Verification testbenches & test vectors
│   ├── kalman6d_tb.sv          # Top-level testbench for kalman6d_core
│   ├── tb_arithmetic.sv        # Unit testbench for arithmetic modules
│   ├── tb_vector_ops.sv        # Unit testbench for vector modules
│   ├── tb_matrix_operations.sv # Unit testbench for matrix modules
│   ├── tb_cholesky_solver.sv   # Unit testbench for solver modules
│   └── *.mem                   # Hex test memory files (inputs & golden outputs)
│       ├── x_input.mem         # Initial state vector x (6x1)
│       ├── z_input.mem         # Measurement vector z (6x1)
│       ├── F_input.mem         # State transition matrix F (6x6)
│       ├── H_input.mem         # Measurement matrix H (6x6)
│       ├── P_input.mem         # Initial covariance matrix P (6x6)
│       ├── x_golden.mem        # Expected golden state vector x
│       └── P_golden.mem        # Expected golden covariance matrix P
│
├── doc/                        # Documentation and Reference Models
│   ├── README.md               # This document
│   └── kalman6d.m              # MATLAB algorithmic reference model & dataset generator
│
└── run/                        # Compilation & Simulation Scripts
    ├── filelist.f              # Master VCS compilation filelist
    ├── kalmanfilter6d.sh       # VCS script to compile and run top core simulation
    ├── run_arithmetic.sh       # VCS script to compile and run arithmetic tests
    ├── run_vector.sh           # VCS script to compile and run vector tests
    ├── run_matrix.sh           # VCS script to compile and run matrix tests
    ├── run_solver.sh           # VCS script to compile and run solver tests
    ├── Makefile                # Makefile for automated compilation and running
    └── clean.sh                # Script to delete VCS/Verdi build & dump artifacts
```

---

## Fixed-Point Format

- **Word Length**: 32 bits (`DW = 32`)
- **Fractional Bits**: 16 bits (`FRAC = 16`, Q16.16)
- **Scale Factor**: $2^{16} = 65536$
- **Signed Representation**: 2's complement

---

## How to Simulate

### Prerequisites
- Synopsys VCS
- Verdi (optional for waveform visualization)

### Running Full Kalman Core Simulation
```bash
cd run
./kalmanfilter6d.sh
```
Or via Make:
```bash
cd run
make core
```

### Running Unit Testbenches
```bash
cd run
./run_arithmetic.sh   # Or: make arithmetic
./run_vector.sh       # Or: make vector
./run_matrix.sh       # Or: make matrix
./run_solver.sh       # Or: make solver
```

### Cleaning Artifacts
```bash
cd run
./clean.sh            # Or: make clean
```
