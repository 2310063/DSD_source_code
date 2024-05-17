module relu #( parameter WIDTH = 32,
                parameter DEPTH = 64)
              ( input  wire signed [WIDTH * DEPTH - 1 : 0] buf_data,
                output wire        [WIDTH * DEPTH - 1 : 0] buf_re_data
              );
genvar i;

generate for(i = 0 ; i < DEPTH ; i = i + 1) begin
        assign buf_re_data[WIDTH * i +: WIDTH] = ( buf_data[WIDTH * i] ) ? { WIDTH { 1'b0 } } :  buf_data[WIDTH * i +: WIDTH] ;
    end
endgenerate
endmodule