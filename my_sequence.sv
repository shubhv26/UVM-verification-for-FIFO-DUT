class my_sequence extends uvm_sequence#(my_seq_item);
`uvm_object_utils(my_sequence)

function new(string name="my_sequence");
super.new(name);
endfunction

 virtual task body(); 
`uvm_info(get_type_name(),$sformatf("Starting the sequence"),UVM_LOW)
   repeat(10)  begin
    req=my_seq_item::type_id::create("req");
      start_item(req);
      assert(req.randomize());
    finish_item(req);
    end
   #30;
`uvm_info(get_type_name(),$sformatf("Sequence  Completed"),UVM_LOW)
   
endtask
endclass