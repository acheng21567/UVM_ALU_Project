class driver extends uvm_driver#(sequence_item);

    `uvm_component_utils(driver);

    virtual ALU_BFM bfm;

    function new(string name, uvm_component parent);
        super.new(name, parent);
    endfunction: new

    function void build_phase(uvm_phase phase);
        if(!uvm_config_db#(virtual ALU_BFM)::get(null, "*", "bfm", bfm))
            `uvm_fatal("Driver", "Driver failed to get BFM")
    endfunction: build_phase

    task run_phase(uvm_phase phase);
        sequence_item cmd;

        forever begin
            shortint unsigned result;
            
            // Get a sequence_item from built-in port
            seq_item_port.get_next_item(cmd);
            bfm.send_op(cmd.A, cmd.B, cmd.op, result);
            cmd.result = result;
            
            // Notify sequncer that driver finish with current sequence_item
            seq_item_port.item_done();
        end
    endtask: run_phase

endclass: driver