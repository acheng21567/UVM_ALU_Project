class random_tester extends uvm_component;

    `uvm_component_utils(random_tester)

    virtual ALU_BFM bfm;

    function new(string name, uvm_component parent);
        super.new(name, parent);
    endfunction

    // Return an operation randomly
    virtual function operation_t get_op();
        bit [2:0] op_choice;
        op_choice = $random;
        case (op_choice)
            3'b000 : return no_op;
            3'b001 : return add_op;
            3'b010 : return and_op;
            3'b011 : return xor_op;
            3'b100 : return mul_op;
            3'b101 : return no_op;
            3'b110 : return rst_op;
            3'b111 : return rst_op;
        endcase // case (op_choice)
    endfunction : get_op

    // Return a 8 bit number with 50% chances, 0 for 25% and 255 for 25%
    virtual function byte get_data();
        bit [1:0] zero_ones;
        zero_ones = $random;
        if (zero_ones == 2'b00)
            return 8'h00;
        else if (zero_ones == 2'b11)
            return 8'hFF;
        else
            return $random;
    endfunction : get_data

    function void build_phase(uvm_phase phase);
        if(!uvm_config_db#(virtual ALU_BFM)::get(null, "*", "bfm", bfm))
            `uvm_fatal("Random_tester", "Random_tester failed to get BFM")
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

endclass: random_tester