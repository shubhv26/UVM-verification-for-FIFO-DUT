`include "uvm_macros.svh"
import uvm_pkg::*;
`include "interface.sv"
`include "dut_wrapper.sv"
`include "my_test.sv"


module tb_TOP;
bit clk;
bit rst;
  
always #10 clk=~clk;

initial begin
 rst=1;
#5 rst=0; 
end

DUT_intf dut_if1(clk,rst);
dut_wrapper dut_w(.intf(dut_if1));

initial begin
  uvm_config_db#(virtual DUT_intf)::set(uvm_root::get(),"*","vif",dut_if1);
run_test("my_test");
  
end
endmodule
