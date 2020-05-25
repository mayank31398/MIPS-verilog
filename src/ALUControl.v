`timescale 1ns / 1ps

`include "params.vh"

module ALUControl(
    input [5:0] funct,
    input [4:0] branch_op,
    input [3:0] alu_ctrl,
    output reg [4:0] alu_op
    );

    always @ *
        case (alu_ctrl)
            ADD_alu_ctrl : begin
                case (funct)
                    ADD_funct : alu_op = ADD_alu_op;
                    ADDU_funct : alu_op = ADDU_alu_op;
                    AND_funct : alu_op = AND_alu_op;
                    NOR_funct : alu_op = NOR_alu_op;
                    OR_funct : alu_op = OR_alu_op;
                    SLL_funct : alu_op = SLL_alu_op;
                    SLLV_funct : alu_op = SLLV_alu_op;
                    SLT_funct : alu_op = SLT_alu_op;
                    SLTU_funct : alu_op = SLTU_alu_op;
                    SRA_funct : alu_op = SRA_alu_op;
                    SRAV_funct : alu_op = SRAV_alu_op;
                    SUB_funct : alu_op = SUB_alu_op;
                    SUBU_funct : alu_op = SUBU_alu_op;
                    XOR_funct : alu_op = XOR_alu_op;
                    default : alu_op = 5'bx;
                endcase
            end

            BGEZ_alu_ctrl : begin
                case (branch_op)
                    BGEZ_branch : alu_op = BGEZ_alu_op;
                    BGEZAL_branch : alu_op = BGEZAL_alu_op;
                    BLTZ_branch : alu_op = BLTZ_alu_op;
                    BLTZAL_branch : alu_op = BLTZAL_alu_op;
                    default : alu_op = 5'bx;
                endcase
            end

            ADDI_alu_ctrl : alu_op = ADD_alu_op;
            ADDIU_alu_ctrl : alu_op = ADD_alu_op;
            ANDI_alu_ctrl : alu_op = ANDI_alu_op;
            ORI_alu_ctrl : alu_op = ORI_alu_op;
            SLTI_alu_ctrl : alu_op = SLT_alu_op;
            SLTIU_alu_ctrl : alu_op = SLTU_alu_op;
            XORI_alu_ctrl : alu_op = XORI_alu_op;
            BEQ_alu_ctrl : alu_op = BEQ_alu_op;
            BNE_alu_ctrl : alu_op = BNE_alu_op;

            default : alu_op = 5'bx;
        endcase
endmodule