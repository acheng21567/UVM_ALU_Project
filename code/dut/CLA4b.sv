// Module CLA4b: 4-bit Carry Lookahead Adder
// This module adds two 4-bit numbers A and B, and accounts for an input carry (cin).
module CLA4b(
    input wire [3:0] A,          // 4-bit input operand A
    input wire [3:0] B,          // 4-bit input operand B
    input wire cin,              // Input carry bit
    output wire [3:0] sum,       // 4-bit output sum of A and B
    output wire cout,            // Output carry indicating overflow out of MSB
    output wire PG,              // Group Propagate Output
    output wire GG               // Group Generate Output
);

    // Declare and calculate intermediate generate and propagate signals
    wire [3:0] g, p;
    assign g = A & B;
    assign p = A | B;

    // Declare and calculate intermediate carries between each bit position
    wire [2:0] c;
    assign c[0] = g[0] | (p[0] & cin);
    assign c[1] = g[1] | (p[1] & g[0]) | (p[1] & p[0] & cin);
    assign c[2] = g[2] | (p[2] & g[1]) | (p[2] & p[1] & g[0]) | (p[2] & p[1] & p[0] & cin);

    // Calculate the carry out of the MSB
    assign cout = g[3] | (p[3] & g[2]) | (p[3] & p[2] & g[1]) | (p[3] & p[2] & p[1] & g[0]) | (p[3] & p[2] & p[1] & p[0] & cin);

    // Calculate the sum of A and B
    assign sum = A ^ B ^ {c, cin}; // Sum calculation

    // Group propagate output (PG): High if all bits will propagate a carry
    assign PG = &p;

    // Group generate output (GG): High if any bit will generate a carry
    assign GG = g[3] | (p[3] & g[2]) | (p[3] & p[2] & g[1]) | (p[3] & p[2] & p[1] & g[0]);

endmodule
