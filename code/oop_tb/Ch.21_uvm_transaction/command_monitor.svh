class command_monitor extends uvm_component;

    `uvm_component_utils(command_monitor)

    // Declare a port for sending command struct
    uvm_analysis_port #(cmd_transaction) ap;

    function new(string name, uvm_component parent);
        super.new(name, parent);
    endfunction: new

    function void build_phase(uvm_phase phase);
        // Assign command monitor handle in ALU_BFM to this object
        virtual ALU_BFM bfm;
        if(!uvm_config_db#(virtual ALU_BFM)::get(null, "*", "bfm", bfm))
            `uvm_fatal("Command Monitor", "Command monitor failed to get BFM")
        bfm.iCommand_monitor = this;

        // Instantiate port
        ap = new("ap", this);
    endfunction: build_phase

    function void write_to_monitor(byte A, byte B, operation_t op);
        // Create a command struct to send
        cmd_transaction cmd;
        cmd = new("cmd");
        cmd.A = A;
        cmd.B = B;
        cmd.op = op;

        `uvm_info("Command Monitor", $sformatf("A:0x%2h B:0x%2h op: %s", A, B, op.name()), UVM_MEDIUM)

        // Send command struct
        ap.write(cmd);
    endfunction: write_to_monitor

endclass: command_monitor