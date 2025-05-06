module piso(
    input [11:0] frame_out,
    input [1:0]  parity_type,
    input stop_bits, data_length, send, baud_out, rst,
    output reg  data_out, P_parity_out, tx_active, tx_done
);
reg [4:0] count;
reg [10:0] s_data;
wire count_max;

always @(posedge baud_out or negedge rst) begin 
    if(~rst) begin
        s_data   <= 0;
    end
    else if (send) begin
        s_data   <= frame_out;
    end
end

always @(posedge baud_out)
begin
    if (count_max)
        begin
            data_out = 0;
            tx_active = 0;
        end
        else
            begin
                data_out = s_data [count];
                tx_active = 1;
            end
end

always@(posedge baud_out or negedge rst)
       begin
          if(!rst)
            count <= 4'b1000;
          else if (~send)
            begin
                count    <= 4'b0 ;
            end         
          else if (!count_max)
            begin
                count    <= count + 4'b1 ;
            end
       end
   

   assign count_max = ( count == 4'b1011 );
   assign tx_done  = count_max;

always @(posedge baud_out or negedge rst) begin
    if (~rst)
    P_parity_out = 1'b0;
    else begin
    case (parity_type)                  // 0 no parity, 1 parity
        2'b00:
        P_parity_out = 1'b0; 
        2'b01:
        P_parity_out = 1'b1;
        2'b10:
        P_parity_out = 1'b1;
        2'b11:
        P_parity_out = 1'b0;
    endcase
    end
end

endmodule
