class add_test extends random_test;

    `uvm_component_utils(add_test)

    add_tester iTester;

    function new(string name, uvm_component parent);
        super.new(name, parent);
    endfunction: new

    function void build_phase(uvm_phase phase);
        iTester = new("iTester", this);
        iCoverage = new("iCoverage", this);
        iScoreboard = new("iScoreboard", this);
    endfunction: build_phase

endclass: add_test