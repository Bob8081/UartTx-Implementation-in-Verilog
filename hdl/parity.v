module parity (
    input rst,
    input [7:0] data_in, 
    input [1:0] parity_type,
    output reg parity_out
);
    //reg [7:0] p_data;
    wire parity;
    assign parity = ^data_in; // 1 if parity is odd, 0 if parity is even
    
    always @(negedge rst)
    begin
        if (~rst) begin
        parity_out = 1'b0;
        end    
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
    
    
endmodule