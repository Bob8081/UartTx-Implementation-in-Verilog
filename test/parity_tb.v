`timescale 1ns/1ns
module parity_tb;

reg       rst_tb;
reg [7:0] data_in_tb;
reg [1:0] parity_type;

wire      parity_out_tb;

wire parity_tb;
assign paraty_tb = ^ data_in_tb ; 

parity dut(
    .data_in(data_in_tb),
    .rst(rst_tb),
    .parity_type(parity_type),
    .parity_out(parity_out_tb)
);


initial
begin
    
    
    rst_tb= 1'b0;
    #10 rst_tb = 1'b1;
    
    
    $display(" TEST 1 00 test " );
    #10 parity_type = 2'b00;
    data_in_tb = 8'b00010111;
	if (parity_out_tb == 1'b0 ) $display("test 1 succeded"); 
	else $display("test 1 failed paraty out = %b ",parity_out_tb);
    
    
     $display(" TEST 2 01 test " );
    #10 parity_type = 2'b01;
    data_in_tb = 8'b00001111;
	if (parity_out_tb == 1'b0 && paraty_tb==1'b1 ) $display("test 2 succeded"); 
	else $display("test 2 failed paraty out = %b and paraty = ",parity_out_tb ,paraty_tb) ;
		
    $display(" TEST 3 01 test " );
    #10 parity_type = 2'b01;
    data_in_tb = 8'b00001101;
	
	if (parity_out_tb == 1'b1 && paraty_tb==1'b0 ) $display("test 3 succeded"); 
	else $display("test 3 failed paraty out = %b and paraty = ",parity_out_tb ,paraty_tb) ;


	 $display(" TEST 4 10 test " );
		#10 parity_type = 2'b10;
		data_in_tb = 8'b00001111;
	if (parity_out_tb == 1'b1 && paraty_tb==1'b1 ) $display("test 4 succeded"); 
	else $display("test 4 failed paraty out = %b and paraty = ",parity_out_tb ,paraty_tb) ;
		
		$display(" TEST 5 10 test " );
		#10 parity_type = 2'b10;
		data_in_tb = 8'b00001101;
	if (parity_out_tb == 1'b0 && paraty_tb==1'b0 ) $display("test 5 succeded"); 
	else $display("test 5 failed paraty out = %b and paraty = ",parity_out_tb ,paraty_tb) ;

	   $display(" TEST 6 11 test " );
		#10 parity_type = 2'b11;
		data_in_tb = 8'b00001111;
	if (parity_out_tb == 1'b0 && paraty_tb==1'b1 ) $display("test 6 succeded"); 
	else $display("test 6 failed paraty out = %b and paraty = ",parity_out_tb ,paraty_tb) ;
		
		$display(" TEST 7 11 test " );
		#10 parity_type = 2'b01;
		data_in_tb = 8'b00001101;
	if (parity_out_tb == 1'b1 && paraty_tb==1'b0 ) $display("test 7 succeded"); 
	else $display("test 7 failed paraty out = %b and paraty = ",parity_out_tb ,paraty_tb); $stop;
	
end
endmodule

