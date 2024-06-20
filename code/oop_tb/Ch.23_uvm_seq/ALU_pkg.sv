package ALU_pkg;

    import uvm_pkg::*;
    `include "uvm_macros.svh"

    typedef enum bit[2:0] { no_op  = 3'b000,
                            add_op = 3'b001, 
                            and_op = 3'b010,
                            xor_op = 3'b011,
                            mul_op = 3'b100,
                            rst_op = 3'b111} operation_t;

    `include "sequence_item.svh"
    `include "fibonacci_sequence.svh"

    `include "random_sequence.svh"
    `include "reset_sequence.svh"
    `include "maxmult_sequence.svh"
    
    `include "cmd_transaction.svh"
    `include "result_transaction.svh"

    `include "sequencer.svh"
    `include "driver.svh"
    `include "coverage.svh"
    `include "scoreboard.svh"
    `include "command_monitor.svh"
    `include "result_monitor.svh"

    `include "runall_sequence.svh"
    `include "parallel_sequence.svh"

    `include "env.svh"

    `include "base_test.svh"
    `include "fibonacci_test.svh"
    `include "full_test.svh"
    `include "parallel_test.svh"

endpackage: ALU_pkg