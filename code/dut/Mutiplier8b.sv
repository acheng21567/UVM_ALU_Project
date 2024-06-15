module Multiplier8b(
    input wire clk,
    input wire rst_n,
    input wire start,
    input wire [7:0] A,
    input wire [7:0] B,
    output reg done,
    output wire [15:0] result
);

    // Declare and select A or 0 based on B
    wire [15:0] mul_A [8];
    genvar i;
    generate
        for(i = 0; i < 8; i++) begin
            assign mul_A[i] = B[i] ? {{(8-i){1'b0}}, A, {i{1'b0}}} : 16'h0;
        end
    endgenerate

    // Declare and calculate intermediate sum
    wire [15:0] sum_bit01, sum_bit23, sum_bit45, sum_bit67;
    CLA16b iAdd_bit01(.A(mul_A[0]), .B(mul_A[1]), .cin(1'b0), .sum(sum_bit01));
    CLA16b iAdd_bit23(.A(mul_A[2]), .B(mul_A[3]), .cin(1'b0), .sum(sum_bit23));
    CLA16b iAdd_bit45(.A(mul_A[4]), .B(mul_A[5]), .cin(1'b0), .sum(sum_bit45));
    CLA16b iAdd_bit67(.A(mul_A[6]), .B(mul_A[7]), .cin(1'b0), .sum(sum_bit67));

    wire [15:0] sum_bit0123, sum_bit4567;
    CLA16b iAdd_bit0123(.A(sum_bit01), .B(sum_bit23), .cin(1'b0), .sum(sum_bit0123));
    CLA16b iAdd_bit4567(.A(sum_bit45), .B(sum_bit67), .cin(1'b0), .sum(sum_bit4567));

    // Calculate the final result
    CLA16b iAdd_result(.A(sum_bit0123), .B(sum_bit4567), .cin(1'b0), .sum(result));
    
    always_ff @(posedge clk, negedge rst_n) begin
        if(~rst_n)
            done <= 1'b0;
        else if(start)
            done <= 1'b1;
        else
            done <= 1'b0;
    end

endmodule