class result_monitor extends uvm_component;

    `uvm_component_utils(result_monitor)

    // Declare a port for sending result
    uvm_analysis_port#(shortint) ap;

    function new(string name, uvm_component parent);
        super.new(name, parent);
    endfunction: new

    function void build_phase(uvm_phase phase);
        // Assign result monitor handle in ALU_BFM to this object
        virtual ALU_BFM bfm;
        if(!uvm_config_db#(virtual ALU_BFM)::get(null, "*", "bfm", bfm))
            `uvm_fatal("Result Monitor", "Result monitor failed to get BFM")
        bfm.iResult_monitor = this;

        // Instantiate port
        ap = new("ap", this);
    endfunction: build_phase

    function void write_to_monitor(shortint r);
        `uvm_info("Result Monitor", $sformatf("Result is 0x%0h", r), UVM_MEDIUM)
        ap.write(r);
    endfunction: write_to_monitor

endclass: result_monitor