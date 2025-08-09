`timescale 1ns/1ps

module tb_AES_FIFO_unique_keys();
  
  reg clk, rst;
  reg we, re;
  reg [63:0] data_in;
  reg [63:0] key;

  wire [63:0] encrypted_data;
  wire [63:0] decrypted_data;

  wire match_result; // From scoreboard

  integer i;

  reg [63:0] test_data [0:9];
  reg [63:0] decrypted_store [0:9];  // store decrypted values
  reg [31:0] seed;

  AES uut (
    .clk(clk),
    .rst(rst),
    .data(data_in),
    .key(key),
    .we(we),
    .re(re),
    .encrypt_data(encrypted_data),
    .decrypt_data(decrypted_data)
  );

  Scoreboard sb (
    .original_data(test_data[i]),
    .decrypted_data(decrypted_store[i]),
    .match_result(match_result)
  );

  initial clk = 0;
  always #5 clk = ~clk;

  initial begin
    rst = 1; we = 0; re = 0; data_in = 0; key = 0;

    // Key generation
    key = {$random(seed), $random(seed)};

    // Packet generation
    for (i = 0; i < 10; i = i + 1) begin
      test_data[i] = { $random(seed), $random(seed) };
    end

    #20;
    rst = 0;

    // Write encrypted data into FIFO
    for (i = 0; i < 10; i = i + 1) begin
      @(posedge clk);
      data_in = test_data[i];
      #1;
      we = 1; re = 0;
      @(posedge clk);
      we = 0;

      $display("Packet %0d | Original: %016h | Key: %016h | Encrypted: %016h", i+1, data_in, key, encrypted_data);
    end

    repeat (5) @(posedge clk);

    // Read decrypted data and compare
    for (i = 0; i < 10; i = i + 1) begin
      @(posedge clk);
      re = 1; we = 0;
      @(posedge clk);
      decrypted_store[i] = decrypted_data;  // store decrypted output
      re = 0;

      #1;
      if (match_result)
        $display("Packet %0d | Decrypted: %016h |  Matched", i+1, decrypted_store[i]);
      else
        $display("Packet %0d | Decrypted: %016h |  Not Matched", i+1, decrypted_store[i]);
    end

    #20;
    $finish;
  end

endmodule
