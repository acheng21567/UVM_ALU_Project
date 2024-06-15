module ALU(
    input wire clk,
    input wire rst_n,
    input wire [7:0] A,
    input wire [7:0] B,
    input wire start,
    input wire [2:0] opcode,
    output wire [15:0] result,
    output wire done
);
    // Declare all intermediate signals
    wire [15:0] add_result, mul_result;
    reg single_cycle_done, multi_cycle_done;

    // Assert single_cycle_done signal
    always_ff @(posedge clk) begin
        if(~rst_n)
            single_cycle_done <= 1'b0;
        else
            single_cycle_done <= (start & ~(|opcode));
    end

    // Instantiate the CLA and Multiplier
    CLA8b iAdder(.A(A), .B(B), .cin(1'b0), .sum(add_result));

    Multiplier8b iMul(.clk(clk), .rst_n(rst_n), .start(start), .A(A), .B(B),
                      .done(multi_cycle_done), .result(mul_result));

    // Choose done and result based on the MSB of opcode
    assign result = opcode[1] ? mul_result : 
                    (opcode[1:0] == 2'b01) ? add_result :
                    (opcode[1:0] == 2'b10) ? {8'h00, A & B} :
                    (opcode[1:0] == 2'b11) ? {8'h00, A ^ B} : 16'h0;
    assign done = opcode[1] ? multi_cycle_done : single_cycle_done;

endmodule: ALU