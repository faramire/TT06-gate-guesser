/*
 * Copyright (c) 2024 Fabio Ramirez Stern
 * SPDX-License-Identifier: Apache-2.0
 */

`define default_netname none

module tt_um_faramire_gate_guesser (
    input  wire [7:0] ui_in,    // Dedicated inputs  0 -> 7
    output wire [7:0] uo_out,   // Dedicated outputs 0 -> 7
    input  wire [7:0] uio_in,   // IOs: Input path   8 -> F
    output wire [7:0] uio_out,  // IOs: Output path  (not used)
    output wire [7:0] uio_oe,   // IOs: Enable path (active high: 0=input, 1=output)
    input  wire       ena,      // enable (not used)
    input  wire       clk,      // clock (not used)
    input  wire       rst_n     // reset_n - low to reset (not used)
);

  // All output pins must be assigned. If not used, assign to 0.
  assign uio_oe  = 0; // always in
  assign uio_out = 0;

  // [out] = [in1] OP [in2]

  // 0 = 0 AND 2
  assign uo_out[0] = ui_in[0] & ui_in[2];

  // 1 = NOT 1
  assign uo_out[1] = ~ui_in[1];

  // 2 = 5 AND 7 AND A
  assign uo_out[2] = ui_in[5] & ui_in[7] & uio_in[2];

  // 3 = 6 XOR C
  assign uo_out[3] = ui_in[6] ^ uio_in[4];
  
  // 4 = 4 NAND 9
  assign uo_out[4] = ui_in[4] ~& uio_in[1];
  
  // 5 = 8 XNOR B
  assign uo_out[5] = uio_in[0] ~^ uio_in[3];
  
  // 6 = E NOR F
  assign uo_out[6] = uio_in[6] ~| uio_in[7];
  
  // 7 = 3 OR D
  assign uo_out[7] = ui_in[3] | uio_in[5];

endmodule
