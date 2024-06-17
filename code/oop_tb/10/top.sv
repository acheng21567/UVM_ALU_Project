module top;

    import ALU_pkg::*;
    `include "ALU_macros.svh"

    // Instantiate the DUT, interface and testbench
    ALU iDUT(.clk(bfm.clk), .rst_n(bfm.rst_n), .A(bfm.A), .B(bfm.B), .start(bfm.start), .opcode(bfm.op),
             .result(bfm.result), .done(bfm.done));

    ALU_BFM bfm();

    testbench iTestbench;

    // Instantiate testbench and start testing
    initial begin
        iTestbench = new(bfm);
        iTestbench.execute();
    end

endmodule: top