module CLA16b_tb();

    reg [15:0] A, B;
    wire [15:0] expected;
    wire [15:0] sum;
    

    // Instantiate iDUT
    CLA16b iDUT(.A(A), .B(B), .cin(1'b0), .sum(sum));

    assign expected = A + B;

    initial begin
        int count = 0;
        int total = 0;
        #5;
        for(int i = 0; i < 512; i++) begin
            for(int j = 0; j < 512; j++) begin
                total++;
                #3;
                A = i;
                B = j;
                #1;
                if(sum != expected) begin
                    count++;
                    $display("%d + %d is %d not %d", i, j, expected, sum);
                end
            end
        end

        $display("%d incorrect out of %d", count, total);
        $stop();
    end

endmodule