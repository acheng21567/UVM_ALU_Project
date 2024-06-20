class scoreboard extends uvm_subscriber#(result_transaction);

    `uvm_component_utils(scoreboard)

    // FIFO to get commands from command monitor
    uvm_tlm_analysis_fifo#(cmd_transaction) cmd_fifo;

    function new(string name, uvm_component parent);
        super.new(name, parent);
    endfunction: new
    
    function void build_phase(uvm_phase phase);
        cmd_fifo = new("cmd_fifo", this);
    endfunction: build_phase

    // Get the result based on command
    function result_transaction predict_result(cmd_transaction cmd);
        result_transaction predict;
        predict = new("predict");

        case(cmd.op)
            add_op: predict.result = cmd.A + cmd.B;
            and_op: predict.result = cmd.A & cmd.B;
            xor_op: predict.result = cmd.A ^ cmd.B;
            mul_op: predict.result = cmd.A * cmd.B;
        endcase

        return predict;
    endfunction: predict_result

    // Required for uvm_subscriber
    function void write(result_transaction t);
        cmd_transaction cmd;
        result_transaction predict;
        string s;

        // Filter out no_op and rst_op
        do
            if(!cmd_fifo.try_get(cmd))
                `uvm_fatal("Scoreboard", "Scoreboard cmd fifo is empty")
        while((cmd.op == no_op) || (cmd.op == rst_op));

        predict = predict_result(cmd);

        s = {cmd.convert2string(), " ==> Actual ", t.convert2string(), " Expect ", predict.convert2string()};

        if (!predict.compare(t))
            `uvm_error("Scoreboard", {"Failed: ", s})
        else
            `uvm_info("Scoreboard", {"Passed: ", s}, UVM_MEDIUM)

    endfunction: write

endclass: scoreboard