class random_test extends uvm_test;

    `uvm_component_utils(random_test)

    env     iEnv;

    function new(string name, uvm_component parent);
        super.new(name, parent);
    endfunction: new

    function void build_phase(uvm_phase phase);
        iEnv = env::type_id::create("iEnv", this);
    endfunction: build_phase

endclass: random_test