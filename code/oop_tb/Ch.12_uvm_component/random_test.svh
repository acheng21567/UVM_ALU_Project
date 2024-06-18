class random_test extends uvm_test;

    `uvm_component_utils(random_test)

    random_tester   iTester;
    coverage        iCoverage;
    scoreboard      iScoreboard;

    function new(string name, uvm_component parent);
        super.new(name, parent);
    endfunction: new

    function void build_phase(uvm_phase phase);
        iTester = new("iTester", this);
        iCoverage = new("iCoverage", this);
        iScoreboard = new("iScoreboard", this);
    endfunction: build_phase

endclass: random_test