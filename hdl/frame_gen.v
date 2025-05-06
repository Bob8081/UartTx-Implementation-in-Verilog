module frame_gen(
    input rst,
    input [7:0] data_in,
    output reg parity_out , 
    input [1:0] parity_type,
    input stop_bits, data_length,  
    output reg [11:0] frame_out
);


wire parity;
assign parity = ^data_in;



reg [3:0] length  = 4'd7;

parameter idle = 1'b1;
reg  start = 1'b0;
reg [1:0] stop = 1'b1;

always @(negedge rst)
begin
    frame_out = 10'd0;      
    parity_out = 1'b0;
end

always @(*) begin
    if (data_length) begin
        length = 4'd8;
        end
    else
        begin
        length = 4'd7;
        end
end

always @(*) begin
    if (stop_bits)
    stop = 2'b11;
else
    stop = 1'b1;
end

 always@(*)
    begin
     begin
			case (parity_type)
				2'b00: // No parity
							parity_out = 1'b0; // 0 NO ERROR , 1 ERROR
				2'b01: // Odd parity
					begin
						if (parity)
							parity_out = 1'b0;
						else
							parity_out = 1'b1;
					end
				2'b10: // Even parity
					begin
						if (parity)
							parity_out = 1'b1;
						else
							parity_out = 1'b0;
					end
					
				2'b11:    // Odd parity (parallel)
					begin
						if (parity)
							parity_out = 1'b0;
						else
							parity_out = 1'b1;
					end 
			endcase
        end
    end




always @(*)
begin
		if (parity_type == 1'b00 ||  parity_type == 1'b11)
           frame_out = {start, data_in[7:0], stop, idle};
		else frame_out = {start, data_in[7:0],parity_out,stop};
end

endmodule

