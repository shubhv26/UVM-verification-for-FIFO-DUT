module fifo #(parameter DWIDTH=7)
  			(input logic clk, rst, wr_rd,
			 output logic full,empty,
             input logic [DWIDTH:0] D_in,
             output logic [DWIDTH:0] D_out);

logic [2:0] wptr, rptr;
logic [7:0] mem[7:0];
  
assign full=((wptr==3'b111)&(rptr==3'b000)?1:0);
assign empty=(wptr==rptr)?1:0;

  always_ff@(posedge clk or posedge rst)
begin
	if(rst)
	begin
		for(int i=0;i<8; i++)
		begin
			mem[i]<=0;
			end
		wptr<=0;
		rptr<=0;
		D_out<=0;
	end
	
	else if(wr_rd & !full)
	begin
      mem[wptr]<=D_in;
		wptr<=wptr+1;
	end
	
	else if(!wr_rd & !empty)
	begin
		D_out<=mem[rptr];
		rptr<=rptr+1;
	end
end
endmodule
				
		