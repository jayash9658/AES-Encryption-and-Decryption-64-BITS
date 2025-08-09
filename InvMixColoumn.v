module InvMixColoumn(
  input [63:0] data,
  output [63:0] inv_mix_coloumns_data
);
  wire [7:0] in_data [7:0];
  reg [7:0] out_data [7:0];
  
  reg [7:0] temp1, temp2;
  
  integer i;
  
  
  assign in_data[0] = data[7:0];
  assign in_data[1] = data[15:8];
  assign in_data[2] = data[23:16];
  assign in_data[3] = data[31:24];
  assign in_data[4] = data[39:32];
  assign in_data[5] = data[47:40];
  assign in_data[6] = data[55:48];
  assign in_data[7] = data[63:56];
  
  always @(*) begin
  
  for (i = 0; i < 4; i = i + 1) begin
    
    temp1 = (in_data[i+4][7]) ? ((in_data[i+4] << 1) ^ 8'h1B) : (in_data[i+4] << 1);
    temp2 = ((in_data[i+4][7]) ? ((in_data[i+4] << 1) ^ 8'h1B) : (in_data[i+4] << 1)) ^ in_data[i+4];
    
    out_data[i]   <= in_data[i] ^ temp2;
    out_data[i+4] <= in_data[i] ^ temp1;
    
  end
end

  
  
  assign inv_mix_coloumns_data[7:0] = out_data[0];
  assign inv_mix_coloumns_data[15:8] = out_data[1];
  assign inv_mix_coloumns_data[23:16] = out_data[2];
  assign inv_mix_coloumns_data[31:24] = out_data[3];
  assign inv_mix_coloumns_data[39:32] = out_data[4];
  assign inv_mix_coloumns_data[47:40] = out_data[5];
  assign inv_mix_coloumns_data[55:48] = out_data[6];
  assign inv_mix_coloumns_data[63:56] = out_data[7];
  
  
endmodule
