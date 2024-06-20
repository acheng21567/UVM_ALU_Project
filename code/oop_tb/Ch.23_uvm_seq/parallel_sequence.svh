class parallel_sequence extends uvm_sequence#(uvm_sequence_item);

    `uvm_object_utils(parallel_sequence)

    protected reset_sequence        rst_seq;
    protected fibonacci_sequence    fib_seq;
    protected random_sequence       rand_seq;

    function new(string name="parallel_sequence");
        super.new(name);

        rst_seq = reset_sequence::type_id::create("rst_seq");
        fib_seq = fibonacci_sequence::type_id::create("fib_seq");
        rand_seq = random_sequence::type_id::create("rand_seq");
    endfunction: new

    // Launch three sequence serially
    task body();
        rst_seq.start(m_sequencer);
        fork
            fib_seq.start(m_sequencer);
            rand_seq.start(m_sequencer);            
        join
    endtask: body

endclass: parallel_sequence