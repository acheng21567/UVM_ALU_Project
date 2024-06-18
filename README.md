# This is an easy UVM project testing an ALU.
Part of codes are from https://github.com/raysalemi/uvmprimer/tree/master.

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

## Testbenches

### Non Object-Oriented-Programming Testbenches

Traditional testbenches, which do not utilize object-oriented programming, are located under `/code/non_oop_tb`. These testbenches are crafted using conventional module-based methods to conduct fundamental testing.

### Object-Oriented-Programming Testbenches


Testbenches that utilize object-oriented programming are stored under `/code/oop_tb`. Most of these testbenches incorporate UVM.

#### Chapter 10 TB
Chapter 10 testbenches do not employ UVM frameworks; instead, they are constructed using classes rather than traditional modules. This allows for a structured and organized method to perform testing while leveraging the capabilities of SystemVerilog classes.

#### Chapter 11 TB
Chapter 11 testbenches integrate UVM by having components such as `add_test` and `random_test` extend `uvm_test`, while other components are implemented without UVM features.
