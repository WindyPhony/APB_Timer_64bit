task run_test;

	begin
		cnt_fail = 0;

		$display("==============================================");
		$display("========== TEST CASE: INITIAL VALUE ==========");
		$display("==============================================");

		sys_rst_n = 0;
		@(posedge sys_clk);
		sys_rst_n =1;

	        test_bench.reg_init (ADDR_TCR, 32'h0000_0100);
	        test_bench.reg_init (ADDR_TDR0, 32'h0000_0000);
	        test_bench.reg_init (ADDR_TDR1, 32'h0000_0000);
	        test_bench.reg_init (ADDR_TCMP0, 32'hffff_ffff);
	        test_bench.reg_init (ADDR_TCMP1, 32'hffff_ffff);
		test_bench.reg_init (ADDR_TIER, 32'h0000_0000);
	        test_bench.reg_init (ADDR_TISR, 32'h0000_0000);
	        test_bench.reg_init (ADDR_THCSR, 32'h0000_0000);
		
		if(cnt_fail == 0) begin
			$display("==============================================");
			$display("============ PASS: INITIAL VALUE =============");
			$display("==============================================");
		end
		else begin
			$display("==============================================");
			$display("============ FAIL: INITIAL VALUE =============");
			$display("==============================================");
			cnt_fail = 0;
		end
	end
endtask
