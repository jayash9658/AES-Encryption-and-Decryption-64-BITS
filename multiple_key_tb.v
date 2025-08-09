`timescale 1ns/1ps


module tb_AES_FIFO_unique_keys();

  reg clk, rst;
  reg we, re;
  reg [63:0] data_in;
  reg [63:0] key;

  wire [63:0] encrypted_data;
  wire [63:0] decrypted_data;
  wire match_result;

  integer i;

  reg [63:0] test_data [0:9];
  reg [63:0] test_keys [0:9];

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
    .original_data(data_in),
    .decrypted_data(decrypted_data),
    .match_result(match_result)
  );

  initial clk = 0;
  always #5 clk = ~clk;

  initial begin
    rst = 1; we = 0; re = 0; data_in = 0; key = 0;

    // Generate test packets and keys
    for (i = 0; i < 10; i = i + 1) begin
      test_data[i] = { $urandom, $urandom };
      test_keys[i] = { $urandom, $urandom };
    end

    #20;
    rst = 0;

    // Encryption phase
    for (i = 0; i < 10; i = i + 1) begin
      @(posedge clk);
      data_in = test_data[i];
      key = test_keys[i];
      #1;
      we = 1;
      re = 0;
      @(posedge clk);
      we = 0;
      
      $display("Packet %0d | Original: %016h | Key: %016h | Encrypted: %016h",
               i+1, data_in, key, encrypted_data);
    end

    repeat (5) @(posedge clk);

    // Decryption + Scoreboard check phase
    for (i = 0; i < 10; i = i + 1) begin
      @(posedge clk);
      data_in = test_data[i]; // provide original again for scoreboard
      key = test_keys[i];     // use matching key
      re = 1;
      we = 0;
      @(posedge clk);
      re = 0;

      $display("Packet %0d | Decrypted: %016h | Key Used: %016h | Match: %0d",
               i+1, decrypted_data, key, match_result);
    end

    #20;
    $finish;
  end

endmodule
