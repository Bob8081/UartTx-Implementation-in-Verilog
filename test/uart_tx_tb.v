`timescale 1ns / 1ns

module uart_tx_tb;

  // Inputs
  reg clock;
  reg rst;
  reg send;
  reg [1:0] baud_rate;
  reg [7:0] data_in;
  reg [1:0] parity_type;
  reg stop_bits;
  reg data_length;

  // Outputs
  wire data_out;
  wire p_parity_out;
  wire tx_active;
  wire tx_done;

  // Instantiation
  uart_tx dut (
    .clock(clock),
    .rst(rst),
    .send(send),
    .baud_rate(baud_rate),
    .data_in(data_in),
    .parity_type(parity_type),
    .stop_bits(stop_bits),
    .data_length(data_length),
    .data_out(data_out),
    .p_parity_out(p_parity_out),
    .tx_active(tx_active),
    .tx_done(tx_done)
  );

  // Clock generation
  initial begin
    clock = 0;
    forever #10 clock = ~clock; // 50MHz clock
  end

  // Test sequence
  initial begin
    // Initialize Inputs
    rst = 1'b1;
    send = 1'b0;
    baud_rate = 2'b10;       // 9600 baud
    data_in = 8'b10101010;   // Data to be transmitted
    parity_type = 2'b00;     // No parity
    stop_bits = 0;           // 1 stop bit
    data_length = 1;         // 8 data bits

    // Reset the DUT
    #20;
    rst = 1'b0;
	#20
	rst = 1'b1;

    // Test case 1: No parity, 9600 baud, 8 data bits, 1 stop bit
    #100;
    send = 1'b1;
    #100;
    send = 1'b0;

    // Wait for transmission to complete
    wait(tx_done);
	$stop;
	
    // Test case 2: Even parity, 4800 baud, 7 data bits, 2 stop bits
    #100;
    parity_type = 2'b10;     // Even parity
    baud_rate = 2'b01;       // 4800 baud
    data_length = 1'b0;         // 7 data bits
    stop_bits = 1'b1;           // 2 stop bits
    data_in = 8'b1100110;    // New data to be transmitted

    #100;
    send = 1'b1;
    #20;
    send = 1'b0;

    // Wait for transmission to complete
    wait(tx_done);
	$stop;

    // Test case 3: Odd parity, 2400 baud, 8 data bits, 1 stop bit
    #100;
    parity_type = 2'b01;     // Odd parity
    baud_rate = 2'b00;       // 2400 baud
    data_length = 1'b1;         // 8 data bits
    stop_bits = 1'b0;           // 1 stop bit
    data_in = 8'b01101001;   // New data to be transmitted

    #100;
    send = 1'b1;
    #20;
    send = 1'b0;

    // Wait for transmission to complete
    wait(tx_done);
	$stop;
	

    // Test case 4: Use p_parity_out, 19.2K baud, 8 data bits, 2 stop bits
    #100;
    parity_type = 2'b11;     // Use p_parity_out
    baud_rate = 2'b11;       // 19.2K baud
    data_length = 1'b1;         // 8 data bits
    stop_bits = 1'b1;           // 2 stop bits
    data_in = 8'b11110000;   // New data to be transmitted

    #100;
    send = 1'b1;
    #20;
    send = 1'b0;

    // Wait for transmission to complete
    wait(tx_done);

    // End simulation
    #100;
    $stop;
  end

endmodule

