task run_test;
	begin
		$display("==============================================");
		$display("============ TEST CASE: APB ERROR ============");
		$display("==============================================");

		sys_rst_n = 0;
		@(posedge sys_clk);
		sys_rst_n = 1;

		#1;
		 tim_psel    = 1'b0;
		 tim_penable = 1'b0;
		 tim_pwrite  = 1'b0;
		
		 @(posedge sys_clk);

		 #1;
		 tim_psel    = 1'b1;
		 tim_penable = 1'b0;
		 tim_pwrite  = 1'b1;
		 tim_paddr    = 12'h000;
		 tim_pwdata   = 111;
		 tim_pstrb   = 4'hf;
		 dbg_mode    = 1'b0;

		 @(posedge sys_clk);

		 #1;
		 tim_penable = 1'b1;
		  
		 
		 @(posedge sys_clk);
		 #1;
		 if (tim_pready == 1'b1) begin
			$display("---------------------------------------------------------------------------------------");
			$display("t=%0d, PASS: set pready, EXP: 1'b1, ACT: 1'b%0b", $time, tim_pready);
			$display("---------------------------------------------------------------------------------------");
		end
		else begin
			$display("---------------------------------------------------------------------------------------");
			$display("t=%0d, FAIL:set pready, EXP: 1'b1, ACT: 1'b%0b", $time, tim_pready);
			$display("---------------------------------------------------------------------------------------");
			cnt_fail = cnt_fail + 1;	
		end


		 @(posedge sys_clk);
		 
		 #1;
		 tim_psel    = 1'b0;
		 tim_penable = 1'b0;
		 tim_pwrite  = 1'b0;
		 
		 @(posedge sys_clk);

		 #1;
		 tim_psel    = 1'b0;
		 tim_penable = 1'b1;

		 @(posedge sys_clk);
                 
		 #1;
		 if (tim_pready == 1'b0) begin
			$display("---------------------------------------------------------------------------------------");
			$display("t=%0d, PASS: no set pready because psel = 0, EXP: 1'b1, ACT: 1'b%0b", $time, tim_pready);
			$display("---------------------------------------------------------------------------------------");
		end
		else begin
			$display("---------------------------------------------------------------------------------------");
			$display("t=%0d, FAIL: no set pready because psel = 0, EXP: 1'b1, ACT: 1'b%0b", $time, tim_pready);
			$display("---------------------------------------------------------------------------------------");
			cnt_fail = cnt_fail + 1;	
		end

		if(cnt_fail == 0) begin
			$display("==============================================");
			$display("=============== PASS: APB ERROR ==============");
			$display("==============================================");
		end
		else begin
			$display("==============================================");
			$display("=============== FAIL: ABP ERROR ==============");
			$display("==============================================");
			cnt_fail = 0;
		end
	end
endtask
