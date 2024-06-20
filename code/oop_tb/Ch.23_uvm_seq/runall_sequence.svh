class runall_sequence extends uvm_sequence#(uvm_sequence_item);

    `uvm_object_utils(runall_sequence)

    protected reset_sequence        rst_seq;
    protected maxmult_sequence      maxmult_seq;
    protected random_sequence       rand_seq;
    protected sequencer             iSequencer;
    protected uvm_component         iComponent;

    function new(string name="runall_sequence");
        super.new(name);

        // Get sequencer in env
        iComponent = uvm_top.find("*.iEnv.iSequencer");

        if(iComponent == null)
            `uvm_fatal("RUNALL SEQUENCE", "Failed to get the sequencer")

        if(!$cast(iSequencer, iComponent))
            `uvm_fatal("RUNALL SEQUENCE", "Failed to cast to sequencer")

        rst_seq = reset_sequence::type_id::create("rst_seq");
        maxmult_seq = maxmult_sequence::type_id::create("maxmult_seq");
        rand_seq = random_sequence::type_id::create("rand_seq");
    endfunction: new

    // Launch three sequence serially
    task body();
        rst_seq.start(iSequencer);
        maxmult_seq.start(iSequencer);
        rand_seq.start(iSequencer);
    endtask: body

endclass: runall_sequence