virtual class base_test extends uvm_test;

    env         iEnv;
    sequencer   iSequencer;

    function new(string name, uvm_component parent);
        super.new(name, parent);
    endfunction: new

    function void build_phase(uvm_phase phase);
        iEnv = env::type_id::create("iEnv", this);
    endfunction: build_phase

    function void end_of_elaboration_phase(uvm_phase phase);
        iSequencer = iEnv.iSequencer;
    endfunction: end_of_elaboration_phase

endclass: base_test