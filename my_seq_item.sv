class my_seq_item extends uvm_sequence_item;
rand bit wr_rd;
rand bit[7:0]D_in;
bit[7:0]D_out;
bit full;
bit empty;

`uvm_object_utils_begin(my_seq_item)
  `uvm_field_int(wr_rd,UVM_ALL_ON) 
  `uvm_field_int(D_in,UVM_ALL_ON)
`uvm_object_utils_end

function new(string name="my_seq_item");
super.new(name);
endfunction
 
  constraint all_write{wr_rd==1;};

function string convert2string();
  return $psprintf("\nwr_rd= %h \nD_in= %0h", wr_rd,D_in);
endfunction
endclass
