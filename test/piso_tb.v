`timescale 1ns / 1ns

module piso_tb;

  // Inputs
  reg [11:0] frame_out;
  reg [1:0]  parity_type;
  reg stop_bits;
  reg data_length;
  reg send;
  reg baud_out;
  reg rst;

  // Outputs
  wire data_out;
  wire P_parity_out;
  wire tx_active;
  wire tx_done;

  // Instantiation
  piso dut (
    .frame_out(frame_out),
    .parity_type(parity_type),
    .stop_bits(stop_bits),
    .data_length(data_length),
    .send(send),
    .baud_out(baud_out),
    .rst(rst),
    .data_out(data_out),
    .P_parity_out(P_parity_out),
    .tx_active(tx_active),
    .tx_done(tx_done)
  );

  // Clock generation
  always #5 baud_out = ~baud_out;

  // Test sequence
  initial begin
  
	// Apply reset
    rst = 0;
    #10 rst = 1;
	
    // Initialize Inputs
    frame_out = 11'b10101010101; // Example frame 
    parity_type = 2'b00; // No parity
    stop_bits = 0;       // 1 stop bit
    data_length = 1;     // 8 data bits
    send = 0;
    baud_out = 0;

    

    // Test case 1: No parity, 1 stop bit, 8 data bits
	$display("Test Case 1: %b", frame_out);
    send = 1;
    wait(tx_done);
    send = 0;
    #20;
	
    // Test case 2: Odd parity, 2 stop bits, 7 data bits
	rst = 0; #5;
    rst = 1; #5;
    parity_type = 2'b01; // Odd parity
    stop_bits = 1;       // 2 stop bits
    data_length = 0;     // 7 data bits
    frame_out = 11'b11001100110; // New frame
	$display("Test Case 2: %b", frame_out);
    #10;
	
    send = 1;
    wait(tx_done);
    send = 0;
    #20;

    // Test case 3: Even parity, 1 stop bit, 8 data bits
	rst = 0; #5;
    rst = 1; #5;
    parity_type = 2'b10; // Even parity
    stop_bits = 0;       // 1 stop bit
    data_length = 1;     // 8 data bits
    frame_out = 11'b01101011010; // New frame
	$display("Test Case 3: %b", frame_out);
    #10;
    send = 1;
    wait(tx_done);
    send = 0;
    #20;

    // Test case 4: Use p_parity_out, 2 stop bits, 8 data bits
	rst = 0; #5;
    rst = 1; #5;
    parity_type = 2'b11; // Use p_parity_out
    stop_bits = 1;       // 2 stop bits
    data_length = 1;     // 8 data bits
    frame_out = 11'b11110011110; // New frame
	$display("Test Case 4: %b", frame_out);
    #10;
    send = 1;
    wait(tx_done);
    send = 0;
    #20;

    // End simulation
    #50;
    $stop;
  end

  // Monitor the outputs
  initial begin
    $monitor("Time = %0t : data_out = %b, P_parity_out = %b, tx_active = %b, tx_done = %b", $time, data_out, P_parity_out, tx_active, tx_done);
  end

endmodule

