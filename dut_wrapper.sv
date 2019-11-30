module dut_wrapper(DUT_intf intf);
 
  fifo DUT(.clk(intf.clk),
            .rst(intf.rst),
            .wr_rd(intf.wr_rd),
            .full(intf.full),
             .empty(intf.empty),
             .D_in(intf.D_in),
             .D_out(intf.D_out));
endmodule
