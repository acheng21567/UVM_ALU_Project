class random_test extends uvm_test;

    `uvm_component_utils(random_test);

    virtual ALU_BFM bfm;

    function new(string name, uvm_component parent);
        super.new(name, parent);
        if(!uvm_config_db#(virtual ALU_BFM)::get(null, "*", "bfm", bfm))
            $fatal("Failed to get ALU_BFM");
    endfunction: new

    task run_phase(uvm_phase phase);
        random_tester   iRandom_tester;
        coverage        iCoverage;
        scoreboard      iScoreboard;

        phase.raise_objection(this);

        iRandom_tester = new(bfm);
        iCoverage = new(bfm);
        iScoreboard = new(bfm);

        fork
            iCoverage.execute();
            iScoreboard.execute();
        join_none

        iRandom_tester.execute();
        phase.drop_objection(this);
    endtask: run_phase

endclass: random_test