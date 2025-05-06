module baud_gen(
  input [1:0] baud_rate,
  input rst, clock,  
  output reg baud_out
);
reg [13:0] count;

always @(posedge clock or negedge rst) begin
    if (~rst) begin
        baud_out <= 1'b0;    
        count <= 14'd0; 
    end else begin
        case (baud_rate)
            2'b00: begin
                if (count < 14'd13003) begin
                    count <= count + 1'b1; 
                    baud_out <= 1'b0;          
                end else begin
                    count <= 14'd0;        
                    baud_out <= 1'b1;         
                end
            end
            2'b01: begin
                if (count < 10'd651) begin
                    count <= count + 1'b1; 
                    baud_out <= 1'b0;          
                end else begin
                    count <= 10'd0;        
                    baud_out <= 1'b1;         
                end
            end
            2'b10: begin
                if (count < 9'd326) begin
                    count <= count + 1'b1; 
                    baud_out <= 1'b0;          
                end else begin
                    count <= 9'd0;        
                    baud_out <= 1'b1;         
                end
            end
            2'b11: begin
                if (count < 8'd162) begin
                    count <= count + 1'b1; 
                    baud_out <= 1'b0;          
                end else begin
                    count <= 8'd0;        
                    baud_out <= 1'b1;         
                end
            end
        endcase
    end
end

endmodule
