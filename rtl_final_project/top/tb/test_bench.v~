
`timescale 1ns/1ns

module test_bench;
         reg sys_clk;
         reg sys_rst_n;
         reg tim_psel;
         reg tim_pwrite;
         reg tim_penable;
         reg [11:0]tim_paddr;
         reg [31:0]tim_pwdata;
	 reg dbg_mode;
	 reg [3:0] tim_pstrb;
	 wire [31:0]tim_prdata;
	 wire tim_pready;
	 wire tim_pslverr;
	 wire tim_int;

	 top dut(.*);

	 initial begin
		 sys_clk =0;
		 forever #100 sys_clk = ~sys_clk;
	 end

	 initial begin
		 sys_rst_n = 1'b0;
		 tim_psel    = 1'b0;
		 tim_penable = 1'b0;
		 tim_pwrite  = 1'b0;
		 tim_paddr    = 11'h0;
		 tim_pwdata   = 32'h0;
		 tim_pstrb   = 4'hf;
		 dbg_mode    = 0;

		 @(posedge sys_clk);

		 #1;
		 sys_rst_n = 1'b1;

		 @(posedge sys_clk);
		 
		 write(12'h004, 32'h0000_0000, 0, 4'hf);
		 write(12'h008, 32'h0000_0000, 0, 4'hf);
   		 write(12'h000, 32'h0000_0502, 0, 4'hf);
		 write(12'h01c, 32'h0000_0000, 0, 4'hf);
		 
		 write(12'h000, 32'h0000_0503, 0, 4'hf);
	 	 repeat(795) begin
			 @(posedge sys_clk);
		 end
	 	 write(12'h01c, 32'h0000_0001, 1, 4'hf);
	 	 read (12'h004);
	 	 read (12'h008);
		 
	
		 $finish;
	 end

	 task write;
		 input [11:0]addr;
		 input [31:0]data;
		 input debug;
		 input [3:0]pstrb;
		 
		 begin
			 #1;
			 tim_psel    = 1'b1;
			 tim_penable = 1'b0;
			 tim_pwrite  = 1'b1;
			 tim_paddr    = addr;
			 tim_pwdata   = data;
			 tim_pstrb   = pstrb;
			 dbg_mode    = debug;

			 @(posedge sys_clk);

			 #1;
			 tim_penable = 1'b1;
			 
			 wait (tim_pready == 1'b1);
			 @(posedge sys_clk);
			 
			 #1;
			 tim_psel    = 1'b0;
			 tim_penable = 1'b0;
			 tim_pwrite  = 1'b0;
			 
			 @(posedge sys_clk);
		 end
	 endtask
	
	 task read;
		 input  [11:0]addr;
		 
		 begin
			 #1;
			 tim_psel    = 1'b1;
			 tim_penable = 1'b0;
			 tim_pwrite  = 1'b0;
			 tim_paddr    = addr;

			 @(posedge sys_clk);

			 #1;
			 tim_penable = 1'b1;
			 
			 wait (tim_pready == 1'b1);
			 @(posedge sys_clk);
			 
			 #1;
			 tim_psel    = 1'b0;
			 tim_penable = 1'b0;
			 tim_pwrite  = 1'b0;
			 
			 @(posedge sys_clk);
		 end
	 endtask

endmodule
