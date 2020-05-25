`timescale 1ns / 1ps

module Control(
    input [5:0] opcode,
    output reg alu_src,
    output reg reg_write,
    output reg jump,
    output reg mem_write,
    output reg [3:0] alu_ctrl
    );

    // alu_src = 0 => register input.
    // reg_write = 1 => write to rd.

    always @ *
        case (opcode)
            ADD_opcode : begin
                alu_src = 0;
                reg_write = 1;
                jump = 1;
                mem_write = 0;
                alu_ctrl = ADD_alu_ctrl;
            end

            BGEZ_opcode : begin
                alu_src = 1;
                reg_write = 0;
                jump = 0;
                mem_write = 0;
                alu_ctrl = BGEZ_alu_ctrl;
            end

            ADDI_opcode : begin
                alu_src = 1;
                reg_write = 1;
                jump = 0;
                mem_write = 0;
                alu_ctrl = ADDI_alu_ctrl;
            end

            ADDIU_opcode : begin
                alu_src = 1;
                reg_write = 1;
                jump = 0;
                mem_write = 0;
                alu_ctrl = ADDIU_alu_ctrl;
            end

            ANDI_opcode : begin
                alu_src = 1;
                reg_write = 1;
                jump = 0;
                mem_write = 0;
                alu_ctrl = ANDI_alu_ctrl;
            end

            ORI_opcode : begin
                alu_src = 1;
                reg_write = 1;
                jump = 0;
                mem_write = 0;
                alu_ctrl = ORI_alu_ctrl;
            end

            SLTI_opcode : begin
                alu_src = 1;
                reg_write = 1;
                jump = 0;
                mem_write = 0;
                alu_ctrl = SLTI_alu_ctrl;
            end

            SLTIU_opcode : begin
                alu_src = 1;
                reg_write = 1;
                jump = 0;
                mem_write = 0;
                alu_ctrl = SLTIU_alu_ctrl;
            end

            XORI_opcode : begin
                alu_src = 1;
                reg_write = 1;
                jump = 0;
                mem_write = 0;
                alu_ctrl = XORI_alu_ctrl;
            end

            BEQ_opcode : begin
                alu_src = 1;
                reg_write = 0;
                jump = 0;
                mem_write = 0;
                alu_ctrl = BEQ_alu_ctrl;
            end

            BNE_opcode : begin
                alu_src = 1;
                reg_write = 0;
                jump = 0;
                mem_write = 0;
                alu_ctrl = BNE_alu_ctrl;
            end

            J_opcode : begin
                alu_src = 1'bx;
                reg_write = 0;
                jump = 1;
                mem_write = 0;
                alu_ctrl = 4'bx;
            end

            JAL_opcode : begin
                alu_src = 1'bx;
                reg_write = 1;
                jump = 1;
                mem_write = 0;
                alu_ctrl = 4'bx;
            end

            LB_opcode : begin
                alu_src = 1'bx;
                reg_write = 1;
                jump = 0;
                mem_write = 0;
                alu_ctrl = 4'bx;
            end

            LBU_opcode : begin
                alu_src = 1'bx;
                reg_write = 1;
                jump = 0;
                mem_write = 0;
                alu_ctrl = 4'bx;
            end

            LH_opcode : begin
                alu_src = 1'bx;
                reg_write = 1;
                jump = 0;
                mem_write = 0;
                alu_ctrl = 4'bx;
            end

            LHU_opcode : begin
                alu_src = 1'bx;
                reg_write = 1;
                jump = 0;
                mem_write = 0;
                alu_ctrl = 4'bx;
            end

            LUI_opcode : begin
                alu_src = 1'bx;
                reg_write = 1;
                jump = 0;
                mem_write = 0;
                alu_ctrl = 4'bx;
            end

            LW_opcode : begin
                alu_src = 1'bx;
                reg_write = 1;
                jump = 0;
                mem_write = 0;
                alu_ctrl = 4'bx;
            end

            SB_opcode : begin
                alu_src = 1'bx;
                reg_write = 0;
                jump = 0;
                mem_write = 1;
                alu_ctrl = 4'bx;
            end

            SH_opcode : begin
                alu_src = 1'bx;
                reg_write = 0;
                jump = 0;
                mem_write = 1;
                alu_ctrl = 4'bx;
            end

            SW_opcode : begin
                alu_src = 1'bx;
                reg_write = 0;
                jump = 0;
                mem_write = 1;
                alu_ctrl = 4'bx;
            end

            default : begin
                alu_src = 1'bx;
                reg_write = 1'bx;
                jump = 1'bx;
                mem_write = 1'bx;
                alu_ctrl = 4'bx;
            end
        endcase
endmodule