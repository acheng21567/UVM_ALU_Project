# This is an easy UVM project testing an ALU.

## ALU
The ALU takes two 8-bit inputs and output a 16-bit result. The ALU currently supports 5 operations and they are listed below.
| Operation | Opcode           |
|-----------|------------------|
| no_op     | `3'b000`         |
| add_op    | `3'b001`         |
| and_op    | `3'b010`         |
| xor_op    | `3'b011`         |
| mul_op    | `3'b100`         |
| unused    | `3'b101`-`3'b111`|
