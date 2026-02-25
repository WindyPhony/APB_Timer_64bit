task run_test;
	begin
		$display("==============================================");
		$display("======== TEST CASE: READ/WRITE VALUE =========");
		$display("==============================================");

		sys_rst_n = 0;
		@(posedge sys_clk);
		sys_rst_n = 1;
	

	//TCR
		reg_rw(ADDR_TCR, 32'h0000_0000, 32'h0000_0000, 1'b0, 4'hf);	
		reg_rw(ADDR_TCR, 32'hffff_ffff, 32'h0000_0100, 1'b0, 4'hf);
		reg_rw(ADDR_TCR, 32'h5555_5555, 32'h0000_0501, 1'b0, 4'hf);	
		reg_rw(ADDR_TCR, 32'haaaa_aaaa, 32'h0000_0100, 1'b0, 4'hf);
		reg_rw(ADDR_TCR, 32'ha55a_a55a, 32'h0000_0502, 1'b0, 4'hf);
	
	//TDR0
		reg_rw(ADDR_TDR0, 32'h0000_0000, 32'h0000_0000, 1'b0, 4'hf);	
		reg_rw(ADDR_TDR0, 32'hffff_ffff, 32'hffff_ffff, 1'b0, 4'hf);	
		reg_rw(ADDR_TDR0, 32'h5555_5555, 32'h5555_5555, 1'b0, 4'hf);	
		reg_rw(ADDR_TDR0, 32'haaaa_aaaa, 32'haaaa_aaaa, 1'b0, 4'hf);	
		reg_rw(ADDR_TDR0, 32'ha55a_a55a, 32'ha55a_a55a, 1'b0, 4'hf);
	//TDR1
		reg_rw(ADDR_TDR1, 32'h0000_0000, 32'h0000_0000, 1'b0, 4'hf);	
		reg_rw(ADDR_TDR1, 32'hffff_ffff, 32'hffff_ffff, 1'b0, 4'hf);	
		reg_rw(ADDR_TDR1, 32'h5555_5555, 32'h5555_5555, 1'b0, 4'hf);	
		reg_rw(ADDR_TDR1, 32'haaaa_aaaa, 32'haaaa_aaaa, 1'b0, 4'hf);	
		reg_rw(ADDR_TDR1, 32'ha55a_a55a, 32'ha55a_a55a, 1'b0, 4'hf);
	//TCMP0
		reg_rw(ADDR_TCMP0, 32'h0000_0000, 32'h0000_0000, 1'b0, 4'hf);	
		reg_rw(ADDR_TCMP0, 32'hffff_ffff, 32'hffff_ffff, 1'b0, 4'hf);	
		reg_rw(ADDR_TCMP0, 32'h5555_5555, 32'h5555_5555, 1'b0, 4'hf);	
		reg_rw(ADDR_TCMP0, 32'haaaa_aaaa, 32'haaaa_aaaa, 1'b0, 4'hf);	
		reg_rw(ADDR_TCMP0, 32'ha55a_a55a, 32'ha55a_a55a, 1'b0, 4'hf);
	//TCMP1
		reg_rw(ADDR_TCMP1, 32'h0000_0000, 32'h0000_0000, 1'b0, 4'hf);	
		reg_rw(ADDR_TCMP1, 32'hffff_ffff, 32'hffff_ffff, 1'b0, 4'hf);	
		reg_rw(ADDR_TCMP1, 32'h5555_5555, 32'h5555_5555, 1'b0, 4'hf);	
		reg_rw(ADDR_TCMP1, 32'haaaa_aaaa, 32'haaaa_aaaa, 1'b0, 4'hf);	
		reg_rw(ADDR_TCMP1, 32'ha55a_a55a, 32'ha55a_a55a, 1'b0, 4'hf);
	//TIER
		reg_rw(ADDR_TIER, 32'h0000_0000, 32'h0000_0000, 1'b0, 4'hf);	
		reg_rw(ADDR_TIER, 32'hffff_ffff, 32'h0000_0001, 1'b0, 4'hf);	
		reg_rw(ADDR_TIER, 32'h5555_5555, 32'h0000_0001, 1'b0, 4'hf);	
		reg_rw(ADDR_TIER, 32'haaaa_aaaa, 32'h0000_0000, 1'b0, 4'hf);	
		reg_rw(ADDR_TIER, 32'ha55a_a55a, 32'h0000_0000, 1'b0, 4'hf);
	//TISR
		reg_rw(ADDR_TISR, 32'h0000_0000, 32'h0000_0000, 1'b0, 4'hf);	
		reg_rw(ADDR_TISR, 32'hffff_ffff, 32'h0000_0000, 1'b0, 4'hf);	
		reg_rw(ADDR_TISR, 32'h5555_5555, 32'h0000_0000, 1'b0, 4'hf);	
		reg_rw(ADDR_TISR, 32'haaaa_aaaa, 32'h0000_0000, 1'b0, 4'hf);	
		reg_rw(ADDR_TISR, 32'ha55a_a55a, 32'h0000_0000, 1'b0, 4'hf);
	//THCSR no debug mode
		reg_rw(ADDR_THCSR, 32'h0000_0000, 32'h0000_0000, 1'b0, 4'hf);	
		reg_rw(ADDR_THCSR, 32'hffff_ffff, 32'h0000_0001, 1'b0, 4'hf);	
		reg_rw(ADDR_THCSR, 32'h5555_5555, 32'h0000_0001, 1'b0, 4'hf);	
		reg_rw(ADDR_THCSR, 32'haaaa_aaaa, 32'h0000_0000, 1'b0, 4'hf);	
		reg_rw(ADDR_THCSR, 32'ha55a_a55a, 32'h0000_0000, 1'b0, 4'hf);
	//THCSR debug mode
		reg_rw(ADDR_THCSR, 32'h0000_0000, 32'h0000_0000, 1'b1, 4'hf);	
		reg_rw(ADDR_THCSR, 32'hffff_ffff, 32'h0000_0003, 1'b1, 4'hf);	
		reg_rw(ADDR_THCSR, 32'h5555_5555, 32'h0000_0003, 1'b1, 4'hf);	
		reg_rw(ADDR_THCSR, 32'haaaa_aaaa, 32'h0000_0000, 1'b1, 4'hf);	
		reg_rw(ADDR_THCSR, 32'ha55a_a55a, 32'h0000_0000, 1'b1, 4'hf);
	//Wrong addr	
		reg_rw(ADDR_TCMP0, 32'h5555_5555, 32'h5555_5555, 1'b0, 4'hf);	
		reg_rw(12'h020   , 32'hAAAA_AAAA, 32'h0000_0000, 1'b0, 4'hf);
		reg_rw(ADDR_TCMP0, 32'hAAAA_AAAA, 32'hAAAA_AAAA, 1'b0, 4'hf);	
		
		if(cnt_fail == 0) begin
			$display("==============================================");
			$display("=========== PASS: READ/WRITE VALUE ===========");
			$display("==============================================");
		end
		else begin
			$display("==============================================");
			$display("=========== FAIL: READ/WRITE VALUE ===========");
			$display("==============================================");
			cnt_fail = 0;
		end

						
	end
endtask
