`include "InvMixColoumn.v"
`include "InvSubByte.v"
`include "InverseShiftRows.v"

module Decryption (
  input [63:0] cipher_text,
  input [63:0] Round_key,
  output [63:0] original_text
);

  wire [63:0] stage0_out;
  wire [63:0] stage1_isr_out, stage1_isb_out, stage1_ark_out, stage1_imc_out;
  wire [63:0] stage2_isr_out, stage2_isb_out, stage2_ark_out, stage2_imc_out;
  wire [63:0] stage3_isr_out, stage3_isb_out, stage3_ark_out, stage3_imc_out;
  wire [63:0] stage4_isr_out, stage4_isb_out, stage4_ark_out, stage4_imc_out;
  wire [63:0] stage5_isr_out, stage5_isb_out, stage5_ark_out, stage5_imc_out;
  wire [63:0] stage6_isr_out, stage6_isb_out, stage6_ark_out, stage6_imc_out;
  wire [63:0] stage7_isr_out, stage7_isb_out, stage7_ark_out, stage7_imc_out;
  wire [63:0] stage8_isr_out, stage8_isb_out, stage8_ark_out;

  // Round 0 - Initial AddRoundKey
  AddRoundKey ark9 (.state(cipher_text), .round_key(Round_key), .out(stage0_out));

  // Round 1
  InverseShiftRows isr1 (.in(stage0_out), .out(stage1_isr_out));
  InvSubByte isb1 (.data(stage1_isr_out), .inv_sub_bytes_data(stage1_isb_out));
  AddRoundKey ark10 (.state(stage1_isb_out), .round_key(Round_key), .out(stage1_ark_out));
  InvMixColoumn imc1 (.data(stage1_ark_out), .inv_mix_coloumns_data(stage1_imc_out));

  // Round 2
  InverseShiftRows isr2 (.in(stage1_imc_out), .out(stage2_isr_out));
  InvSubByte isb2 (.data(stage2_isr_out), .inv_sub_bytes_data(stage2_isb_out));
  AddRoundKey ark11 (.state(stage2_isb_out), .round_key(Round_key), .out(stage2_ark_out));
  InvMixColoumn imc2 (.data(stage2_ark_out), .inv_mix_coloumns_data(stage2_imc_out));

  // Round 3
  InverseShiftRows isr3 (.in(stage2_imc_out), .out(stage3_isr_out));
  InvSubByte isb3 (.data(stage3_isr_out), .inv_sub_bytes_data(stage3_isb_out));
  AddRoundKey ark12 (.state(stage3_isb_out), .round_key(Round_key), .out(stage3_ark_out));
  InvMixColoumn imc3 (.data(stage3_ark_out), .inv_mix_coloumns_data(stage3_imc_out));

  // Round 4
  InverseShiftRows isr4 (.in(stage3_imc_out), .out(stage4_isr_out));
  InvSubByte isb4 (.data(stage4_isr_out), .inv_sub_bytes_data(stage4_isb_out));
  AddRoundKey ark13 (.state(stage4_isb_out), .round_key(Round_key), .out(stage4_ark_out));
  InvMixColoumn imc4 (.data(stage4_ark_out), .inv_mix_coloumns_data(stage4_imc_out));

  // Round 5
  InverseShiftRows isr5 (.in(stage4_imc_out), .out(stage5_isr_out));
  InvSubByte isb5 (.data(stage5_isr_out), .inv_sub_bytes_data(stage5_isb_out));
  AddRoundKey ark14 (.state(stage5_isb_out), .round_key(Round_key), .out(stage5_ark_out));
  InvMixColoumn imc5 (.data(stage5_ark_out), .inv_mix_coloumns_data(stage5_imc_out));

  // Round 6
  InverseShiftRows isr6 (.in(stage5_imc_out), .out(stage6_isr_out));
  InvSubByte isb6 (.data(stage6_isr_out), .inv_sub_bytes_data(stage6_isb_out));
  AddRoundKey ark15 (.state(stage6_isb_out), .round_key(Round_key), .out(stage6_ark_out));
  InvMixColoumn imc6 (.data(stage6_ark_out), .inv_mix_coloumns_data(stage6_imc_out));

  // Round 7
  InverseShiftRows isr7 (.in(stage6_imc_out), .out(stage7_isr_out));
  InvSubByte isb7 (.data(stage7_isr_out), .inv_sub_bytes_data(stage7_isb_out));
  AddRoundKey ark16 (.state(stage7_isb_out), .round_key(Round_key), .out(stage7_ark_out));
  InvMixColoumn imc7 (.data(stage7_ark_out), .inv_mix_coloumns_data(stage7_imc_out));

  // Round 8 - Final round (no InvMixColoumn)
  InverseShiftRows isr8 (.in(stage7_imc_out), .out(stage8_isr_out));
  InvSubByte isb8 (.data(stage8_isr_out), .inv_sub_bytes_data(stage8_isb_out));
  AddRoundKey ark17 (.state(stage8_isb_out), .round_key(Round_key), .out(original_text));

endmodule
