module top;

    import ALU_pkg::*;
    `include "ALU_macros.svh"

    // Instantiate the DUT, interface and testbench
    ALU iDUT(.clk(), .rst_n(), .A(), .B(), .start(), .opcode(),
             .result(), .done());

    ALU_BFM bfm();

    testbench iTestbench;

    // Instantiate testbench and start testing
    initial begin
        iTestbench = new(bfm);
        iTestbench.execute();
    end

endmodule: top