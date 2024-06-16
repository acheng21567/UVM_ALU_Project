module Multiplier8b_tb();

    reg [7:0] A, B;
    wire done;
    wire [15:0] result;
    wire [15:0] expected;

    assign expected = A * B;

    // Instantiate iDUT
    Multiplier8b iDUT(.clk(1'b0), .rst_n(1'b1), .start(1'b0), .A(A), .B(B),
                      .done(done), .result(result));

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
                if(result != expected) begin
                    count++;
                    $display("%d + %d is %d not %d", i, j, expected, result);
                end
            end
        end

        $display("%d incorrect out of %d", count, total);
        $stop();
    end

endmodule