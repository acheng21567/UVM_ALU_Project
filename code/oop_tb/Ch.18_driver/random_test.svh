class random_test extends uvm_test;

    `uvm_component_utils(random_test)

    env     iEnv;

    function new(string name, uvm_component parent);
        super.new(name, parent);
    endfunction: new

    function void build_phase(uvm_phase phase);
        // Override base_tester with random_tester
        base_tester::type_id::set_type_override(random_tester::get_type());
        iEnv = env::type_id::create("iEnv", this);
    endfunction: build_phase

endclass: random_test