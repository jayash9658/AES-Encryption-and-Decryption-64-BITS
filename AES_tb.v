`timescale 1ns / 1ps

module AES_tb;

  reg clk;
  reg rst;
  reg we;
  reg re;
  reg [63:0] data;
  reg [63:0] key;
  wire [63:0] encrypt_data;
  wire [63:0] decrypt_data;

  // Instantiate your AES module
  AES uut (
    .clk(clk),
    .rst(rst),
    .data(data),
    .key(key),
    .we(we),
    .re(re),
    .encrypt_data(encrypt_data),
    .decrypt_data(decrypt_data)
  );

  // Clock generation
  initial begin
    clk = 0;
    forever #5 clk = ~clk;
  end

  integer i;

  initial begin
    // Dump for waveform viewing
    $dumpfile("AES_tb.vcd");
    $dumpvars(0, AES_tb);

    // Initialize signals
    rst = 1;
    we = 0;
    re = 0;
    data = 0;
    key = 64'h0F0E0D0C0B0A0908; // Example fixed key

    // Reset for a few cycles
    #12;
    rst = 0;

    // Write 10 data values to encryption and FIFO
    for(i=0; i<10; i=i+1) begin
      @(posedge clk);
      data = i + 1; // Data: 1,2,3...
      we = 1;

      @(posedge clk);
      we = 0;

      // Display encrypted data immediately after writing
      $display("Encrypted data %0d: %h", i+1, encrypt_data);
    end

    // Wait a few cycles before reading back
    repeat(5) @(posedge clk);

    // Read back and decrypt the 10 data values
    for(i=0; i<10; i=i+1) begin
      @(posedge clk);
      re = 1;

      @(posedge clk);
      re = 0;

      // Display decrypted data
      $display("Decrypted data %0d: %h", i+1, decrypt_data);
    end

    // Finish simulation
    #20;
    $finish;
  end

endmodule
