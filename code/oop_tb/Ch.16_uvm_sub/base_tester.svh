virtual class base_tester extends uvm_component;

    `uvm_component_utils(base_tester);

    virtual ALU_BFM bfm;

    function new(string name, uvm_component parent);
        super.new(name, parent);
    endfunction: new

    pure virtual function operation_t get_op();

    pure virtual function byte get_data();

    function void build_phase(uvm_phase phase);
        if(!uvm_config_db#(virtual ALU_BFM)::get(null, "*", "bfm", bfm))
            `uvm_fatal("Tester", "Tester failed to get BFM")
    endfunction: build_phase


    task run_phase(uvm_phase phase);
        byte unsigned iA;
        byte unsigned iB;
        operation_t iop;
        shortint alu_result;

        phase.raise_objection(this);

        // Reset ALU before testing
        bfm.reset_alu();
        
        repeat(1000) begin
            iop = get_op();
            iA = get_data();
            iB = get_data();
            bfm.send_op(iA, iB, iop, alu_result);
            `uvm_info("Tester", $sformatf("%2h %6s %2h = %4h", iA, iop.name(), iB, alu_result), UVM_MEDIUM)
        end
        #500;

        phase.drop_objection(this);
    endtask: run_phase

endclass: base_tester