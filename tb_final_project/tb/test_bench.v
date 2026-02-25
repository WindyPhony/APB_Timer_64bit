`timescale 1ns/1ns
module test_bench;
	
	 parameter ADDR_TCR   = 12'h000;
         parameter ADDR_TDR0  = 12'h004;
         parameter ADDR_TDR1  = 12'h008;
         parameter ADDR_TCMP0 = 12'h00C;
         parameter ADDR_TCMP1 = 12'h010;
         parameter ADDR_TIER  = 12'h014;
         parameter ADDR_TISR  = 12'h018;
         parameter ADDR_THCSR = 12'h01C;

	 integer cnt_fail = 0;

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

	 reg pslverr;
	 reg [31:0]rdata;
	 wire [63:0]golden_cnt;
	 reg [63:0]golden_cnt_cmp;

top u_dut(
	.sys_clk(sys_clk),
    	.sys_rst_n(sys_rst_n),
	.tim_psel(tim_psel),
       	.tim_pwrite(tim_pwrite),
	.tim_penable(tim_penable),
	.tim_paddr(tim_paddr),
	.tim_pwdata(tim_pwdata),
	.dbg_mode(dbg_mode),
	.tim_pstrb(tim_pstrb),
	.tim_prdata(tim_prdata),
	.tim_pready(tim_pready),
	.tim_pslverr(tim_pslverr),
	.tim_int(tim_int)
);

golden_model_test gm_test(
        .clk(sys_clk),
	.rst_n(sys_rst_n),
	.psel(tim_psel),
	.pwrite(tim_pwrite),
	.penable(tim_penable),
       	.paddr(tim_paddr),
	.pwdata(tim_pwdata),
	.pstrb(tim_pstrb),	 
	.pslverr(tim_pslverr),
	.dbg_mode(dbg_mode),
	.cnt(golden_cnt)

);
    
`include "run_test.v"

