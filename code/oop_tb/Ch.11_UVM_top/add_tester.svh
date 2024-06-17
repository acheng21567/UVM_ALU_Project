class add_tester extends random_tester;

    function new(virtual ALU_BFM bfm);
        super.new(bfm);
    endfunction: new

    function operation_t get_op();
        return add_op;
    endfunction: get_op

endclass: add_tester