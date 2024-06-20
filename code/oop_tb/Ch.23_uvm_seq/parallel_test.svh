class parallel_test extends base_test;
   `uvm_component_utils(parallel_test);

   parallel_sequence parallel_seq;
      
   function new(string name, uvm_component parent);
      super.new(name,parent);
      parallel_seq = new("parallel_seq");
   endfunction: new

   task run_phase(uvm_phase phase);
      phase.raise_objection(this);
      parallel_seq.start(iSequencer);
      phase.drop_objection(this);
   endtask: run_phase

endclass