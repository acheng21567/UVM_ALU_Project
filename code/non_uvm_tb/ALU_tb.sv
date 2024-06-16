module ALU_tb();

    typedef enum bit[2:0] { no_op  = 3'b000,
                            add_op = 3'b001, 
                            and_op = 3'b010,
                            xor_op = 3'b011,
                            mul_op = 3'b100,
                            rst_op = 3'b111} operation_t;

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

    // Instantiate the ALU
    ALU iDUT (.clk(clk), .rst_n(rst_n), .A(A), .B(B), .start(start), .opcode(op),
            .result(result), .done(done));



    covergroup op_cov;
        coverpoint op_set {
            bins single_cycle[] = {[add_op : xor_op], rst_op,no_op};
            bins multi_cycle = {mul_op};

            bins opn_rst[] = ([add_op:mul_op] => rst_op);
            bins rst_opn[] = (rst_op => [add_op:mul_op]);

            bins sngl_mul[] = ([add_op:xor_op],no_op => mul_op);
            bins mul_sngl[] = (mul_op => [add_op:xor_op], no_op);

            bins two_ops[] = ([add_op:mul_op] [* 2]);
            bins many_mult = (mul_op [* 3:5]);
        }

    endgroup

    covergroup zeros_or_ones_on_ops;

        all_ops : coverpoint op_set {
            ignore_bins null_ops = {rst_op, no_op};}

        a_leg: coverpoint A {
            bins zeros = {'h00};
            bins others= {['h01:'hFE]};
            bins ones  = {'hFF};
        }

        b_leg: coverpoint B {
            bins zeros = {'h00};
            bins others= {['h01:'hFE]};
            bins ones  = {'hFF};
        }

        op_00_FF:  cross a_leg, b_leg, all_ops {
            bins add_00 = binsof (all_ops) intersect {add_op} &&
                (binsof (a_leg.zeros) || binsof (b_leg.zeros));

            bins add_FF = binsof (all_ops) intersect {add_op} &&
                (binsof (a_leg.ones) || binsof (b_leg.ones));

            bins and_00 = binsof (all_ops) intersect {and_op} &&
                (binsof (a_leg.zeros) || binsof (b_leg.zeros));

            bins and_FF = binsof (all_ops) intersect {and_op} &&
                (binsof (a_leg.ones) || binsof (b_leg.ones));

            bins xor_00 = binsof (all_ops) intersect {xor_op} &&
                (binsof (a_leg.zeros) || binsof (b_leg.zeros));

            bins xor_FF = binsof (all_ops) intersect {xor_op} &&
                (binsof (a_leg.ones) || binsof (b_leg.ones));

            bins mul_00 = binsof (all_ops) intersect {mul_op} &&
                (binsof (a_leg.zeros) || binsof (b_leg.zeros));

            bins mul_FF = binsof (all_ops) intersect {mul_op} &&
                (binsof (a_leg.ones) || binsof (b_leg.ones));

            bins mul_max = binsof (all_ops) intersect {mul_op} &&
                (binsof (a_leg.ones) && binsof (b_leg.ones));

            ignore_bins others_only = binsof(a_leg.others) && binsof(b_leg.others);
        }

    endgroup

    // Initialize and toggle clock siganl every 5ns
    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    op_cov oc;
    zeros_or_ones_on_ops c_00_FF;

    initial begin : coverage

        oc = new();
        c_00_FF = new();

        // Sample the coveragegroup at negedge of clk
        forever begin @(negedge clk);
            oc.sample();
            c_00_FF.sample();
        end
    end : coverage


    // Return an operation randomly
    function operation_t get_op();
        bit [2:0] op_choice;
        op_choice = $random;
        case (op_choice)
            3'b000 : return no_op;
            3'b001 : return add_op;
            3'b010 : return and_op;
            3'b011 : return xor_op;
            3'b100 : return mul_op;
            3'b101 : return no_op;
            3'b110 : return rst_op;
            3'b111 : return rst_op;
        endcase // case (op_choice)
    endfunction : get_op

    // Return a 8 bit number with 50% chances, 0 for 25% and 255 for 25%
    function byte get_data();
        bit [1:0] zero_ones;
        zero_ones = $random;
        if (zero_ones == 2'b00)
            return 8'h00;
        else if (zero_ones == 2'b11)
            return 8'hFF;
        else
            return $random;
    endfunction : get_data

    // Record any wrong calculation
    always @(posedge done) begin : scoreboard
        shortint predicted_result;
        #1;
        case (op_set)
            add_op: predicted_result = A + B;
            and_op: predicted_result = A & B;
            xor_op: predicted_result = A ^ B;
            mul_op: predicted_result = A * B;
        endcase // case (op_set)

        if ((op_set != no_op) && (op_set != rst_op))
            if (predicted_result != result)
                $error ("FAILED: A: %0h  B: %0h  op: %s result: %0h expect: %0h", A, B, op_set.name(), result, predicted_result);
    end : scoreboard




    initial begin : tester
        rst_n = 1'b0;
        @(negedge clk);
        @(negedge clk);
        rst_n = 1'b1;
        start = 1'b0;
        repeat (1000) begin
            @(negedge clk);
            op_set = get_op();
            A = get_data();
            B = get_data();
            start = 1'b1;
            case (op_set) // handle the start signal
                no_op: begin 
                    @(posedge clk);
                    start = 1'b0;
                end
                rst_op: begin 
                    rst_n = 1'b0;
                    start = 1'b0;
                    @(negedge clk);
                    rst_n = 1'b1;
                end
                    default: begin 
                    wait(done);
                    start = 1'b0;
                end
            endcase // case (op_set)
        end
        $stop();
    end : tester
endmodule : ALU_tb