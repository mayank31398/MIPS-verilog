`timescale 1ns / 1ps

`include "params.vh"

module ALU(
    input [31:0] read_rs,
    input [31:0] read_rt,
    input [4:0] sa,
    input [4:0] alu_op,
    output reg [31:0] write_rd,
    output reg branch_condition
    );

    reg [31:0] tmp;

    wire signed [31:0] rs1;
    wire signed [31:0] rt1;

    assign rs1 = read_rs;
    assign rt1 = read_rt;

    always @ *
        begin
            branch_condition = 0;
            write_rd = 32'bx;

            case (alu_op)
                ADD_alu_op : write_rd = read_rs + read_rt;
                ADDU_alu_op : write_rd = read_rs + read_rt;
                AND_alu_op : write_rd = read_rs & read_rt;
                NOR_alu_op : write_rd = ~(read_rs | read_rt);
                OR_alu_op : write_rd = read_rs | read_rt;
                SLL_alu_op : write_rd = read_rt << sa;
                SLLV_alu_op : write_rd = read_rt << read_rs[4:0];

                SLT_alu_op : begin
                    if(rs1 < rt1)
                        write_rd = 1;
                    else
                        write_rd = 0;
                end
                
                SLTU_alu_op : begin
                    if(read_rs < read_rt)
                        write_rd = 1;
                    else
                        write_rd = 0;
                end

                SRA_alu_op : begin
                    write_rd = read_rt >> sa;
                    if(write_rd[31 - sa])
                        write_rd = ((32'hFFFFFFFF >> (32 - sa)) << (32 - sa)) + write_rd;
                end

                SRAV_alu_op : begin
                    write_rd = read_rt >> read_rs[4:0];
                    if(write_rd[31 - read_rs[4:0]])
                        write_rd = ((32'hFFFFFFFF >> (32 - read_rs[4:0])) << (32 - read_rs[4:0])) + write_rd;
                end

                SUB_alu_op : write_rd = read_rs - read_rt;
                SUBU_alu_op : write_rd = read_rs - read_rt;
                XOR_alu_op : write_rd = read_rs ^ read_rt;

                BGEZ_alu_op : begin
                    if(read_rs[31] == 0)
                        branch_condition = 1;
                end

                BGEZAL_alu_op : begin
                    if(read_rs[31] == 0)
                        branch_condition = 1;
                end

                BLTZ_alu_op : begin
                    if(read_rs[31] == 1)
                        branch_condition = 1;
                end

                BLTZAL_alu_op : begin
                    if(read_rs[31] == 1)
                        branch_condition = 1;
                end

                ANDI_alu_op : begin
                    tmp = read_rt & 32'h0000FFFF;
                    write_rd = read_rs & tmp;
                end

                ORI_alu_op : begin
                    tmp = read_rt & 32'h0000FFFF;
                    write_rd = read_rs | tmp;
                end

                XORI_alu_op : begin
                    tmp = read_rt & 32'h0000FFFF;
                    write_rd = read_rs ^ tmp;
                end

                BEQ_alu_op : begin
                    if(read_rs == read_rt)
                        branch_condition = 1;
                end

                BNE_alu_op : begin
                    if(read_rs != read_rt)
                        branch_condition = 1;
                end

                default : write_rd = 32'bx;
            endcase
        end
endmodule