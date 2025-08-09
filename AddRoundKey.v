module AddRoundKey (
    input  [63:0] state,       
    input  [63:0] round_key,    
    output [63:0] out     
     );
    assign out = state ^ round_key;
endmodule
