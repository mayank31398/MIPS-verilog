`timescale 1ns / 1ps

module SignExtend(
    input [15:0] x,
    output reg [31:0] y
    );

    always @ *
        if(x[15])
            y = x + 32'hFFFF0000;
        else
            y = x;

endmodule