python3 -c '
content = """# SystemVerilog SPI Controller & Automated Verification Pipeline

## Overview
Synthesizable SystemVerilog implementation of a full-duplex SPI Master controller featuring dynamic clock generation, state machine execution, and automated testbench verification via Python.

## Key Features & RTL Architecture
- **RTL Design:** Multi-process FSM control logic with synchronous reset handling and parameterizable bit widths.
- **Verification:** Self-checking SystemVerilog testbench utilizing automated pass/fail assertions and loopback verification.
- **Automation Pipeline:** Python script orchestrating compilation, execution, log parsing, and `.vcd` trace dumping using Icarus Verilog (`iverilog`) and Surfer.

## Directory Structure
- `rtl/`: Core SystemVerilog modules (`spi_top.sv`, `fifo_sync.sv`) and package definitions (`spi_pkg.sv`).
- `tb/`: Verification environment (`tb_spi.sv`) and stimulus generation.
- `scripts/`: Python test runners (`run_sim.py`) and build automation.

## How to Run Simulation
```bash
python3 scripts/run_sim.py
