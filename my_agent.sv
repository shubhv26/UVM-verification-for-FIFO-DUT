`include "my_seq_item.sv"
`include "my_sequencer.sv"
`include "my_sequence.sv"
`include "my_driver.sv"
`include "my_monitor.sv"

class my_agent extends uvm_agent;
`uvm_component_utils(my_agent);

my_driver driv;
my_monitor mon;
my_sequencer sqncr;

function new(string name,uvm_component parent);
super.new(name,parent);
endfunction

function void build_phase(uvm_phase phase);
 super.build_phase(phase);
  
if(get_is_active()==UVM_ACTIVE)begin
	driv=my_driver::type_id::create("driv",this);
	sqncr=my_sequencer::type_id::create("sqncr",this);
end
mon=my_monitor::type_id::create("mon",this);
endfunction: build_phase

function void connect_phase(uvm_phase phase);
if(get_is_active() == UVM_ACTIVE)begin
driv.seq_item_port.connect(sqncr.seq_item_export);
end
endfunction
endclass

////////////////