class fibonacci_sequence extends uvm_sequence;

    `uvm_object_utils(fibonacci_sequence)

    function new(string name="fibonacci");
        super.new(name);
    endfunction: new

    task body();
        byte unsigned n2 = 0;
        byte unsigned n1 = 1;
        sequence_item cmd;

        cmd = sequence_item::type_id::create("cmd");

        // Reset ALU
        start_item(cmd);
        cmd.op = rst_op;
        finish_item(cmd);

        `uvm_info("Fibonacci Sequence", "Fib(01) = 00", UVM_MEDIUM)
        `uvm_info("Fibonacci Sequence", "Fib(02) = 01", UVM_MEDIUM)

        for(int ff = 3; ff < 15; ff++) begin
            start_item(cmd);
            cmd.A = n2;
            cmd.B = n1;
            cmd.op = add_op;
            finish_item(cmd);
            n2 = n1;
            n1 = cmd.result;
            `uvm_info("Fibonacci Sequence", $sformatf("Fib(%02d) = %02d", ff, n1), UVM_MEDIUM)
        end
    endtask: body

endclass: fibonacci_sequence