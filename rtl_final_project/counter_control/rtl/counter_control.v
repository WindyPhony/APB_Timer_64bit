module counter_control(
	input wire CLK,
	input wire RST_N,
	input wire [3:0]div_val,
	input wire div_en,
	input wire timer_en,
//	input wire err_div_val,
//	input wire err_div_en,
	input wire halt_ack,
	output reg cnt_en
);

//wire [3:0]div_val_t;
//wire div_en_t;
reg  [7:0]int_cnt;

//assign div_val_t = err_div_val ? div_val_t : div_val;
//assign div_en_t  = err_div_en  ? div_en_t  : div_en;

always @(posedge CLK or negedge RST_N) begin
	if(!RST_N) begin
		int_cnt <= 8'b0;
	end
	else begin
		if(halt_ack) begin
			int_cnt <= int_cnt;
		end
		else begin
			if((int_cnt == 2**(div_val)-1) || !div_en || !timer_en) begin
				int_cnt <= 8'b0;
			end
			else begin
				int_cnt <= int_cnt + 1;
			end
		end
	end
end

always @* begin
	if(!timer_en) begin
		cnt_en = 1'b0;
	end
	else begin
		if(!div_en) begin
			cnt_en = ~halt_ack;
		end
		else begin
			cnt_en = (int_cnt == 2**(div_val)-1) & ~halt_ack;
		end
	end
end

endmodule
