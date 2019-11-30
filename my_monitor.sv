class my_monitor extends uvm_monitor;
`uvm_component_utils(my_monitor)

  uvm_analysis_port#(my_seq_item) Mon2Scb_port;
virtual DUT_intf vif;
my_seq_item seq_item;

function new(string name, uvm_component parent);
super.new(name,parent);   
Mon2Scb_port=new("item_collected_port",this);
endfunction

function void build_phase (uvm_phase phase);
super.build_phase(phase);
  if(!uvm_config_db#(virtual DUT_intf)::get(this,"","vif",vif))
    `uvm_fatal("NO_VIF",{"Virtual interface must be set for: ",get_full_name(),".vif"});
endfunction

virtual task run_phase(uvm_phase phase);
  super.run_phase(phase);
  seq_item=my_seq_item::type_id::create("seq_item",this);
forever begin
  @(vif.monitor_cb);
  if(vif.monitor_cb.wr_rd)begin
    `uvm_info("MONITOR", $sformatf("Monitor received data for WRITE operation"), UVM_LOW)
        seq_item.wr_rd=vif.monitor_cb.wr_rd;
		seq_item.full=vif.monitor_cb.full;
		seq_item.D_in=vif.monitor_cb.D_in;
    `uvm_info("MONITOR", $psprintf("Monitoring data: \nwr_rd= %0h \nfull= %0h  \nD_in= %0h",seq_item.wr_rd,seq_item.full,seq_item.D_in),UVM_LOW);
	end
  
  else begin
   `uvm_info("MONITOR", $sformatf("Monitor received data for READ operation"), UVM_LOW)
		seq_item.wr_rd=vif.monitor_cb.wr_rd;
        seq_item.empty=vif.monitor_cb.empty;
		seq_item.D_out=vif.monitor_cb.D_out;
      `uvm_info("MONITOR", $psprintf("Monitoring data: \nwr_rd= %0h \nempty= %0h  \nD_out= %0h",seq_item.wr_rd,seq_item.empty,seq_item.D_out),UVM_LOW);
		end
  
    Mon2Scb_port.write(seq_item);
     
end
endtask
endclass					
