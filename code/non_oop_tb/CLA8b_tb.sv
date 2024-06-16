module CLA8b_tb();

    reg [7:0] A, B;
    wire [15:0] sum;

    // Instantiate iDUT
    CLA8b iDUT(.A(A), .B(B), .cin(1'b0), .sum(sum));

    initial begin
        int count = 0;
        int total = 0;
        #5;
        for(int i = 0; i < 256; i++) begin
            for(int j = 0; j < 256; j++) begin
                total++;
                #3;
                A = i;
                B = j;
                #1;
                if(sum != i+j) begin
                    count++;
                    $display("%d + %d is %d not %d", i, j, i+j, sum);
                end
            end
        end

        $display("%d incorrect out of %d", count, total);
        $stop();
    end

endmodule