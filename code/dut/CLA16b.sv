// Module CLA16b: 16-bit Carry Lookahead Adder used in Multiplier
// This module adds two 8-bit numbers and return the 16-bit sum
module CLA16b(
    input wire [15:0] A,
    input wire [15:0] B,
    input wire cin,
    output wire [15:0] sum
);

    // Declare the intermediate group propate and generate signal
    wire [3:0] PG, GG;

    // Declare and calculate the intermediate carryout;
    wire [2:0] C;
    assign C[0] = GG[0] | (PG[0] & cin);
    assign C[1] = GG[1] | (PG[1] & GG[0]) | (PG[1] & PG[0] & cin);
    assign C[2] = GG[2] | (PG[2] & GG[1]) | (PG[2] & PG[1] & GG[0]) | (PG[2] & PG[1] & PG[0] & cin);

    // Instantiate four 4-bit CLAs
    CLA4b iAdd [3:0] (.A(A), .B(B), .cin({C, cin}),
                      .sum(sum), .cout(), .PG(PG), .GG(GG));

endmodule