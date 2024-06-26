class random_tester extends base_tester;

    `uvm_component_utils(random_tester)

    function new(string name, uvm_component parent);
        super.new(name, parent);
    endfunction: new

    // Return an operation randomly
    virtual function operation_t get_op();
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
    virtual function byte get_data();
        bit [1:0] zero_ones;
        zero_ones = $random;
        if (zero_ones == 2'b00)
            return 8'h00;
        else if (zero_ones == 2'b11)
            return 8'hFF;
        else
            return $random;
    endfunction : get_data

endclass: random_tester