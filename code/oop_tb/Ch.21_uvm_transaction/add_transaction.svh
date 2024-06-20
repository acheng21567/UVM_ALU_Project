class add_transaction extends cmd_transaction;

    `uvm_object_utils(add_transaction)

    function new(string name = "add_transaction");
        super.new(name);
    endfunction: new

    // New constraint doing only add operation
    constraint add_only {op == add_op;}

endclass: add_transaction