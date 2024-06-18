class env extends uvm_env;

    `uvm_component_utils(env)

    base_tester     iTester;
    coverage        iCoverage;
    scoreboard      iScoreboard;

    function new(string name, uvm_component parent);
        super.new(name, parent);
    endfunction: new

    function void build_phase(uvm_phase phase);
        iTester = base_tester::type_id::create("iTester", this);
        iCoverage = coverage::type_id::create("iCoverage", this);
        iScoreboard = scoreboard::type_id::create("iScoreboard", this);
    endfunction: build_phase

endclass: env