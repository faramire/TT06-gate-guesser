# SPDX-FileCopyrightText: © 2023 Uri Shaked <uri@tinytapeout.com>, 2024 Fabio Ramirez Stern <github@faramire.de>
# SPDX-License-Identifier: MIT

import cocotb
from cocotb.clock import Clock
from cocotb.triggers import ClockCycles

@cocotb.test()
async def test_guesser(dut):
  dut._log.info("Start")
  
  # Our example module doesn't use clock and reset, but we show how to use them here anyway.
  clock = Clock(dut.clk, 10, units="us")
  cocotb.start_soon(clock.start())

  # Reset
  dut._log.info("Reset")
  dut.ena.value = 1
  dut.ui_in.value = 0
  dut.uio_in.value = 0
  dut.rst_n.value = 0
  await ClockCycles(dut.clk, 10)
  dut.rst_n.value = 1

  # Set the input values, wait one clock cycle, and check the output
  dut._log.info("Test 1")
  dut.ui_in.value = int('11110110', 2)
  dut.uio_in.value = int('11010011', 2)

  await ClockCycles(dut.clk, 1)

  assert dut.uo_out.value == 0

  # Set the input values, wait one clock cycle, and check the output
  dut._log.info("Test 2")
  dut.ui_in.value = int('11101101', 2)
  dut.uio_in.value = int('00001101', 2)

  await ClockCycles(dut.clk, 1)

  assert dut.uo_out.value == 255
