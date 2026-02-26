task run_test;
	begin
		$display("==============================================");
		$display("============= TEST CASE: OVERFLOW ============");
		$display("==============================================");

		sys_rst_n = 0;
		@(posedge sys_clk);
		sys_rst_n =1;

		write(ADDR_TCR, 32'h0000_0000, 1'b0, 4'hf);
		write(ADDR_TDR0, 32'hffff_fff0, 1'b0, 4'hf);
		write(ADDR_TDR1, 32'hffff_ffff, 1'b0, 4'hf);
		write(ADDR_TCR, 32'h0000_0001, 1'b0, 4'hf);

		repeat(15) begin
			@(posedge sys_clk);
		end

		read(ADDR_TDR0);

		if(rdata == 32'h0000_0002) begin
			$display("---------------------------------------------------------------------------------------");
			$display("t=%0d, PASS: counter continues counting after overflow (TDR0), EXP: 32'h2, ACT: 32'h%0h", $time, rdata);
			$display("---------------------------------------------------------------------------------------");
		end	
		else begin
			$display("---------------------------------------------------------------------------------------");
			$display("t=%0d, FAIL: counter continues counting after overflow (TDR0), EXP: 32'h2, ACT: 32'h%0h", $time, rdata);
			$display("---------------------------------------------------------------------------------------");		        
		        cnt_fail = cnt_fail + 1;
		end
	
		read(ADDR_TDR1);

		if(rdata == 32'h0000_0000) begin
			$display("---------------------------------------------------------------------------------------");
			$display("t=%0d, PASS: counter continues counting after overflow (TDR1), EXP: 32'h0, ACT: 32'h%0h", $time, rdata);
			$display("---------------------------------------------------------------------------------------");
		end	
		else begin
			$display("---------------------------------------------------------------------------------------");
			$display("t=%0d, FAIL: counter continues counting after overflow (TDR1), EXP: 32'h0, ACT: 32'h%0h", $time, rdata);
			$display("---------------------------------------------------------------------------------------");		        
		        cnt_fail = cnt_fail + 1;
		end



		if(cnt_fail == 0) begin
			$display("==============================================");
			$display("=============== PASS: OVERFLOW ===============");
			$display("==============================================");
		end
		else begin
			$display("==============================================");
			$display("=============== FAIL: OVERFLOW ===============");
			$display("==============================================");
			cnt_fail = 0;
		end
	

	end
endtask
