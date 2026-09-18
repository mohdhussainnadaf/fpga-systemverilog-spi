package spi_pkg;
  typedef enum logic [1:0] {
    IDLE     = 2'b00,
    LOAD     = 2'b01,
    TRANSFER = 2'b10,
    DONE     = 2'b11
  } spi_state_e;
endpackage
