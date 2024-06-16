module Multiplier8b_4cycles_tb();

    reg clk, rst_n, start;
    reg [7:0] A, B;
    wire done;
    wire [15:0] result;
    wire [15:0] expected;

    assign expected = A * B;

    // Instantiate iDUT
    Multiplier8b iDUT(.clk(clk), .rst_n(rst_n), .start(start), .A(A), .B(B),
                      .done(done), .result(result));

    initial forever #5 clk = ~clk;

    initial begin
        int count = 0;
        int total = 0;
        clk = 0;
        rst_n = 1;
        start = 0;

        // Global reset
        @(negedge clk);
        rst_n = 0;

        // Recover from reset
        @(negedge clk);
        rst_n = 1;

        // Start testing
        for(int i = 0; i < 256; i++) begin
            for(int j = 0; j < 256; j++) begin
                // Assert start signal
                @(posedge clk);
                start = 1;
                total++;
                A = i;
                B = j;

                // Wait for the done signal
                @(posedge done);
                if(result != expected) begin
                    count++;
                    $display("%d + %d is %d not %d", i, j, expected, result);
                end

                // Deassert start signal
                @(posedge clk);
                start = 0;
            end
        end

        $display("%d incorrect out of %d", count, total);
        $stop();

    end


endmodule