class maxmult_sequence extends uvm_sequence #(sequence_item);
    `uvm_object_utils(maxmult_sequence);

    sequence_item cmd;

    function new(string name = "maxmult_sequence");
        super.new(name);
    endfunction: new


    task body();
        cmd = sequence_item::type_id::create("cmd");
        start_item(cmd);
        cmd.op = mul_op;
        cmd.A = 8'hFF;
        cmd.B = 8'hFF;
        finish_item(cmd);
    endtask: body

endclass: maxmult_sequence