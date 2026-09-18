import spi_pkg::*;

module tb_spi;
    logic clk = 0;
    logic rst_n = 0;
    logic start = 0;
    logic [7:0] tx_data = 8'hA5;
    logic [7:0] rx_data;
    logic sclk, mosi, miso, cs_n, busy;

    // Clock Generation: 100MHz (10ns period)
    always #5 clk = ~clk;

    // Loopback MOSI to MISO for verification
    assign miso = mosi;

    spi_top uut (.*);

    initial begin
        // Dump waveform output file
        $dumpfile("sim_build/spi_waves.vcd");
        $dumpvars(0, tb_spi);

        #20 rst_n = 1;
        #20 start = 1;
        #10 start = 0;
        
        wait(cs_n == 0);
        wait(cs_n == 1);
        
        #20;
        if (rx_data === 8'hA5) begin
            $display("[TEST PASSED] Sent: 0x%h, Received Loopback: 0x%h", tx_data, rx_data);
            $finish(0);
        end else begin
            $error("[TEST FAILED] Expected: 0x%h, Got: 0x%h", tx_data, rx_data);
            $finish(1);
        end
    end
endmodule
