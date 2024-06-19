class scoreboard extends uvm_subscriber#(shortint);

    `uvm_component_utils(scoreboard)

    // FIFO to get commands from command monitor
    uvm_tlm_analysis_fifo#(command_s) cmd_fifo;

    function new(string name, uvm_component parent);
        super.new(name, parent);
    endfunction: new
    
    function void build_phase(uvm_phase phase);
        cmd_fifo = new("cmd_fifo", this);
    endfunction: build_phase

    // Required for uvm_subscriber
    function void write(shortint t);
        shortint predicted_result;
        command_s cmd;
        cmd.op = no_op;

        // Filter out no_op and rst_op
        do
            if(!cmd_fifo.try_get(cmd))
                `uvm_fatal("Scoreboard", "Scoreboard cmd fifo empty")
        while((cmd.op == no_op) || (cmd.op == rst_op));

        case (cmd.op)
            add_op: predicted_result = cmd.A + cmd.B;
            and_op: predicted_result = cmd.A & cmd.B;
            xor_op: predicted_result = cmd.A ^ cmd.B;
            mul_op: predicted_result = cmd.A * cmd.B;
        endcase

        if (predicted_result != t)
            `uvm_error("Scoreboard", $sformatf("FAILED: A: %0h  B: %0h  op: %s result: %0h expect: %0h",
                                    cmd.A, cmd.B, cmd.op.name(), t, predicted_result))

    endfunction: write

endclass: scoreboard