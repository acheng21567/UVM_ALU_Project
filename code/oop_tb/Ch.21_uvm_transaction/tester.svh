class tester extends uvm_component;

    `uvm_component_utils(tester)

    // Put port for tester
    uvm_put_port#(cmd_transaction) cmd_put_port;

    function new(string name, uvm_component parent);
        super.new(name, parent);
    endfunction: new

    function void build_phase(uvm_phase phase);
        cmd_put_port = new("cmd_put_port", this);
    endfunction: build_phase

    task run_phase(uvm_phase phase);
        cmd_transaction cmd;

        phase.raise_objection(this);

        // Reset ALU before testing
        cmd = new("cmd");
        cmd.op = rst_op;
        cmd_put_port.put(cmd);

        // Start testing
        repeat(1000) begin
            cmd = cmd_transaction::type_id::create("cmd");
            assert(cmd.randomize());
            cmd_put_port.put(cmd);
        end
        #500;

        phase.drop_objection(this);
    endtask: run_phase

endclass: tester