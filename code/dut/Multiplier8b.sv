// Module Multiplier8b: 8-bit Multiplier, the result will be available after 4 cycels
module Multiplier8b(
    input wire clk,
    input wire rst_n,
    input wire start,
    input wire [7:0] A,
    input wire [7:0] B,
    input wire [2:0] opcode,
    output reg done,
    output wire [15:0] result
);

    // Declare, pipeline and select A or 0 based on B
    reg [15:0] mul_A0, mul_A1, mul_A2, mul_A3, mul_A4, mul_A5, mul_A6, mul_A7;
    always_ff @(posedge clk) begin
        if(~rst_n) begin
            mul_A0 <= 16'h0;
            mul_A1 <= 16'h0;
            mul_A2 <= 16'h0;
            mul_A3 <= 16'h0;
            mul_A4 <= 16'h0;
            mul_A5 <= 16'h0;
            mul_A6 <= 16'h0;
            mul_A7 <= 16'h0;
        end
        else begin
            mul_A0 <= (B[0]) ? {8'h00, A} : 16'h0;
            mul_A1 <= (B[1]) ? {7'h00, A, 1'h0} : 16'h0;
            mul_A2 <= (B[2]) ? {6'h00, A, 2'h0} : 16'h0;
            mul_A3 <= (B[3]) ? {5'h00, A, 3'h0} : 16'h0;
            mul_A4 <= (B[4]) ? {4'h0, A, 4'h0} : 16'h0;
            mul_A5 <= (B[5]) ? {3'h0, A, 5'h00} : 16'h0;
            mul_A6 <= (B[6]) ? {2'h0, A, 6'h00} : 16'h0;
            mul_A7 <= (B[7]) ? {1'h0, A, 7'h00} : 16'h0;
        end
    end

    // Declare and calculate first level intermediate sum
    wire [15:0] sum_bit01, sum_bit23, sum_bit45, sum_bit67;
    CLA16b iAdd_bit01(.A(mul_A0), .B(mul_A1), .cin(1'b0), .sum(sum_bit01));
    CLA16b iAdd_bit23(.A(mul_A2), .B(mul_A3), .cin(1'b0), .sum(sum_bit23));
    CLA16b iAdd_bit45(.A(mul_A4), .B(mul_A5), .cin(1'b0), .sum(sum_bit45));
    CLA16b iAdd_bit67(.A(mul_A6), .B(mul_A7), .cin(1'b0), .sum(sum_bit67));

    // Pipelined the sum above
    reg [15:0] sum_reg_bit01, sum_reg_bit23, sum_reg_bit45, sum_reg_bit67;
    always_ff @(posedge clk) begin
        if(~rst_n) begin
            sum_reg_bit01 <= 16'h0;
            sum_reg_bit23 <= 16'h0;
            sum_reg_bit45 <= 16'h0;
            sum_reg_bit67 <= 16'h0;
        end
        else begin
            sum_reg_bit01 <= sum_bit01;
            sum_reg_bit23 <= sum_bit23;
            sum_reg_bit45 <= sum_bit45;
            sum_reg_bit67 <= sum_bit67;
        end
    end

    // Declare and calculate second level intermediate sum
    wire [15:0] sum_bit0123, sum_bit4567;
    CLA16b iAdd_bit0123(.A(sum_reg_bit01), .B(sum_reg_bit23), .cin(1'b0), .sum(sum_bit0123));
    CLA16b iAdd_bit4567(.A(sum_reg_bit45), .B(sum_reg_bit67), .cin(1'b0), .sum(sum_bit4567));

    // Pipelined the sum above
    reg [15:0] sum_reg_bit0123, sum_reg_bit4567;
    always_ff @(posedge clk) begin
        if(~rst_n) begin
            sum_reg_bit0123 <= 16'h0;
            sum_reg_bit4567 <= 16'h0;
        end
        else begin
            sum_reg_bit0123 <= sum_bit0123;
            sum_reg_bit4567 <= sum_bit4567;
        end
    end


    // Calculate the final result
    CLA16b iAdd_result(.A(sum_reg_bit0123), .B(sum_reg_bit4567), .cin(1'b0), .sum(result));
    

    // Asserted done when finish multiplying (4 cycles)
    reg done3, done2, done1;
    always_ff @(posedge clk) begin
        if(~rst_n) begin
            done3 <= 1'b0;
            done2 <= 1'b0;
            done1 <= 1'b0;
            done <= 1'b0;
        end
        else begin
            done3 <= start & ~done & (opcode == 3'b100);
            done2 <= done3 & ~done;
            done1 <= done2 & ~done;
            done <= done1 & ~done;
        end
    end

endmodule