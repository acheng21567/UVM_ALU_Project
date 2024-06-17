interface ALU_BFM();

    // Import opcode definition
    import ALU_pkg::*;

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
        op_set = iop;

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

endinterface: ALU_BFM