`timescale 1ns / 1ps

module RegisterFile(
    input [4:0] rs,
    input [4:0] rt,
    input [4:0] rd,
    input [31:0] write_rd,
    output [31:0] read_rs,
    output [31:0] read_rt,
    input reg_write,
    input clk
    );
    
    reg [31:0] registers [0:31];
    
    // Initialize registers
    
    assign read_rs = registers[rs];
    assign read_rt = registers[rt];

    always @ (posedge clk)
        if(reg_write)
            registers[rd] = write_rd;
    
endmodule