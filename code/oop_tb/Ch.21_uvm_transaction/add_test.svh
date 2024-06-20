class add_test extends uvm_test;

    `uvm_component_utils(add_test)

    env     iEnv;

    function new(string name, uvm_component parent);
        super.new(name, parent);
    endfunction: new

    function void build_phase(uvm_phase phase);
        // Override cmd_transaction with add_transaction
        cmd_transaction::type_id::set_type_override(add_transaction::get_type());
        iEnv = env::type_id::create("iEnv", this);
    endfunction: build_phase

endclass: add_test