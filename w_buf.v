module w_buf #(
parameter WIDTH = 32,
parameter DEPTH = 16,
parameter COL = 10,
parameter ADDR_WIDTH = $clog2(DEPTH),
parameter INIT_FILE = "C:/Users/User/Desktop/weight.txt"
)(
input wire clk,
input wire en,
input wire rst_i,
input wire [ADDR_WIDTH - 1:0] addr, //4bit//16
output reg [WIDTH * COL - 1:0] dout
);

reg [WIDTH - 1 :0] mem [0:DEPTH * COL - 1];
integer i;

generate
    if (INIT_FILE != "") begin: use_init_file
             initial
                $readmemh(INIT_FILE, mem, 0, DEPTH * COL -1);
    end
    else begin: init_bram_to_zero
        integer row;
        initial
            for (row = 0; row < DEPTH; row = row + 1)
                    mem[row] = {WIDTH * COL{1'b0}};
    end
endgenerate

always@(posedge clk) begin
    if(!rst_i) begin
            dout <= {WIDTH * COL{1'b0}};
     end
     else begin
        if(en) begin
            for(i = 0; i < DEPTH; i = i + 1) begin
                dout[(i*WIDTH)+:WIDTH] <= mem[addr * COL + (COL - 1 - i)];
            end
        end
        else begin
                dout <= {WIDTH * COL{1'b0}};
        end
    end
end

endmodule
