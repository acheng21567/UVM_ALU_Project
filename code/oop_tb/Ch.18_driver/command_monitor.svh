class command_monitor extends uvm_component;

    `uvm_component_utils(command_monitor)

    // Declare a port for sending command struct
    uvm_analysis_port #(command_s) ap;

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

    function operation_t op2enum(bit[2:0] op);
        case(op)
            3'b000: return no_op;
            3'b001: return add_op;
            3'b010: return and_op;
            3'b011: return xor_op;
            3'b100: return mul_op;
            3'b111: return rst_op;
            default: `uvm_fatal("Command Monitor", $sformatf("Illegal opcode %b", op))
        endcase
    endfunction: op2enum

    function void write_to_monitor(byte A, byte B, bit[2:0] op);
        // Create a command struct to send
        command_s cmd;
        cmd.A = A;
        cmd.B = B;
        cmd.op = op2enum(op);

        `uvm_info("Command Monitor", $sformatf("A:0x%2h B:0x%2h op: %s", A, B, cmd.op.name()), UVM_MEDIUM)

        // Send command struct
        ap.write(cmd);
    endfunction: write_to_monitor

endclass: command_monitor