`timescale 1ns/1ns

module baud_gen_tb ();

parameter clk = 20;

reg clk_tb;
reg rst_tb;
reg [1:0] buad_rate_tb;
wire baud_out_tb;

always #(clk/2) clk_tb = ~clk_tb;

initial begin
    initialize();
    reset();

    ////////////////// Test case 1 2400 baud ///////////////////////
    baud_gen_config(2'b00);
   // #(clk)
    chk_baud_out(2'b00, 1'd1);
    #(clk)

    ////////////////// Test case 2 4600 baud ///////////////////////
    baud_gen_config(2'b01);
    //#(clk)
    chk_baud_out(2'b01, 2'd2);
    #(clk)

    ////////////////// Test case 3 9600 baud ///////////////////////
    baud_gen_config(2'b10);
    //#(clk)
    chk_baud_out(2'b10, 2'd3);
    #(clk)

    ////////////////// Test case 4 19200 baud ///////////////////////
    baud_gen_config(2'b11);
    //#(clk)
    chk_baud_out(2'b11, 3'd4);
    #(3 * clk)
    $stop;
end

task initialize;
    begin
        clk_tb = 1'b0;
        rst_tb = 1'b1;
        buad_rate_tb = 2'b00;
    end
endtask 

task reset;
    begin
        #(clk)
        rst_tb = 1'b0;          
        #(clk)
        rst_tb = 1'b1;
        #(clk);
    end
endtask 

task baud_gen_config;
    input [1:0] baud_rate;
    begin
        buad_rate_tb = baud_rate;
    end
endtask 

task chk_baud_out;
    input [1:0] baud_rate;
    input [2:0] test_case;
    reg expected_out;
    reg chk;
    begin
        expected_out = 1'b1;
        case (baud_rate)
            2'b00: begin
                #(13003 * clk)
                @(negedge clk_tb)
                if (baud_out_tb == expected_out)
                    chk = 1'b1;
                else
                    chk = 1'b0; 
            end
            2'b01: begin
                #(651 * clk)
                @(negedge clk_tb)
                if (baud_out_tb == expected_out)
                    chk = 1'b1;
                else
                    chk = 1'b0; 
            end
            2'b10: begin
                #(326 * clk)
                @(negedge clk_tb)
                if (baud_out_tb == expected_out)
                    chk = 1'b1;
                else
                    chk = 1'b0; 
            end
            2'b11: begin
                #(162 * clk)
                @(negedge clk_tb)
                if (baud_out_tb == expected_out)
                    chk = 1'b1;
                else
                    chk = 1'b0;
            end
        endcase
        if (chk == 1'b1)
            $display("test %d passed successfully", test_case);
        else
            $display("test %d failed", test_case);
    end
endtask 

baud_gen DUT (
    .clock(clk_tb),
    .rst(rst_tb),
    .baud_rate(buad_rate_tb),
    .baud_out(baud_out_tb)
    );
endmodule
