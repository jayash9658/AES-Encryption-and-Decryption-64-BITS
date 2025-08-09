module ShiftRows (
    input  [63:0] in,
    output [63:0] out
);
    wire [7:0] state [0:7];
    wire [7:0] shifted [0:7];

   
    assign state[0] = in[63:56];
    assign state[1] = in[55:48];
    assign state[2] = in[47:40];
    assign state[3] = in[39:32];
    assign state[4] = in[31:24];
    assign state[5] = in[23:16];
    assign state[6] = in[15:8];
    assign state[7] = in[7:0];

   
    assign shifted[0] = state[0];
    assign shifted[1] = state[1];

    
    assign shifted[2] = state[3];
    assign shifted[3] = state[2];

   
    assign shifted[4] = state[4];
    assign shifted[5] = state[5];

    
    assign shifted[6] = state[7];
    assign shifted[7] = state[6];

   
    assign out = {shifted[0], shifted[1], shifted[2], shifted[3],
                  shifted[4], shifted[5], shifted[6], shifted[7]};
endmodule
