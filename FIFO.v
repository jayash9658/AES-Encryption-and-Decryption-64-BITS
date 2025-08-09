module FIFO
  #(parameter depth = 32,
    parameter width = 64,
    parameter ptr_width = 5)
  (
    input clk,
    input we,
    input re,
    input rst,
    input [width-1 : 0] data_in,
    output [width-1 : 0] data_out,  // remove reg here
    output reg full,
    output reg empty
  );

  reg [width-1 : 0] fifo_mem [0:depth-1];
  reg [ptr_width-1 : 0] write_ptr;
  reg [ptr_width-1 : 0] read_ptr;
  reg [ptr_width:0] count;
  
  integer i;

  // Combinational data_out assignment
  assign data_out = (!empty) ? fifo_mem[read_ptr] : 64'd0;

  always @(posedge clk or posedge rst) begin
    if(rst) begin
      write_ptr <= 0;
      read_ptr <= 0;
      count <= 0;
      full <= 0;
      empty <= 1;
      for(i=0; i<depth; i=i+1)
        fifo_mem[i] <= 0;
    end
    else begin
      // Write operation
      if(we && !full) begin
        fifo_mem[write_ptr] <= data_in;
        write_ptr <= (write_ptr + 1) % depth;
        count <= count + 1;
      end

      // Read operation
      if(re && !empty) begin
        read_ptr <= (read_ptr + 1) % depth; // increment pointer only
        count <= count - 1;
      end

      // Update flags
      full <= (count == depth);
      empty <= (count == 0);
    end
  end

endmodule
