// Module CLA8b: 8-bit Carry Lookahead Adder
// This module adds two 8-bit numbers and return the 16-bit sum
module CLA8b(
    input wire [7:0] A,
    input wire [7:0] B,
    input wire cin,
    output wire [15:0] sum
);

    // Declare the intermediate group propate and generate signal
    wire [1:0] PG, GG;

    // Declare and calculate the intermediate carryout;
    wire C4;
    assign C4 = GG[0] | (PG[0] & cin);

    // Declare a 8-bit wire to save sum result
    wire [7:0] add_result;

    // Instantiate the 4b CLA
    CLA4b iAdd [1:0] (.A(A), .B(B), .cin({C4, cin}),
                      .sum(add_result), .cout(), .PG(PG), .GG(GG));

    // Declare and calculate the carry out of 8 bit result
    wire C8;
    assign C8 = GG[1] | (PG[1] & GG[0]) | (PG[1] & PG[0] & cin);

    // Declare and calculate the 9th bit of sum
    wire sum_9;
    assign sum_9 = C8 ^ A[7] ^ B[7];

    // Signed extended to get 16-bit result
    assign sum = {{8{sum_9}}, add_result};

endmodule