initial begin
    	sys_clk = 0;
	forever #100 sys_clk = ~sys_clk;
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
		tim_paddr   = addr;
		tim_pstrb   = pstrb;
		dbg_mode    = debug;
		tim_pwdata  = data;

		@(posedge sys_clk);

		#1;
		tim_penable = 1'b1;
			 
		wait (tim_pready == 1'b1);
		
		#1;
		pslverr = tim_pslverr;

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
//	output [31:0]data;
		 
	begin
		#1;
		tim_psel    = 1'b1;
		tim_penable = 1'b0;
		tim_pwrite  = 1'b0;
		tim_paddr   = addr;

		@(posedge sys_clk);

		#1;
		tim_penable = 1'b1;
			 
		wait (tim_pready == 1'b1);

		#1;
		rdata = tim_prdata;
		golden_cnt_cmp = golden_cnt;
		pslverr = tim_pslverr;

		@(posedge sys_clk);  			 
		
		#1;
       		tim_psel    = 1'b0;
		tim_penable = 1'b0;
		tim_pwrite  = 1'b0;
			 
       		@(posedge sys_clk);
	end
endtask

task reg_init;
	input [11:0]addr;
	input [31:0]cmp_data;

	begin
		sys_rst_n = 0;
		@(posedge sys_clk);
		sys_rst_n = 1;
	
		read(addr);
		
	       	if(rdata == cmp_data) begin
			$display("---------------------------------------------------------------------------------------------------------------");
			$display("| t=%6d, PASS: | register addr = 12h%3h | no write | read EXP: 32'h%8h, ACT: 32'h%8h |", $time, addr, cmp_data, rdata);
			$display("---------------------------------------------------------------------------------------------------------------");
		end	
		else begin
			$display("---------------------------------------------------------------------------------------------------------------");
			$display("| t=%6d, FAIL: | register addr = 12h%3h | no write | read EXP: 32'h%8h, ACT: 32'h%8h |", $time, addr, cmp_data, rdata);
			$display("---------------------------------------------------------------------------------------------------------------");
		       
		       	cnt_fail = cnt_fail + 1;
		end


	end
endtask

task reg_rw;
	input [11:0]addr;
	input [31:0]data;
	input [31:0]cmp_data;
	input debug;
	input [3:0]pstrb;

	begin
		sys_rst_n = 0;
		@(posedge sys_clk);
		sys_rst_n = 1;
	
		write(addr, data, debug, pstrb); 
		read(addr);

	       	if(rdata == cmp_data) begin
			$display("---------------------------------------------------------------------------------------------------------------");
			$display("| t=%6d, PASS: | pstrb = 4'b%4b | register addr = 12h%3h | write 32'h%8h | read EXP: 32'h%8h, ACT: 32'h%8h |", $time, pstrb, addr, data, cmp_data, rdata);
			$display("---------------------------------------------------------------------------------------------------------------");
		end	
		else begin
			$display("---------------------------------------------------------------------------------------------------------------");
			$display("| t=%6d, FAIL: | pstrb = 4'b%4b | register addr = 12h%3h | write 32'h%8h | read EXP: 32'h%8h, ACT: 32'h%8h |", $time, pstrb, addr, data, cmp_data, rdata);
			$display("---------------------------------------------------------------------------------------------------------------");
   
		        cnt_fail = cnt_fail + 1;
		end
	end
endtask

task rw_pstrb;
	input [11:0]addr;
	input [31:0]data;
	input [31:0]cmp_data;
	input debug;
	input [3:0]pstrb;

	begin
		write(addr, data, debug, pstrb); 
		read(addr);

	       	if(rdata == cmp_data) begin
			$display("---------------------------------------------------------------------------------------------------------------");
			$display("| t=%6d, PASS: | pstrb = 4'b%4b | register addr = 12h%3h | write 32'h%8h | read EXP: 32'h%8h, ACT: 32'h%8h |", $time, pstrb, addr, data, cmp_data, rdata);
			$display("---------------------------------------------------------------------------------------------------------------");
		end	
		else begin
			$display("---------------------------------------------------------------------------------------------------------------");
			$display("| t=%6d, FAIL: | pstrb = 4'b%4b | register addr = 12h%3h | write 32'h%8h | read EXP: 32'h%8h, ACT: 32'h%8h |", $time, pstrb, addr, data, cmp_data, rdata);
			$display("---------------------------------------------------------------------------------------------------------------");
   
		        cnt_fail = cnt_fail + 1;
		end
	end
endtask


task cnt_mode_halt;
	//input [11:0]addr;
	//input [31:0]data;
	//input debug;
	//input [3:0]pstrb;
	input [3:0]div_val;
	input div_en;
	input debug;
	input halt_req;	

	integer i;
 	integer TDR0_data;
	integer TDR1_data;

	begin			
	//	for(i = 0; i < 100 ; i = i + 1) begin
		//	div_val = $urandom_range(0, 8);
		//	div_en  = $urandom_range(0, 1);
			//TDR0_data = $urandom;
			//TDR1_data = $urandom;
			//sys_rst_n = 0;
			//@(posedge sys_clk);
			//sys_rst_n = 1;
	
		$display("---------------------------------------------------------------------------------------------------------------");
		write(ADDR_TCR, {20'h0, div_val, 6'h0, div_en, 1'b0}, debug, 4'hf);

		$display("| t=%10d | register addr 12'h000 | write 32'h%8h | dbd_mode = %0h |", $time, {20'h0, div_val, 6'h0, div_en, 1'b0}, debug);

		write(ADDR_TDR0, 32'h0000_0000, debug, 4'hf);
		
		$display("| t=%10d | register addr 12'h004 | write 32'h00000000 | dbd_mode = %0h |", $time, debug);

		write(ADDR_TDR1, 32'h0000_0000, debug, 4'hf);

		$display("| t=%10d | register addr 12'h008 | write 32'h00000000 | dbd_mode = %0h |", $time, debug);

		write(ADDR_TCR, {20'h0, div_val, 6'h0, div_en, 1'b1}, debug, 4'hf);

		$display("| t=%10d | register addr 12'h000 | write 32'h%8h | dbd_mode = %0h |", $time, {20'h0, div_val, 6'h0, div_en, 1'b1}, debug);
			
		repeat($urandom_range(0, 5000)) begin
			@(posedge sys_clk);
		end

		write(ADDR_THCSR, {31'h0, halt_req}, debug, 4'hf);
		
		$display("| t=%10d | register addr 12'h01c | write 32'h%8h | dbd_mode = %0h |", $time, {31'h0, halt_req}, debug);

		read(ADDR_TDR0);	
		       	
		if(rdata == golden_cnt_cmp[31:0]) begin

			$display("| t=%10d, PASS: | read EXP: 32'h%8h, ACT: 32'h%8h |", $time, golden_cnt_cmp[31:0], rdata);
		end	
		else begin
			$display("| t=%10d, FAIL: | read EXP: 32'h%8h, ACT: 32'h%8h |", $time, golden_cnt_cmp[31:0], rdata);
   
			cnt_fail = cnt_fail + 1;
		end	

		write(ADDR_THCSR, 32'h0, debug, 4'hf);	
		write(ADDR_TCR, {20'h0, div_val, 6'h0, div_en, 1'b0}, debug, 4'hf);
		$display("---------------------------------------------------------------------------------------------------------------");

	//	end

	end
endtask
 
initial begin
	sys_rst_n   = 1'b0;
	tim_psel    = 1'b0;
	tim_penable = 1'b0;
	tim_pwrite  = 1'b0;
	tim_paddr   = 11'h0;
	tim_pwdata  = 32'h0;
	tim_pstrb   = 4'hf;
	dbg_mode    = 0;
	rdata       = 32'h0;
	#100;
	run_test();
	#100;
	$finish;
end

endmodule



module golden_model_test(
        input wire clk,
	input wire rst_n,
	input wire psel,
	input wire pwrite,
	input wire penable,
       	input wire [11:0]paddr,
	input wire [31:0]pwdata,
	input wire [3:0] pstrb,	 
	input wire pslverr,
	input wire dbg_mode,
	output reg [63:0]cnt
);
	reg timer_en;
	reg div_en;
	reg [3:0]div_val;
	reg halt;
	reg [7:0]int_cnt;
	reg timer_en_1;
	reg div_en_1;
	reg [3:0]div_val_1;
	reg halt_1;
	reg [7:0]int_cnt_1;
	
//	reg [63:0]cnt;
	
	always @(posedge clk or negedge rst_n) begin
		if(!rst_n) begin
			cnt <= 0;
		end
		else begin 
			if(!timer_en_1) begin
				cnt <= 0;
			end 
			else begin
			       	if(halt_1) begin
					cnt <= cnt;
				end 
				else begin 
					if(!div_en_1) begin
						cnt <= cnt + 1;
		  	 		end 
					else begin
					       	if(int_cnt_1 == 2**(div_val_1)-1) begin
							cnt <= cnt + 1;
						end
						else begin
							cnt <= cnt;
						end
					end
				end
			end
		end
	end

//	assign golden_int_cnt = (int_cnt == 2**(div_val)-1) ? (cnt + 1) : cnt;
//	assign golden_div_en  = div_en ? (cnt + 1) : golden_int_cnt;
//	assign golden_halt    = halt ? cnt : !golden_div_en;
//	assign cnt            = !golden_timer_en ? 0 : golden_halt; 

	always @(posedge clk or negedge rst_n) begin
		if(!rst_n) begin
			int_cnt <= 0;
		end
		else begin
			if(int_cnt == 2**(div_val)-1 || !timer_en || !div_en) begin
				int_cnt <= 0;
			end
			else begin
				int_cnt <= int_cnt + 1;
			end
		end
	end

	always @(posedge clk or negedge rst_n) begin
		if(!rst_n) begin
			timer_en <= 0;
			div_en   <= 0;
		end
		else begin
			if(psel & penable & (paddr == 12'h000) & pwrite & pstrb[0] & !pslverr) begin
				timer_en <= pwdata[0];
				div_en   <= pwdata[1];
			end
			else begin
				timer_en <= timer_en;
				div_en   <= div_en;
			end
		end
	end

	always @(posedge clk or negedge rst_n) begin
		if(!rst_n) begin
			div_val <= 0;
		end
		else begin
			if(psel & penable & (paddr == 12'h000) & pwrite & pstrb[1] & !pslverr) begin
				div_val <= pwdata[11:8];
			end
			else begin
				div_val <= div_val;
			end
		end
	end

	always @(posedge clk or negedge rst_n) begin
		if(!rst_n) begin
			halt <= 0;
		end
		else begin
			if(psel & penable & (paddr == 12'h01c) & pwrite & pstrb[0] & dbg_mode) begin
				halt <= pwdata[0];
			end
			else begin
				halt <= halt;
			end
		end

	end

	always @(posedge clk or negedge rst_n) begin
		if(!rst_n) begin
		//	golden_cnt  <= 64'h0;
			int_cnt_1  <= 8'h0;
			timer_en_1 <= 1'b0;
			div_val_1  <= 4'h0;
			div_en_1   <= 1'b0;
			halt_1     <= 1'b0;
		end
		else begin
		//	golden_cnt      <= cnt;
			int_cnt_1  <= int_cnt;
			timer_en_1 <= timer_en;
			div_val_1  <= div_val;
			div_en_1   <= div_en;
			halt_1     <= halt;

		end

	end


endmodule
