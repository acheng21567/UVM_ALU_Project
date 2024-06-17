class testbench;

    // Declare virtual interface and three components
    virtual ALU_BFM     bfm;
    tester              iTester;
    coverage            iCoverage;
    scoreboard          iScoreboard;

    function new(virtual ALU_BFM bfm);
        this.bfm = bfm;
    endfunction: new

    task execute();
        // Instantiate three components
        iTester = new(bfm);
        iCoverage = new(bfm);
        iScoreboard = new(bfm);

        // Call the execute function in three components
        fork
            iTester.execute();
            iCoverage.execute();
            iScoreboard.execute();
        join_none
    endtask: execute

endclass: testbench