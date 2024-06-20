class cmd_transaction extends uvm_transaction;

    `uvm_object_utils(cmd_transaction)

    rand byte unsigned      A;
    rand byte unsigned      B;
    rand operation_t        op;

    constraint data{ A dist {8'h00:=1, [8'h01 : 8'hFE]:= 1, 8'hFF:= 1};
                     B dist {8'h00:=1, [8'h01 : 8'hFE]:= 1, 8'hFF:= 1};}

    function new(string name = "cmd_transaction");
        super.new(name);
    endfunction: new

    // Deep copy caller to rhs parameter
    function void do_copy(uvm_object rhs);
        cmd_transaction to_copy;

        // Check if rhs is null
        if(rhs == null)
            `uvm_fatal("Command Transaction", "Tring to copy from a null pointer")

        // Check if rhs is the same type
        if(!$cast(to_copy, rhs))
            `uvm_fatal("Command Transaction", "Tring to copy from a wrong type")

        // Copy data in parent class
        super.do_copy(rhs);

        // Copy data in the class
        this.A = to_copy.A;
        this.B = to_copy.B;
        this.op = to_copy.op;
    endfunction: do_copy

    // Clone a new copy of caller in cmd_transaction type
    function cmd_transaction clone_me();
        cmd_transaction clone;
        // Call clone() and cast it cmd_transaction type
        $cast(clone, this.clone());
        return clone;
    endfunction: clone_me


    // Compare caller and rhs parameter
    function bit do_compare(uvm_object rhs, uvm_comparer comparer);
        cmd_transaction to_compare;
        bit isSame;

        // Check if rhs is null or the same type
        if(rhs == null || !$cast(to_compare, rhs))
            isSame = 0;
        else
            // Check if parent data and data are the same
            isSame =  super.do_compare(rhs, comparer) &&
                    (this.A == to_compare.A) &&
                    (this.B == to_compare.B) &&
                    (this.op == to_compare.op);

        return isSame;
    endfunction: do_compare

    // Convert caller's information into string
    function string convert2string();
        string s;
        s = $sformatf("A %2h B: %2h op: %s", A, B, op.name());
        return s;
    endfunction: convert2string



endclass: cmd_transaction