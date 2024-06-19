
module top;
    // Import uvm package and macros
    import uvm_pkg::*;
    `include "uvm_macros.svh"
    // Import custom package and macros
    import ALU_pkg::*;
    `include "ALU_macros.svh"

    // Instantiate the DUT, interface and testbench
    ALU iDUT(.clk(bfm.clk), .rst_n(bfm.rst_n), .A(bfm.A), .B(bfm.B), .start(bfm.start), .opcode(bfm.op),
             .result(bfm.result), .done(bfm.done));

    ALU_BFM bfm();

    // Instantiate testbench and start testing
    initial begin
        uvm_config_db#(virtual ALU_BFM)::set(null, "*", "bfm", bfm);
        run_test();
    end

endmodule: top