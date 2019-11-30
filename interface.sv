interface DUT_intf(input logic clk,rst);
  logic wr_rd;
  logic full;
  logic empty;
  logic [7:0] D_in;
  logic [7:0] D_out;
  
  clocking driver_cb@(posedge clk);
  default input #1 output #1;
  output wr_rd;
  //output full;
  output  empty;
    output D_in;
    input  D_out;
  endclocking
  
  clocking monitor_cb@(posedge clk);
  default input #1 output #1;
  input  wr_rd;
  input  full;
  input  empty;
    input  D_in;
    input  D_out;
  endclocking
  
  endinterface