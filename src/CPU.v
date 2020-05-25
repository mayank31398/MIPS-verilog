`timescale 1ns / 1ps

`include "params.vh"

module CPU(
    input clk
    );
    
    reg [31:0] PC;

    // =========================================================================
    // Instruction memory
    wire [31:0] instruction;
    InstructionMemory instruction_memory(PC, instruction, clk);
    // =========================================================================
    
    wire [5:0] opcode;
    wire [25:0] address_;
    assign {opcode, address_} = instruction;
    
    wire [4:0] rs;
    wire [4:0] rt;
    wire [4:0] shamt;
    wire [5:0] funct;
    wire [15:0] immediate_16;
    wire [25:0] target;
    reg [4:0] rd;
    assign {rs, rt} = address_[25:16];
    assign {shamt, funct} = address_[10:0];
    assign immediate_16 = address_[15:0];
    
    // =========================================================================
    // Control unit
    wire alu_src;
    reg reg_write;
    wire reg_write_;
    wire jump_;
    wire [3:0] alu_ctrl;
    wire mem_write;
    Control control_unit(opcode, alu_src, reg_write_, jump_, mem_write, alu_ctrl);
    // =========================================================================
    
    // =========================================================================
    // Register file
    wire [31:0] read_rs;
    wire [31:0] read_rt;
    reg [31:0] write_rd;
    RegisterFile register_file(rs, rt, rd, write_rd, read_rs, read_rt, reg_write, clk);
    // =========================================================================

    wire [31:0] immediate_32;
    SignExtend sign_extend(immediate_16, immediate_32);

    reg [31:0] alu_inp;
    always @ *
        if(alu_src)
            alu_inp = immediate_32;
        else
            alu_inp = read_rt;
    
    // =========================================================================
    // ALU
    wire [31:0] alu_out;
    wire [4:0] alu_op;
    wire branch_condition;
    ALUControl alu_control(funct, rt, alu_ctrl, alu_op);
    ALU alu(read_rs, alu_inp, shamt, alu_op, alu_out, branch_condition);
    // =========================================================================

    // =========================================================================
    // Data memory
    reg [31:0] data_address;
    wire [31:0] data_out;
    reg [31:0] data_in;
    DataMemory data_memory(data_address, mem_write, data_in, data_out, clk);
    // =========================================================================

    // =========================================================================
    // Program counter update
    reg [31:0] PC_;
    reg jump;
    
    always @ *
        begin
            reg_write = reg_write_;
            jump = jump_;
            PC_ = PC;
            write_rd = alu_out;
            rd = address_[15:11];
            data_address = 32'bx;
            data_in = 32'bx;

            case (opcode)
                J_opcode : PC_ = {PC_[31:28], address_ << 2};

                JAL_opcode : begin
                    rd = 31;
                    write_rd = PC_ + 4;
                    PC_ = {PC_[31:28], address_ << 2};
                end

                LB_opcode : begin
                    data_address = immediate_32 + read_rs;
                    rd = rt;

                    if(data_out[31])
                        write_rd = data_out[31:24] + 0'hFFFFFF00;
                    else
                        write_rd = data_out[31:24];
                end

                LBU_opcode : begin
                    data_address = immediate_32 + read_rs;
                    rd = rt;
                    write_rd = data_out[31:24];
                end

                LH_opcode : begin
                    data_address = immediate_32 + read_rs;
                    rd = rt;

                    if(data_out[31])
                        write_rd = data_out[31:16] + 0'hFFFF0000;
                    else
                        write_rd = data_out[31:16];
                end

                LHU_opcode : begin
                    data_address = immediate_32 + read_rs;
                    rd = rt;
                    write_rd = data_out[31:16];
                end

                LUI_opcode : begin
                    rd = rt;
                    write_rd = immediate_16 << 16;
                end

                LW_opcode : begin
                    data_address = immediate_32 + read_rs;
                    rd = rt;
                    write_rd = data_out;
                end

                SB_opcode : begin
                    data_address = immediate_32 + read_rs;
                    data_in = {read_rt[7:0], data_out[23:0]};
                end

                SH_opcode : begin
                    data_address = immediate_32 + read_rs;
                    data_in = {read_rt[15:0], data_out[15:0]};
                end

                SW_opcode : begin
                    data_address = immediate_32 + read_rs;
                    data_in = read_rt;
                end

                default : begin
                    if(jump)
                        case (funct)
                            JALR_funct : begin
                                write_rd = PC_ + 4;
                                PC_ = read_rs;
                                reg_write = 1;
                            end

                            JR_funct : begin
                                reg_write = 0;
                                PC_ = read_rs;
                            end

                            default : begin
                                write_rd = 32'bx;
                                PC_ = 32'bx;
                                reg_write = 1'bx;
                            end
                        endcase
                    else
                        case (alu_ctrl)
                            BGEZ_alu_ctrl : begin
                                case (alu_op)
                                    BGEZ_alu_op : begin
                                        if(branch_condition)
                                            PC_ = PC_ + (immediate_32 << 2);
                                    end

                                    BGEZAL_alu_op : begin
                                        rd = 31;
                                        reg_write = 1;
                                        write_rd = PC_ + 4;

                                        if(branch_condition)
                                            PC_ = PC_ + (immediate_32 << 2);
                                    end
                                    
                                    BLTZ_alu_op : begin
                                        if(branch_condition)
                                            PC_ = PC_ + (immediate_32 << 2);
                                    end

                                    BLTZAL_alu_op : begin
                                        rd = 31;
                                        reg_write = 1;
                                        write_rd = PC_ + 4;

                                        if(branch_condition)
                                            PC_ = PC_ + (immediate_32 << 2);
                                    end

                                    default : PC_ = 32'bx;
                                endcase
                            end

                            ADDI_alu_ctrl : rd = rt;
                            ADDIU_alu_ctrl : rd = rt;
                            ANDI_alu_ctrl : rd = rt;
                            ORI_alu_ctrl : rd = rt;
                            SLTI_alu_ctrl : rd = rt;
                            SLTIU_alu_ctrl : rd = rt;
                            XORI_alu_ctrl : rd = rt;

                            BEQ_alu_ctrl : begin
                                if(branch_condition)
                                    PC_ = PC_ + (immediate_32 << 2);
                            end

                            BNE_alu_ctrl : begin
                                if(branch_condition)
                                    PC_ = PC_ + (immediate_32 << 2);
                            end

                            default : PC_ = 32'bx;
                        endcase
                end
            endcase
        end
    
    always @ (posedge clk)
        if(branch_condition || jump)
            PC = PC_;
        else
            PC = PC + 4;
    // =========================================================================
endmodule