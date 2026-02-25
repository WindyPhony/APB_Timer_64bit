task run_test;
	integer i;
	begin
		$display("==============================================");
		$display("============== TEST CASE: PSTRB ==============");
		$display("==============================================");

		sys_rst_n = 0;
		@(posedge sys_clk);
		sys_rst_n = 1;
	//TCR
		rw_pstrb(ADDR_TCR, 32'h0000_0302, 32'h0000_0302, 1'b0, 4'b0011);
		rw_pstrb(ADDR_TCR, 32'h0000_0200, 32'h0000_0202, 1'b0, 4'b0010);
		rw_pstrb(ADDR_TCR, 32'h0000_0300, 32'h0000_0200, 1'b0, 4'b0001);
		rw_pstrb(ADDR_TCR, 32'h0000_0101, 32'h0000_0200, 1'b0, 4'b0000);
		
		write(ADDR_TCR, 32'h0000_0000, 1'b0, 4'hf);
	//TDR0
		rw_pstrb(ADDR_TDR0, 32'hffff_ffff, 32'hffff_ffff, 1'b0, 4'b1111);
		rw_pstrb(ADDR_TDR0, 32'heeee_eeee, 32'heeee_eeff, 1'b0, 4'b1110);
		rw_pstrb(ADDR_TDR0, 32'hdddd_dddd, 32'hdddd_eedd, 1'b0, 4'b1101);
		rw_pstrb(ADDR_TDR0, 32'hcccc_cccc, 32'hcccc_eedd, 1'b0, 4'b1100);
		rw_pstrb(ADDR_TDR0, 32'hbbbb_bbbb, 32'hbbcc_bbbb, 1'b0, 4'b1011);
		rw_pstrb(ADDR_TDR0, 32'haaaa_aaaa, 32'haacc_aabb, 1'b0, 4'b1010);
		rw_pstrb(ADDR_TDR0, 32'h9999_9999, 32'h99cc_aa99, 1'b0, 4'b1001);
		rw_pstrb(ADDR_TDR0, 32'h8888_8888, 32'h88cc_aa99, 1'b0, 4'b1000);
		rw_pstrb(ADDR_TDR0, 32'h7777_7777, 32'h8877_7777, 1'b0, 4'b0111);
		rw_pstrb(ADDR_TDR0, 32'h6666_6666, 32'h8866_6677, 1'b0, 4'b0110);
		rw_pstrb(ADDR_TDR0, 32'h5555_5555, 32'h8855_6655, 1'b0, 4'b0101);
		rw_pstrb(ADDR_TDR0, 32'h4444_4444, 32'h8844_6655, 1'b0, 4'b0100);
		rw_pstrb(ADDR_TDR0, 32'h3333_3333, 32'h8844_3333, 1'b0, 4'b0011);
		rw_pstrb(ADDR_TDR0, 32'h2222_2222, 32'h8844_2233, 1'b0, 4'b0010);
		rw_pstrb(ADDR_TDR0, 32'h1111_1111, 32'h8844_2211, 1'b0, 4'b0001);
		rw_pstrb(ADDR_TDR0, 32'h0000_0000, 32'h8844_2211, 1'b0, 4'b0000);
	//TDR1
		rw_pstrb(ADDR_TDR1, 32'hffff_ffff, 32'hffff_ffff, 1'b0, 4'b1111);
		rw_pstrb(ADDR_TDR1, 32'heeee_eeee, 32'heeee_eeff, 1'b0, 4'b1110);
		rw_pstrb(ADDR_TDR1, 32'hdddd_dddd, 32'hdddd_eedd, 1'b0, 4'b1101);
		rw_pstrb(ADDR_TDR1, 32'hcccc_cccc, 32'hcccc_eedd, 1'b0, 4'b1100);
		rw_pstrb(ADDR_TDR1, 32'hbbbb_bbbb, 32'hbbcc_bbbb, 1'b0, 4'b1011);
		rw_pstrb(ADDR_TDR1, 32'haaaa_aaaa, 32'haacc_aabb, 1'b0, 4'b1010);
		rw_pstrb(ADDR_TDR1, 32'h9999_9999, 32'h99cc_aa99, 1'b0, 4'b1001);
		rw_pstrb(ADDR_TDR1, 32'h8888_8888, 32'h88cc_aa99, 1'b0, 4'b1000);
		rw_pstrb(ADDR_TDR1, 32'h7777_7777, 32'h8877_7777, 1'b0, 4'b0111);
		rw_pstrb(ADDR_TDR1, 32'h6666_6666, 32'h8866_6677, 1'b0, 4'b0110);
		rw_pstrb(ADDR_TDR1, 32'h5555_5555, 32'h8855_6655, 1'b0, 4'b0101);
		rw_pstrb(ADDR_TDR1, 32'h4444_4444, 32'h8844_6655, 1'b0, 4'b0100);
		rw_pstrb(ADDR_TDR1, 32'h3333_3333, 32'h8844_3333, 1'b0, 4'b0011);
		rw_pstrb(ADDR_TDR1, 32'h2222_2222, 32'h8844_2233, 1'b0, 4'b0010);
		rw_pstrb(ADDR_TDR1, 32'h1111_1111, 32'h8844_2211, 1'b0, 4'b0001);
		rw_pstrb(ADDR_TDR1, 32'h0000_0000, 32'h8844_2211, 1'b0, 4'b0000);
	//TCMP0
		rw_pstrb(ADDR_TCMP0, 32'hffff_ffff, 32'hffff_ffff, 1'b0, 4'b1111);
		rw_pstrb(ADDR_TCMP0, 32'heeee_eeee, 32'heeee_eeff, 1'b0, 4'b1110);
		rw_pstrb(ADDR_TCMP0, 32'hdddd_dddd, 32'hdddd_eedd, 1'b0, 4'b1101);
		rw_pstrb(ADDR_TCMP0, 32'hcccc_cccc, 32'hcccc_eedd, 1'b0, 4'b1100);
		rw_pstrb(ADDR_TCMP0, 32'hbbbb_bbbb, 32'hbbcc_bbbb, 1'b0, 4'b1011);
		rw_pstrb(ADDR_TCMP0, 32'haaaa_aaaa, 32'haacc_aabb, 1'b0, 4'b1010);
		rw_pstrb(ADDR_TCMP0, 32'h9999_9999, 32'h99cc_aa99, 1'b0, 4'b1001);
		rw_pstrb(ADDR_TCMP0, 32'h8888_8888, 32'h88cc_aa99, 1'b0, 4'b1000);
		rw_pstrb(ADDR_TCMP0, 32'h7777_7777, 32'h8877_7777, 1'b0, 4'b0111);
		rw_pstrb(ADDR_TCMP0, 32'h6666_6666, 32'h8866_6677, 1'b0, 4'b0110);
		rw_pstrb(ADDR_TCMP0, 32'h5555_5555, 32'h8855_6655, 1'b0, 4'b0101);
		rw_pstrb(ADDR_TCMP0, 32'h4444_4444, 32'h8844_6655, 1'b0, 4'b0100);
		rw_pstrb(ADDR_TCMP0, 32'h3333_3333, 32'h8844_3333, 1'b0, 4'b0011);
		rw_pstrb(ADDR_TCMP0, 32'h2222_2222, 32'h8844_2233, 1'b0, 4'b0010);
		rw_pstrb(ADDR_TCMP0, 32'h1111_1111, 32'h8844_2211, 1'b0, 4'b0001);
		rw_pstrb(ADDR_TCMP0, 32'h0000_0000, 32'h8844_2211, 1'b0, 4'b0000);
	//TCMP1
		rw_pstrb(ADDR_TCMP1, 32'hffff_ffff, 32'hffff_ffff, 1'b0, 4'b1111);
		rw_pstrb(ADDR_TCMP1, 32'heeee_eeee, 32'heeee_eeff, 1'b0, 4'b1110);
		rw_pstrb(ADDR_TCMP1, 32'hdddd_dddd, 32'hdddd_eedd, 1'b0, 4'b1101);
		rw_pstrb(ADDR_TCMP1, 32'hcccc_cccc, 32'hcccc_eedd, 1'b0, 4'b1100);
		rw_pstrb(ADDR_TCMP1, 32'hbbbb_bbbb, 32'hbbcc_bbbb, 1'b0, 4'b1011);
		rw_pstrb(ADDR_TCMP1, 32'haaaa_aaaa, 32'haacc_aabb, 1'b0, 4'b1010);
		rw_pstrb(ADDR_TCMP1, 32'h9999_9999, 32'h99cc_aa99, 1'b0, 4'b1001);
		rw_pstrb(ADDR_TCMP1, 32'h8888_8888, 32'h88cc_aa99, 1'b0, 4'b1000);
		rw_pstrb(ADDR_TCMP1, 32'h7777_7777, 32'h8877_7777, 1'b0, 4'b0111);
		rw_pstrb(ADDR_TCMP1, 32'h6666_6666, 32'h8866_6677, 1'b0, 4'b0110);
		rw_pstrb(ADDR_TCMP1, 32'h5555_5555, 32'h8855_6655, 1'b0, 4'b0101);
		rw_pstrb(ADDR_TCMP1, 32'h4444_4444, 32'h8844_6655, 1'b0, 4'b0100);
		rw_pstrb(ADDR_TCMP1, 32'h3333_3333, 32'h8844_3333, 1'b0, 4'b0011);
		rw_pstrb(ADDR_TCMP1, 32'h2222_2222, 32'h8844_2233, 1'b0, 4'b0010);
		rw_pstrb(ADDR_TCMP1, 32'h1111_1111, 32'h8844_2211, 1'b0, 4'b0001);
		rw_pstrb(ADDR_TCMP1, 32'h0000_0000, 32'h8844_2211, 1'b0, 4'b0000);
	//TIER
		rw_pstrb(ADDR_TIER, 32'h0000_0001, 32'h0000_0001, 1'b0, 4'b0001);
		rw_pstrb(ADDR_TIER, 32'h0000_0000, 32'h0000_0001, 1'b0, 4'b0000);
	//TISR
	        //write(ADDR_TDR0, 32'h1111_1111, 1'b0, 4'hf);

		rw_pstrb(ADDR_TISR, 32'h0000_0000, 32'h0000_0001, 1'b0, 4'b0001);
		rw_pstrb(ADDR_TISR, 32'h0000_0001, 32'h0000_0001, 1'b0, 4'b0000);
	//THCSR
		rw_pstrb(ADDR_THCSR, 32'h0000_0001, 32'h0000_0001, 1'b0, 4'b0001);
		rw_pstrb(ADDR_THCSR, 32'h0000_0000, 32'h0000_0001, 1'b0, 4'b0000);

		if(cnt_fail == 0) begin
			$display("==============================================");
			$display("================ PASS: PSTRB =================");
			$display("==============================================");
		end
		else begin
			$display("==============================================");
			$display("================ FAIL: PSTRB =================");
			$display("==============================================");
			cnt_fail = 0;
		end
	


	end
endtask
