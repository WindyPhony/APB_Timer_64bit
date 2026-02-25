
`timescale 1ns/1ns

module test_bench;
         reg clk;
	 reg rst_n;
	 reg wr_en;
	 reg rd_en;
	 reg [9:0]addr;
	 reg [31:0]wdata;
	 wire [31:0]rdata;

        //wire [31:0]data0;

	 register1 dut(.*);
	 /*top dut(.clk(clk),
		 .rst_n(rst_n),
		 .wr_en(wr_en),
		 .rd_en,
		 .addr(addr),
		 .wdata(wdata),
		 .rdata(rdata),
		 .data0(data0)
	 );*/

	 initial begin
		 clk = 0;
		 forever #10 clk = ~clk;
	 end

	 initial begin
		 rst_n = 0;
		 wr_en = 0;
		 rd_en = 0;
		 addr  = 10'h0;
		 wdata = 32'h0;

		 repeat(2) @(posedge clk);

		 #1;
		 if(rdata == 32'h0) begin
			 $display("==========================================");
			 $display("========== PASS: initial value ===========");
			 $display("==========================================");
		 end
		 else begin
			 $display("==========================================");
			 $display("========== FAIL: initial value ===========");
			 $display("==========================================");	
		 end
		 
		 rst_n = 1;

		 repeat(2) @(posedge clk);
		 
		 #1;
		 wr_en = 1;
		 wdata = 32'habab_abab;

		 repeat(1) @(posedge clk);

		 #1;
		 wr_en = 0;
		 rd_en = 1;

		 repeat(1) @(posedge clk);

		 #1;
		 if(rdata == 32'habab_abab) begin
			 $display("==========================================");
			 $display("======= PASS: register address 0x0 =======");
			 $display("==========================================");
		 end
		 else begin
			 $display("==========================================");
			 $display("======= FAIL: register address 0x0 =======");
			 $display("==========================================");	
		 end

		 rd_en = 0;

		 repeat(1) @(posedge clk);

		 #1;
		 wr_en = 1;
		 wdata = 32'h1234_5678;
 
		 repeat(1) @(posedge clk);

		 #1;
		 addr = 10'h4;
		 wdata = 32'h1010_1010;

		 repeat(1) @(posedge clk);
 
		 wr_en = 0;
		 rd_en = 1;

		 repeat(1) @(posedge clk);

		 #1;
		 if(rdata == 32'h1234_5678) begin
			 $display("==========================================");
			 $display("======= PASS: register address 0x4 =======");
			 $display("==========================================");
		 end
		 else begin
			 $display("==========================================");
			 $display("== FAIL: register address 0x4 only read ==");
			 $display("==========================================");	
		 end

		 addr = 10'h8;

		 repeat(2) @(posedge clk);

		 #1;
		 if(rdata == 32'h1010_1010) begin
			 $display("==========================================");
			 $display("======= PASS: register address 0x8 =======");
			 $display("==========================================");
		 end
		 else begin
			 $display("==========================================");
			 $display("======= FAIL: register address 0x8 =======");
			 $display("==========================================");	
		 end
	
		 #1;
		 rd_en = 0;
		 
		 repeat(1) @(posedge clk);

		 #1;
		 wr_en = 1;
		 wdata = 32'h8888_8888;

		 repeat(1) @(posedge clk);

		 #1;
		 addr = 10'hc;
		 wr_en = 0;
		 rd_en = 1;

		 repeat(2) @(posedge clk);

		 #1;
		 if(rdata == 32'h1010_1010) begin
			 $display("==========================================");
			 $display("======= PASS: register address 0xC =======");
			 $display("==========================================");
		 end
		 else begin
			 $display("==========================================");
			 $display("== FAIL: register address 0xC only read ==");
			 $display("==========================================");	
		 end

		 rd_en = 0;
		 $finish;
	 end

endmodule
