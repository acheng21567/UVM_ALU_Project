class sequence_item extends uvm_sequence_item;

    `uvm_object_utils(sequence_item)

    rand byte unsigned      A;
    rand byte unsigned      B;
    rand operation_t        op;
    shortint unsigned       result;

    constraint data{ A dist {8'h00:=1, [8'h01 : 8'hFE]:= 1, 8'hFF:= 1};
                     B dist {8'h00:=1, [8'h01 : 8'hFE]:= 1, 8'hFF:= 1};}

    constraint op_con{op dist {no_op:=1, add_op:=5, and_op:=5, xor_op:=5, mul_op:=5, rst_op:=1};}

    
    // Compare caller and rhs parameter
    function bit do_compare(uvm_object rhs, uvm_comparer comparer);
        sequence_item to_compare;
        bit isSame;

        // Check if rhs is null or the same type
        if(rhs == null || !$cast(to_compare, rhs))
            isSame = 0;
        else
            // Check if parent data and data are the same
            isSame = super.do_compare(rhs, comparer) &&
                    (this.A == to_compare.A) &&
                    (this.B == to_compare.B) &&
                    (this.op == to_compare.op) &&
                    (this.result == to_compare.result);

        return isSame;
    endfunction: do_compare

    // Deep copy caller to rhs parameter
    function void do_copy(uvm_object rhs);
        sequence_item to_copy;

        // Check if rhs is null
        if(rhs == null)
            `uvm_fatal("Sequence Item", "Tring to copy from a null pointer")

        // Check if rhs is the same type
        if(!$cast(to_copy, rhs))
            `uvm_fatal("Sequence Item", "Tring to copy from a wrong type")

        // Copy data in parent class
        super.do_copy(rhs);

        // Copy data in the class
        this.A = to_copy.A;
        this.B = to_copy.B;
        this.op = to_copy.op;
        this.result = to_copy.result;
    endfunction: do_copy

    // Convert caller's information into string
    function string convert2string();
        string s;
        s = $sformatf("A: %2h op: %s B: %2h = %4h", A, op.name(), B, result);
        return s;
    endfunction: convert2string

endclass: sequence_item