class env extends uvm_env;

    `uvm_component_utils(env)

    sequencer       iSequencer;
    driver          iDriver;

    coverage        iCoverage;
    scoreboard      iScoreboard;

    command_monitor iCommand_monitor;
    result_monitor  iResult_monitor;

    function new(string name, uvm_component parent);
        super.new(name, parent);
    endfunction: new

    function void build_phase(uvm_phase phase);
        iSequencer = sequencer::type_id::create("iSequencer", this);
        iDriver = driver::type_id::create("iDriver", this);
        iCoverage = coverage::type_id::create("iCoverage", this);
        iScoreboard = scoreboard::type_id::create("iScoreboard", this);
        iCommand_monitor = command_monitor::type_id::create("iCommand_monitor", this);
        iResult_monitor = result_monitor::type_id::create("iResult_monitor", this); 
    endfunction: build_phase

    function void connect_phase(uvm_phase phase);
        // Connect driver's port with sequencer's port
        iDriver.seq_item_port.connect(iSequencer.seq_item_export);

        // Connect command monitor to scoreboard
        iCommand_monitor.ap.connect(iScoreboard.cmd_fifo.analysis_export);
        // Connect command monitor to coverage
        iCommand_monitor.ap.connect(iCoverage.analysis_export);
        // Connect result monitor to scoreboard
        iResult_monitor.ap.connect(iScoreboard.analysis_export);
    endfunction: connect_phase

endclass: env