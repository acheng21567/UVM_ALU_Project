class fibonacci_test extends base_test;

    `uvm_component_utils(fibonacci_test)

    function new(string name, uvm_component parent);
        super.new(name, parent);
    endfunction: new

    task run_phase(uvm_phase phase);
        fibonacci_sequence fibonacci;
        fibonacci = new("fibonacci");

        phase.raise_objection(this);
        fibonacci.start(iSequencer);
        phase.drop_objection(this);
    endtask: run_phase

endclass: fibonacci_test