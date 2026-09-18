import spi_pkg::*;

module spi_top (
    input  logic       clk,
    input  logic       rst_n,
    input  logic       start,
    input  logic [7:0] tx_data,
    output logic [7:0] rx_data,
    output logic       sclk,
    output logic       mosi,
    input  logic       miso,
    output logic       cs_n,
    output logic       busy
);
    spi_state_e state, next_state;
    logic [2:0] bit_cnt;
    logic [7:0] shift_reg;
    logic [7:0] rx_reg;

    assign sclk = (state == TRANSFER) ? clk : 1'b0;
    assign mosi = shift_reg[7];
    assign cs_n = (state == IDLE || state == DONE);
    assign busy = (state != IDLE);
    assign rx_data = rx_reg;

    // State Register
    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n) state <= IDLE;
        else        state <= next_state;
    end

    // Next State Logic
    always_comb begin
        next_state = state;
        case (state)
            IDLE:     if (start) next_state = LOAD;
            LOAD:     next_state = TRANSFER;
            TRANSFER: if (bit_cnt == 3'd7) next_state = DONE;
            DONE:     next_state = IDLE;
            default:  next_state = IDLE;
        endcase
    end

    // Datapath
    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            bit_cnt   <= '0;
            shift_reg <= '0;
            rx_reg    <= '0;
        end else begin
            case (state)
                LOAD: begin
                    shift_reg <= tx_data;
                    bit_cnt   <= '0;
                end
                TRANSFER: begin
                    shift_reg <= {shift_reg[6:0], 1'b0};
                    rx_reg    <= {rx_reg[6:0], miso};
                    bit_cnt   <= bit_cnt + 1'b1;
                end
            endcase
        end
    end
endmodule
