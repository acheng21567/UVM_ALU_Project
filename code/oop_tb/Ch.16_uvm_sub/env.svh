class env extends uvm_env;

    `uvm_component_utils(env)

    base_tester     iTester;
    coverage        iCoverage;
    scoreboard      iScoreboard;

    command_monitor iCommand_monitor;
    result_monitor  iResult_monitor;

    function new(string name, uvm_component parent);
        super.new(name, parent);
    endfunction: new

    function void build_phase(uvm_phase phase);
        iTester = base_tester::type_id::create("iTester", this);
        iCoverage = coverage::type_id::create("iCoverage", this);
        iScoreboard = scoreboard::type_id::create("iScoreboard", this);
        iCommand_monitor = command_monitor::type_id::create("iCommand_monitor", this);
        iResult_monitor = result_monitor::type_id::create("iResult_monitor", this);
    endfunction: build_phase

    function void connect_phase(uvm_phase phase);
        // Connect command monitor to scoreboard
        iCommand_monitor.ap.connect(iScoreboard.cmd_fifo.analysis_export);

        // Connect command monitor to coverage
        iCommand_monitor.ap.connect(iCoverage.analysis_export);

        // Connect result monitor to scoreboard
        iResult_monitor.ap.connect(iScoreboard.analysis_export);
    endfunction

endclass: env