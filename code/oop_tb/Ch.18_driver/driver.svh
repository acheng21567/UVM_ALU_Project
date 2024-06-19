class driver extends uvm_component;

    `uvm_component_utils(driver)

    virtual ALU_BFM bfm;

    // Get port for driver
    uvm_get_port#(command_s) cmd_get_port;

    function new(string name, uvm_component parent);
        super.new(name, parent);
    endfunction: new

    function void build_phase(uvm_phase phase);
        if(!uvm_config_db#(virtual ALU_BFM)::get(null, "*", "bfm", bfm))
            `uvm_fatal("Driver", "Driver failed to get BFM")
        cmd_get_port = new("cmd_get_port", this);
    endfunction: build_phase

    task run_phase(uvm_phase phase);
        command_s cmd;
        shortint alu_result;

        forever begin
            cmd_get_port.get(cmd);
            bfm.send_op(cmd.A, cmd.B, cmd.op, alu_result);
            `uvm_info("Driver", $sformatf("%2h %6s %2h = %4h", cmd.A, cmd.op.name(), cmd.B, alu_result), UVM_MEDIUM)
        end
    endtask: run_phase

endclass: driver