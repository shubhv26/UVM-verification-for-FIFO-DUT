`include "my_agent.sv"
`include "my_scoreboard.sv"

class my_env extends uvm_env;
`uvm_component_utils(my_env)

my_agent agnt;
my_scoreboard scb; 
  
function new(string name, uvm_component parent);
super.new(name,parent);
endfunction: new

function void build_phase(uvm_phase phase);
super.build_phase(phase);

  agnt=my_agent::type_id::create("agnt",this);
  scb=my_scoreboard::type_id::create("scb",this);
endfunction: build_phase

function void connect_phase(uvm_phase phase);
  super.connect();
  agnt.driv.Driv2Scb_port.connect(scb.Driv2Scb_port);
  agnt.mon.Mon2Scb_port.connect(scb.Mon2Scb_port);     
endfunction

endclass