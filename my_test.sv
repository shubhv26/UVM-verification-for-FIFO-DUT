`include "environment.sv"

class my_test extends uvm_test;
`uvm_component_utils(my_test)

my_env env;
my_sequence seq;

function new(string name="my_test", uvm_component parent=null);
super.new(name,parent);
endfunction:new

	///// //////////BUILD PHASE/////////////////////////////////
virtual function void build_phase(uvm_phase phase);
super.build_phase(phase);

env=my_env::type_id::create("env",this);
seq=my_sequence::type_id::create("seq");
endfunction:build_phase

/////////////////RUN PHASE//////////////////////////////////////
task run_phase(uvm_phase phase);
phase.raise_objection(this);
seq.start(env.agnt.sqncr);
phase.drop_objection(this);
endtask : run_phase

  ////////////////////////////////////////////////////
virtual function void end_of_elaboration_phase (uvm_phase phase);
uvm_top.print_topology ();
endfunction
endclass