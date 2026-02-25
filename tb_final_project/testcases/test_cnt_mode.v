task run_test;
	integer div_val;
	integer div_en;
	integer i;

	begin
		$display("==============================================");
		$display("========== TEST CASE: COUNTER MODE ===========");
		$display("==============================================");
	
		$display("----------------------------------------------");
		$display("------------- TEST: DEFAULT MODE -------------");
		$display("----------------------------------------------");

		sys_rst_n = 0;
		@(posedge sys_clk);
		@(posedge sys_clk);
		sys_rst_n = 1;

		for(i = 0; i < 100 ; i = i + 1) begin
			div_val = $urandom_range(0, 8);
			//div_en  = $urandom_range(0, 1);
			
			cnt_mode_halt(div_val, 1'b0, 1'b0, 1'b0);
		end
		
		$display("----------------------------------------------");
		$display("------------- TEST: DIV_VAL MODE -------------");
		$display("----------------------------------------------");

		sys_rst_n = 0;
		@(posedge sys_clk);
		@(posedge sys_clk);
		sys_rst_n = 1;

		for(i = 0; i < 100 ; i = i + 1) begin
			div_val = $urandom_range(0, 8);
			//div_en  = $urandom_range(0, 1);
			
			cnt_mode_halt(div_val, 1'b1, 1'b0, 1'b0);
		end


		if(cnt_fail == 0) begin
			$display("==============================================");
			$display("============= PASS: COUNTER MODE =============");
			$display("==============================================");
		end
		else begin
			$display("==============================================");
			$display("============= FAIL: COUNTER MODE =============");
			$display("==============================================");
			cnt_fail = 0;
		end


	end
endtask
