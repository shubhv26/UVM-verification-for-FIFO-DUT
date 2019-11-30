
`uvm_analysis_imp_decl(_mon_item)
`uvm_analysis_imp_decl(_driv_item)

class my_scoreboard extends uvm_scoreboard;
`uvm_component_utils(my_scoreboard)

  my_seq_item exp_Q[$];
  
  uvm_analysis_imp_mon_item#(my_seq_item,my_scoreboard) Mon2Scb_port;
  uvm_analysis_imp_driv_item#(my_seq_item,my_scoreboard) Driv2Scb_port;  

function new(string name,uvm_component parent);
super.new(name,parent);
endfunction

virtual function void build_phase (uvm_phase phase);
super.build_phase (phase);
  Mon2Scb_port=new("Mon2Scb_port",this);
  Driv2Scb_port=new("Driv2Scb_port",this);
endfunction:build_phase

  virtual function void write_mon_item(input my_seq_item seq_item);
  my_seq_item item;
    seq_item.print(); 
    	
    if(exp_Q.size())
      begin
        item=exp_Q.pop_front();
        if(seq_item.compare(item))
          `uvm_info("SCOREBOARD", $psprintf("DRIVER AND MONITOR Data MATCHED"), UVM_LOW)
	    else
          `uvm_info("SCOREBOARD", $psprintf("DRIVER AND MONITOR Data UNMATCHED"),UVM_LOW)
      end
    else
      `uvm_info("SCOREBOARD", $psprintf("NO DATA IN EXP_QUEUE"),UVM_LOW)
endfunction
      

  virtual function void write_driv_item(input my_seq_item seq_item);
    exp_Q.push_back(seq_item);
  endfunction
        
endclass