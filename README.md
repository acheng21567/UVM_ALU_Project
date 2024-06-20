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

#### Chapter 12 TB

Chapter 12 testbenches change `tester`, `scoreboard` and `coverage` to `uvm_component` and they are instantiated during the `build_phase` of `test`.

#### Chapter 13 TB

Chapter 13 testbenches add an `env` that extends `uvm_env` and contains other components. Also, `test` overrides `base_tester` in its build_phase().

#### Chapter 16 TB

Chapter 16 testbenches modify `scoreboard` and `coverage` to `uvm_subscriber` and add `result_monitor` and `command_monitor`. Since `scoreboard` is connected to two monitors, there is an `uvm_tlm_analysis_fifo` for command.

#### Chapter 18 TB

Chapter 18 testbenches add a new `driver` component and utilize `uvm_put_port` in tester, `uvm_get_port` in driver and `uvm_tlm_fifo` in env to send command from tester to driver.

#### Chapter 21 TB

Chapter 21 testbenches change `command_s` struct to `cmd_transaction`. Now, ports send `transactions` instead of `command_s` or `shortint`.

#### Chapter 23 TB

Chapter 23 testbenches add multiple `sequences` and send them parallelly and sequentially.