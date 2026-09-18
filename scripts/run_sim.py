import subprocess
import os
import sys

def run_sim():
    # Ensure build directory exists BEFORE simulation creates the .vcd file
    os.makedirs("sim_build", exist_ok=True)
    
    compile_cmd = (
        "iverilog -g2012 -o sim_build/sim.out "
        "rtl/pkg/spi_pkg.sv rtl/spi_top.sv tb/tb_spi.sv"
    )
    run_cmd = "vvp sim_build/sim.out"
    
    print("[*] Compiling RTL and TB with iverilog...")
    comp_res = subprocess.run(compile_cmd, shell=True, capture_output=True, text=True)
    if comp_res.returncode != 0:
        print("[!] Compilation Failed:\n" + comp_res.stderr)
        sys.exit(1)
        
    print("[*] Running simulation with vvp...")
    run_res = subprocess.run(run_cmd, shell=True, capture_output=True, text=True)
    print(run_res.stdout)
    
    if "[TEST PASSED]" in run_res.stdout:
        print("---> SUCCESS: Simulation passed & waveform dumped!")
    else:
        print("[!] Execution Output / Errors:\n" + run_res.stderr)

if __name__ == "__main__":
    run_sim()
