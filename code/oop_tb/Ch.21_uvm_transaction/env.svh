class env extends uvm_env;

    `uvm_component_utils(env)

    tester                 iTester;
    driver                      iDriver;
    // Intermediate FIFO between tester and driver
    uvm_tlm_fifo#(cmd_transaction)    tst_drv_fifo;


    coverage        iCoverage;
    scoreboard      iScoreboard;

    command_monitor iCommand_monitor;
    result_monitor  iResult_monitor;

    function new(string name, uvm_component parent);
        super.new(name, parent);
    endfunction: new

    function void build_phase(uvm_phase phase);
        tst_drv_fifo = new("tst_drv_fifo", this);
        iTester = tester::type_id::create("iTester", this);
        iDriver = driver::type_id::create("iDriver", this);
        iCoverage = coverage::type_id::create("iCoverage", this);
        iScoreboard = scoreboard::type_id::create("iScoreboard", this);
        iCommand_monitor = command_monitor::type_id::create("iCommand_monitor", this);
        iResult_monitor = result_monitor::type_id::create("iResult_monitor", this); 
    endfunction: build_phase

    function void connect_phase(uvm_phase phase);
        // Connect tester and driver with FIFO
        iTester.cmd_put_port.connect(tst_drv_fifo.put_export);
        iDriver.cmd_get_port.connect(tst_drv_fifo.get_export);

        // Connect command monitor to scoreboard
        iCommand_monitor.ap.connect(iScoreboard.cmd_fifo.analysis_export);
        // Connect command monitor to coverage
        iCommand_monitor.ap.connect(iCoverage.analysis_export);
        // Connect result monitor to scoreboard
        iResult_monitor.ap.connect(iScoreboard.analysis_export);
    endfunction: connect_phase

endclass: env