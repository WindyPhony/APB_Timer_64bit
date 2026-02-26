task run_test;
	begin
		$display("==============================================");
		$display("============ TEST CASE: INTERRUPTS ===========");
		$display("==============================================");

		sys_rst_n = 0;
		@(posedge sys_clk);
		sys_rst_n =1;
	//no enable interrupt
		write(ADDR_TIER, 32'h0000_0000, 1'b0, 4'hf);
		write(ADDR_TCR, 32'h0000_0000, 1'b0, 4'hf);
		write(ADDR_TDR0, 32'h0000_0001, 1'b0, 4'hf);
		write(ADDR_TDR1, 32'h0000_0000, 1'b0, 4'hf);
		write(ADDR_TCMP0, 32'h0000_0009, 1'b0, 4'hf);
		write(ADDR_TCMP1, 32'h0000_0000, 1'b0, 4'hf);
		write(ADDR_TCR, 32'h0000_0001, 1'b0, 4'hf);

		repeat(10) begin
			@(posedge sys_clk);
		end

		if(tim_int == 1'b0) begin
			$display("---------------------------------------------------------------------------------------");
			$display("t=%0d, PASS: no timer interrupt is output when int_en = 0, EXP: 1'b0, ACT: 1'b%0b", $time, tim_int);
			$display("---------------------------------------------------------------------------------------");
		end	
		else begin
			$display("---------------------------------------------------------------------------------------");
			$display("t=%0d, FAIL: no timer interrupt is output when int_en = 0, EXP: 1'b0, ACT: 1'b%0b", $time, tim_int);
			$display("---------------------------------------------------------------------------------------");		        
		        cnt_fail = cnt_fail + 1;
		end
	//enable interrupt
		write(ADDR_TIER, 32'h0000_0001, 1'b0, 4'hf);
		write(ADDR_TCR, 32'h0000_0000, 1'b0, 4'hf);
		write(ADDR_TDR0, 32'h0000_0001, 1'b0, 4'hf);
		write(ADDR_TDR1, 32'h0000_0000, 1'b0, 4'hf);
		write(ADDR_TCMP0, 32'h0000_0009, 1'b0, 4'hf);
		write(ADDR_TCMP1, 32'h0000_0000, 1'b0, 4'hf);
		write(ADDR_TCR, 32'h0000_0001, 1'b0, 4'hf);

		repeat(10) begin
			@(posedge sys_clk);
		end

		if(tim_int == 1'b1) begin
			$display("---------------------------------------------------------------------------------------");
			$display("t=%0d, PASS: timer interrupt is 1'b1, EXP: 1'b1, ACT: 1'b%0b", $time, tim_int);
			$display("---------------------------------------------------------------------------------------");
		end	
		else begin
			$display("---------------------------------------------------------------------------------------");
			$display("t=%0d, FAIL: timer interrupt must be 1'b1, EXP: 1'b1, ACT: 1'b%0b", $time, tim_int);
			$display("---------------------------------------------------------------------------------------");		        
		        cnt_fail = cnt_fail + 1;
		end
		
	//Clear interrupt (set int_st = 1);
		write(ADDR_TISR, 32'h0000_0001, 1'b0, 4'hf);
		write(ADDR_TISR, 32'h0000_0000, 1'b0, 4'hf);

		if(tim_int == 1'b0) begin
			$display("---------------------------------------------------------------------------------------");
			$display("t=%0d, PASS: set int_st = 1 to clear interrupt, EXP: 1'b0, ACT: 1'b%0b", $time, tim_int);
			$display("---------------------------------------------------------------------------------------");
		end	
		else begin
			$display("---------------------------------------------------------------------------------------");
			$display("t=%0d, FAIL: set int_st = 1 to clear interrupt, EXP: 1'b0, ACT: 1'b%0b", $time, tim_int);
			$display("---------------------------------------------------------------------------------------");		        
		        cnt_fail = cnt_fail + 1;
		end
	
	//enable interrupt
		write(ADDR_TIER, 32'h0000_0001, 1'b0, 4'hf);
		write(ADDR_TCR, 32'h0000_0000, 1'b0, 4'hf);
		write(ADDR_TDR0, 32'h0000_0001, 1'b0, 4'hf);
		write(ADDR_TDR1, 32'h0000_0000, 1'b0, 4'hf);
		write(ADDR_TCMP0, 32'h0000_0009, 1'b0, 4'hf);
		write(ADDR_TCMP1, 32'h0000_0000, 1'b0, 4'hf);
		write(ADDR_TCR, 32'h0000_0001, 1'b0, 4'hf);

		repeat(10) begin
			@(posedge sys_clk);
		end
		
		write(ADDR_TIER, 32'h0000_0000, 1'b0, 4'hf);

		if(tim_int == 1'b0) begin
			$display("---------------------------------------------------------------------------------------");
			$display("t=%0d, PASS: set int_en = 1 to clear tim_int, EXP: 1'b0, ACT: 1'b%0b", $time, tim_int);
			$display("---------------------------------------------------------------------------------------");
		end	
		else begin
			$display("---------------------------------------------------------------------------------------");
			$display("t=%0d, FAIL: set int_en =1 to clear tim_int, EXP: 1'b0, ACT: 1'b%0b", $time, tim_int);
			$display("---------------------------------------------------------------------------------------");		        
		        cnt_fail = cnt_fail + 1;
		end
		
		if(cnt_fail == 0) begin
			$display("==============================================");
			$display("============== PASS: INTERRUPTS ==============");
			$display("==============================================");
		end
		else begin
			$display("==============================================");
			$display("============== FAIL: INTERRUPTS ==============");
			$display("==============================================");
			cnt_fail = 0;
		end
	
	
	end
endtask
