virtual class base_tester extends uvm_component;

    `uvm_component_utils(base_tester)

    // Put port for tester
    uvm_put_port#(command_s) cmd_put_port;


    function new(string name, uvm_component parent);
        super.new(name, parent);
    endfunction: new

    pure virtual function operation_t get_op();

    pure virtual function byte get_data();

    function void build_phase(uvm_phase phase);
        cmd_put_port = new("cmd_put_port", this);
    endfunction: build_phase

    task run_phase(uvm_phase phase);
        command_s cmd;

        phase.raise_objection(this);

        // Reset ALU before testing
        cmd.op = rst_op;
        cmd_put_port.put(cmd);        
        
        repeat(1000) begin
            cmd.op = get_op();
            cmd.A = get_data();
            cmd.B = get_data();

            // Send command to driver
            cmd_put_port.put(cmd);
        end
        #500;

        phase.drop_objection(this);
    endtask: run_phase

endclass: base_tester