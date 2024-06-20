class random_sequence extends uvm_sequence #(sequence_item);
   `uvm_object_utils(random_sequence);
   
   sequence_item cmd;

   function new(string name = "random_sequence");
      super.new(name);
   endfunction : new
   


   task body();
      repeat (5000) begin : random_loop
         cmd = sequence_item::type_id::create("cmd");
         start_item(cmd);
         assert(cmd.randomize());
         finish_item(cmd);
      end : random_loop
   endtask : body
endclass : random_sequence