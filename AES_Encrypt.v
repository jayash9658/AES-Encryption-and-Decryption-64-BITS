 `include"sub_bytes.v"
 `include"ShiftRows.v"
 `include"Mix_coloumns.v"


module AES_Encrypt (
    input [63:0] plaintext,
    input [63:0] key,
    output [63:0] ciphertext
);

    wire [63:0] stage0_out;
    wire [63:0] stage1_sb_out, stage1_sr_out, stage1_ark_out, stage1_mc_out;
    wire [63:0] stage2_sb_out, stage2_sr_out, stage2_ark_out, stage2_mc_out;
    wire [63:0] stage3_sb_out, stage3_sr_out, stage3_ark_out, stage3_mc_out;
    wire [63:0] stage4_sb_out, stage4_sr_out, stage4_ark_out, stage4_mc_out;
    wire [63:0] stage5_sb_out, stage5_sr_out, stage5_ark_out, stage5_mc_out;
    wire [63:0] stage6_sb_out, stage6_sr_out, stage6_ark_out, stage6_mc_out;
    wire [63:0] stage7_sb_out, stage7_sr_out, stage7_ark_out, stage7_mc_out;
    wire [63:0] stage8_sb_out, stage8_sr_out, stage8_ark_out;

    // Round 0 - Initial AddRoundKey
    AddRoundKey ark0 (.state(plaintext), .round_key(key), .out(stage0_out));

    // Round 1
    SubBytes sb1 (.data(stage0_out), .sub_bytes_data(stage1_sb_out));
    ShiftRows sr1 (.in(stage1_sb_out), .out(stage1_sr_out));
    mix_coloumns mc1 (.data(stage1_sr_out), .mix_coloumns_data(stage1_mc_out));
    AddRoundKey ark1 (.state(stage1_mc_out), .round_key(key), .out(stage1_ark_out));

    // Round 2
    SubBytes sb2 (.data(stage1_ark_out), .sub_bytes_data(stage2_sb_out));
    ShiftRows sr2 (.in(stage2_sb_out), .out(stage2_sr_out));
    mix_coloumns mc2 (.data(stage2_sr_out),  .mix_coloumns_data(stage2_mc_out));
    AddRoundKey ark2 (.state(stage2_mc_out), .round_key(key), .out(stage2_ark_out));

    // Round 3
    SubBytes sb3 (.data(stage2_ark_out), .sub_bytes_data(stage3_sb_out));
    ShiftRows sr3 (.in(stage3_sb_out), .out(stage3_sr_out));
    mix_coloumns mc3 (.data(stage3_sr_out),  .mix_coloumns_data(stage3_mc_out));
    AddRoundKey ark3 (.state(stage3_mc_out), .round_key(key), .out(stage3_ark_out));

    // Round 4
    SubBytes sb4 (.data(stage3_ark_out), .sub_bytes_data(stage4_sb_out));
    ShiftRows sr4 (.in(stage4_sb_out), .out(stage4_sr_out));
    mix_coloumns mc4 (.data(stage4_sr_out),  .mix_coloumns_data(stage4_mc_out));
    AddRoundKey ark4 (.state(stage4_mc_out), .round_key(key), .out(stage4_ark_out));

    // Round 5
    SubBytes sb5 (.data(stage4_ark_out), .sub_bytes_data(stage5_sb_out));
    ShiftRows sr5 (.in(stage5_sb_out), .out(stage5_sr_out));
    mix_coloumns mc5 (.data(stage5_sr_out),  .mix_coloumns_data(stage5_mc_out));
    AddRoundKey ark5 (.state(stage5_mc_out), .round_key(key), .out(stage5_ark_out));

    // Round 6
    SubBytes sb6 (.data(stage5_ark_out), .sub_bytes_data(stage6_sb_out));
    ShiftRows sr6 (.in(stage6_sb_out), .out(stage6_sr_out));
    mix_coloumns mc6 (.data(stage6_sr_out),  .mix_coloumns_data(stage6_mc_out));
    AddRoundKey ark6 (.state(stage6_mc_out), .round_key(key), .out(stage6_ark_out));

    // Round 7
    SubBytes sb7 (.data(stage6_ark_out), .sub_bytes_data(stage7_sb_out));
    ShiftRows sr7 (.in(stage7_sb_out), .out(stage7_sr_out));
    mix_coloumns mc7 (.data(stage7_sr_out),  .mix_coloumns_data(stage7_mc_out));
    AddRoundKey ark7 (.state(stage7_mc_out), .round_key(key), .out(stage7_ark_out));

    // Round 8 - Final round (no MixColumns)
    SubBytes sb8 (.data(stage7_ark_out), .sub_bytes_data(stage8_sb_out));
    ShiftRows sr8 (.in(stage8_sb_out), .out(stage8_sr_out));
    AddRoundKey ark8 (.state(stage8_sr_out), .round_key(key), .out(stage8_ark_out));

    // Output
    assign ciphertext = stage8_ark_out;

endmodule
