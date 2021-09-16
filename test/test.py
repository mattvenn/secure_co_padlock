import cocotb
from cocotb.clock import Clock
from cocotb.triggers import RisingEdge, FallingEdge, ClockCycles

async def reset(dut):
    dut.reset <= 1
    await ClockCycles(dut.clk, 2)
    dut.reset <= 0

@cocotb.test()
async def test_pwm(dut):
    clock = Clock(dut.clk, 10, units="us")
    cocotb.fork(clock.start())
   
    dut.but_0 <= 0
    dut.but_1 <= 0
    dut.but_2 <= 0
    dut.but_3 <= 0
    dut.but_4 <= 0
    dut.but_5 <= 0
    dut.but_6 <= 0
    dut.but_7 <= 0
    dut.but_8 <= 0
    dut.but_9 <= 0
    dut.open  <= 0

    await reset(dut)

    # check padlock is locked
    assert dut.lock == 1

    # press open button and assert still locked
    dut.open <= 1
    await RisingEdge(dut.clk)
    assert dut.lock == 1
    dut.open <= 0

    # type the code: 2130
    dut.but_0 <= 1
    dut.but_2 <= 1
    dut.but_4 <= 1
    dut.but_6 <= 1
    dut.open <= 1
    await RisingEdge(dut.clk)

    # wait 1 cycle for the flop to change
    await RisingEdge(dut.clk)
    assert dut.lock == 0
    await ClockCycles(dut.clk, 5)
        
