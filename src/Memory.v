`timescale 1ns / 1ps

module InstructionMemory(
    input [31:0] address,
    output reg [31:0] data,
    input clk
    );

    reg [31:0] memory [0:63];
    
    always @ (posedge clk)
        data = memory[address >> 2];

endmodule

module DataMemory(
    input [31:0] address,
    input mem_write,
    input [31:0] data_in,
    output reg [31:0] data_out,
    input clk
    );

    reg [7:0] memory [0:63];
    
    always @ (posedge clk)
        begin
            data_out = {memory[address], memory[address + 1], memory[address + 2], memory[address] + 3};

            if(mem_write)
                begin
                    memory[address] = data_in[31:24];
                    memory[address + 1] = data_in[23:16];
                    memory[address + 2] = data_in[15:8];
                    memory[address + 3] = data_in[7:0];
                end
        end

endmodule