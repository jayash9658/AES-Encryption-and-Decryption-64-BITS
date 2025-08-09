`timescale 1ns / 1ps

module FIFO_tb;

  parameter depth = 32;
  parameter width = 64;
  parameter ptr_width = 5;

  reg clk;
  reg rst;
  reg we;
  reg re;
  reg [width-1:0] data_in;
  wire [width-1:0] data_out;
  wire full;
  wire empty;

  // Instantiate your FIFO
  FIFO #(depth, width, ptr_width) uut (
    .clk(clk),
    .we(we),
    .re(re),
    .rst(rst),
    .data_in(data_in),
    .data_out(data_out),
    .full(full),
    .empty(empty)
  );

  // Clock generation: 10ns period
  initial begin
    clk = 0;
    forever #5 clk = ~clk;
  end

  // Test sequence
  initial begin
    // Initialize inputs
    rst = 1;
    we = 0;
    re = 0;
    data_in = 0;

    // Dumpfile and dumpvars for GTKWave viewing
    $dumpfile("fifo_tb.vcd");
    $dumpvars(0, FIFO_tb);

    // Reset the FIFO
    #12; // Ensure reset covers a posedge clk
    rst = 0;

    // Write some data into FIFO
    repeat (5) begin
      @(posedge clk);
      we = 1;
      data_in = data_in + 10; // Incrementing data for clarity
    end

    @(posedge clk);
    we = 0; // Stop writing

    // Wait for a few cycles
    repeat (2) @(posedge clk);

    // Read data from FIFO
    repeat (5) begin
      @(posedge clk);
      re = 1;
    end

    @(posedge clk);
    re = 0; // Stop reading

    // Finish simulation after some time
    #20;
    $finish;
  end

  // Monitor to observe data in terminal
  initial begin
    $monitor("Time=%0t | rst=%b we=%b re=%b data_in=%h data_out=%h full=%b empty=%b write_ptr=%d read_ptr=%d count=%d", 
              $time, rst, we, re, data_in, data_out, full, empty, uut.write_ptr, uut.read_ptr, uut.count);
  end

endmodule
