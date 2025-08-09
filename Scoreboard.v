module Scoreboard (
  input  [63:0] original_data,
  input  [63:0] decrypted_data,
  output        match_result
);

  assign match_result = (original_data == decrypted_data) ? 1'b1 : 1'b0;

endmodule
