class reset_sequence extends uvm_sequence#(sequence_item);

    `uvm_object_utils(reset_sequence)

    sequence_item cmd;

    function new(string name="reset_sequence");
        super.new(name);
    endfunction

    task body();
        cmd = sequence_item::type_id::create("cmd");
        start_item(cmd);
        cmd.op = rst_op;
        finish_item(cmd);
    endtask: body

endclass: reset_sequence