`timescale 1ns / 1ns

module frame_gen_tb;

  // Inputs
  reg rst;
  reg [7:0] data_in;
  reg [1:0] parity_type;
  reg stop_bits;
  reg data_length;

  // Outputs
  wire [11:0] frame_out;
  wire parity_out;

  // Instantiate the Unit Under Test (UUT)
  frame_gen uut (
    .rst(rst),
    .data_in(data_in),
    .parity_out(parity_out),
    .parity_type(parity_type),
    .stop_bits(stop_bits),
    .data_length(data_length),
    .frame_out(frame_out)
  );

  // Test sequence
  initial begin
  
	// Apply reset
	#10 rst = 0;
	#10 rst = 1;
  
    // Initialize Inputs
    parity_type = 2'b00; // No parity
    stop_bits = 0;       // 1 stop bit
    data_length = 1;     // 8 data bits
	data_in = 8'b10101010;
    

	//1
    $display("Test case 1: No parity, 1 stop bit, 8 data bits: %b", data_in);
	#5
    $display("frame_out = %b, parity_out = %b", frame_out, parity_out); 
	
	#10;
    rst = 0; #5;
    rst = 1; #5;
	
	//2
	parity_type = 2'b01; // Odd parity
    stop_bits = 1;       // 2 stop bits
    data_length = 0;     // 7 data bits
	data_in = 8'b1100110; // New data to be transmitted
    $display("Test case 2: Odd parity, 2 stop bits, 7 data bits: %b", data_in);
	#5
    $display("frame_out = %b, parity_out = %b", frame_out, parity_out); 
	#10;
    rst = 0; #5;
    rst = 1; #5;
	
	
	//3
	parity_type = 2'b10; // Even parity
    stop_bits = 0;       // 1 stop bit
    data_length = 1;     // 8 data bits
	#5 data_in = 8'b01101001; // New data to be transmitted  
    $display("Test case 3: Even parity, 1 stop bit, 8 data bits: %b", data_in);
	#5
    $display("frame_out = %b, parity_out = %b", frame_out, parity_out); 
	#10;
    rst = 0; #5;
    rst = 1; #5;
	
	
	//4
	parity_type = 2'b11; // Use p_parity_out
    stop_bits = 1;       // 2 stop bits
    data_length = 1;     // 8 data bits
	#5 data_in = 8'b11110000; // New data to be transmitted 
    $display("Test case 4: Use p_parity_out, 2 stop bits, 8 data bits: %b", data_in);
	#5
    $display("frame_out = %b, parity_out = %b", frame_out, parity_out); 
	
	#10;
    rst = 0; #5;
    rst = 1; #5;
	
    // End simulation
    #50;
    $stop;
  end

endmodule

