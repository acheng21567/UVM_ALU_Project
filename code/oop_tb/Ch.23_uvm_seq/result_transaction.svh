class result_transaction extends uvm_transaction;

    shortint result;

    function new(string name = "");
        super.new(name);
    endfunction: new

    // Deep copy caller to rhs parameter
    function void do_copy(uvm_object rhs);
        result_transaction to_copy;

        // Check if rhs is null
        if(rhs == null)
            `uvm_fatal("Result Transaction", "Tring to copy from a null pointer")

        // Check if rhs is the same type
        if(!$cast(to_copy, rhs))
            `uvm_fatal("Result Transaction", "Tring to copy from a wrong type")

        // Copy data in parent class
        super.do_copy(rhs);

        // Copy data in the class
        this.result = to_copy.result;
    endfunction: do_copy

    // Compare caller and rhs parameter
    function bit do_compare(uvm_object rhs, uvm_comparer comparer);
        result_transaction to_compare;
        bit isSame;

        // Check if rhs is null or the same type
        if(rhs == null || !$cast(to_compare, rhs))
            isSame = 0;
        else
            // Check if parent data and data are the same
            isSame =  super.do_compare(rhs, comparer) && this.result == to_compare.result;

        return isSame;
    endfunction: do_compare

    // Convert caller's information into string
    function string convert2string();
        string s;
        s = $sformatf("result: %4h", result);
        return s;
    endfunction: convert2string

endclass: result_transaction