module InverseShiftRows (
    input  [63:0] in,
    output [63:0] out
);
    wire [7:0] state [0:7];
    wire [7:0] inv_shifted [0:7];

    assign state[0] = in[63:56];
    assign state[1] = in[55:48];
    assign state[2] = in[47:40];
    assign state[3] = in[39:32];
    assign state[4] = in[31:24];
    assign state[5] = in[23:16];
    assign state[6] = in[15:8];
    assign state[7] = in[7:0];

    // Row 0 
    assign inv_shifted[0] = state[0];
    assign inv_shifted[1] = state[1];

    // Row 1 
    assign inv_shifted[2] = state[3];
    assign inv_shifted[3] = state[2];

    // Row 2 
    assign inv_shifted[4] = state[4];
    assign inv_shifted[5] = state[5];

    // Row 3 
    assign inv_shifted[6] = state[7];
    assign inv_shifted[7] = state[6];

    //output
    assign out = {inv_shifted[0], inv_shifted[1], inv_shifted[2], inv_shifted[3],
                  inv_shifted[4], inv_shifted[5], inv_shifted[6], inv_shifted[7]};
endmodule
