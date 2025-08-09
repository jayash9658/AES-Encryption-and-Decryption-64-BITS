 `include"AES_Encrypt.v"
 `include"Decryption.v"
 `include"FIFO.v"
 `include"AddRoundKey.v"
 `include "Scoreboard.v"

module AES(
  input clk,
  input rst,
  input [63:0] data,
  input [63:0] key,
  input we,
  input re,
  output [63:0] encrypt_data,
  output [63:0] decrypt_data
);
  
  wire [63:0] temp1;
  wire [63:0] temp2;
  reg full;
  reg empty;
  
  AES_Encrypt A1( .plaintext(data), .key(key), .ciphertext(temp1));
  
  assign encrypt_data = temp1;
  
  FIFO F1(.clk(clk), .we(we), .re(re), .rst(rst), .data_in(temp1), .data_out(temp2), .full(full), .empty(empty) );
  
  Decryption D1(.cipher_text(temp2), .Round_key(key), .original_text(decrypt_data));
  
    wire match_result;

  Scoreboard SB (.original_data(data_in), .decrypted_data(decrypted_data), .match_result(match_result));
  
  
endmodule
