class my_driver extends uvm_driver#(my_seq_item);
`uvm_component_utils(my_driver) 

virtual DUT_intf vif;
  uvm_analysis_port#(my_seq_item) Driv2Scb_port;

function new(string name, uvm_component parent);
super.new(name,parent);
endfunction

function void build_phase(uvm_phase phase);
super.build_phase(phase);
  if(!uvm_config_db#(virtual DUT_intf)::get(this,"","vif",vif))begin
`uvm_fatal("No Virtual Interface found", {"Virtual interface must be set for: ",get_full_name(),".vif"});
end
  Driv2Scb_port=new("Driv2Scb_port",this);
endfunction: build_phase

virtual task run_phase(uvm_phase phase); 
forever begin
seq_item_port.get_next_item(req);
drive();
seq_item_port.item_done();
end
endtask

virtual task drive();
@(vif.driver_cb);
  if(req.wr_rd)begin //FIFO write
		vif.driver_cb.wr_rd<=req.wr_rd;
		vif.driver_cb.D_in<=req.D_in;
    `uvm_info("DRIVER", $sformatf("WRITE data across FIFO:  %s",req.convert2string()),UVM_LOW);
  end          
  else begin //FIFO read
    	vif.driver_cb.wr_rd<=req.wr_rd;
    `uvm_info("DRIVER",$sformatf("READ Data from the FIFO: \nwr_rd = %0h",req.wr_rd),UVM_LOW);
  end
  Driv2Scb_port.write(req);
endtask
endclass
