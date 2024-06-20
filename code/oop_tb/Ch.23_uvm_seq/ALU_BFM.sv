interface ALU_BFM();

    // Import opcode definition
    import ALU_pkg::*;

    // Declare monitor handles
    command_monitor iCommand_monitor;
    result_monitor  iResult_monitor;

    // Declare signals for ALU
    byte unsigned A;
    byte unsigned B;
    bit          clk;
    bit          rst_n;
    wire [2:0]   op;
    bit          start;
    wire         done;
    wire [15:0]  result;
    operation_t  op_set;

    assign op = op_set;

    // Initialize and toggle clock siganl every 5ns
    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    // Define task for reseting the ALU
    task reset_alu();
        rst_n = 1'b0;
        @(negedge clk);
        @(negedge clk);
        rst_n = 1'b1;
        start = 1'b0;
    endtask: reset_alu

    // Define task to send opcode
    task send_op(input byte iA, input byte iB, input operation_t iop, output shortint alu_result);
        if(iop == rst_op) begin
            @(posedge clk);
            rst_n = 1'b0;
            start = 1'b0;
            @(posedge clk);
            #1;
            rst_n = 1'b1;
        end
        else begin
            @(negedge clk);
            op_set = iop;
            A = iA;
            B = iB;
            start = 1'b1;
            if(iop == no_op) begin
                @(posedge clk);
                #1;
                start = 1'b0;
            end
            else begin
                do
                    @(negedge clk);
                while(done == 0);
                start = 1'b0;
            end
            alu_result = result;
        end
    endtask: send_op

    // Write to command monitor when start is high and there is new command
    always @(posedge clk) begin
        bit new_command;
        if(!start)
            new_command = 1;
        else if(new_command) begin
            iCommand_monitor.write_to_monitor(A, B, op_set);
            new_command = (op == 3'b000);
        end
    end

    always @(negedge rst_n) begin
        if(iCommand_monitor != null)
            iCommand_monitor.write_to_monitor(A, B, rst_op);
    end

    always @(posedge clk) begin
        if(done)
            iResult_monitor.write_to_monitor(result);
    end

endinterface: ALU_BFM