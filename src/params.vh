`ifndef _params_h

`define _params_h

// =============================================================================
// opcode = 6'b000000
parameter [5:0] ADD_opcode = 6'b000000;
parameter [3:0] ADD_alu_ctrl = 0;

parameter [5:0] ADD_funct = 6'b100000;
parameter [4:0] ADD_alu_op = 0;

parameter [5:0] ADDU_funct = 6'b100001;
parameter [4:0] ADDU_alu_op = 1;

parameter [5:0] AND_funct = 6'b100100;
parameter [4:0] AND_alu_op = 2;

parameter [5:0] NOR_funct = 6'b100111;
parameter [4:0] NOR_alu_op = 3;

parameter [5:0] OR_funct = 6'b100101;
parameter [4:0] OR_alu_op = 4;

parameter [5:0] SLL_funct = 6'b000000;
parameter [4:0] SLL_alu_op = 5;

parameter [5:0] SLLV_funct = 6'b000100;
parameter [4:0] SLLV_alu_op = 6;

parameter [5:0] SLT_funct = 6'b101010;
parameter [4:0] SLT_alu_op = 7;

parameter [5:0] SLTU_funct = 6'b101011;
parameter [4:0] SLTU_alu_op = 8;

parameter [5:0] SRA_funct = 6'b000011;
parameter [4:0] SRA_alu_op = 9;

parameter [5:0] SRAV_funct = 6'b000111;
parameter [4:0] SRAV_alu_op = 10;

parameter [5:0] SUB_funct = 6'b100010;
parameter [4:0] SUB_alu_op = 11;

parameter [5:0] SUBU_funct = 6'b100011;
parameter [4:0] SUBU_alu_op = 12;

parameter [5:0] XOR_funct = 6'b100110;
parameter [4:0] XOR_alu_op = 13;

parameter [5:0] JALR_opcode = 6'b000000;
parameter [5:0] JALR_funct = 6'b001001;

parameter [5:0] JR_opcode = 6'b000000;
parameter [5:0] JR_funct = 6'b001000;
// =============================================================================

// =============================================================================
// opcode = 6'b000001
parameter [5:0] BGEZ_opcode = 6'b000001;
parameter [3:0] BGEZ_alu_ctrl = 1;

parameter [4:0] BGEZ_branch = 5'b00001;
parameter [4:0] BGEZ_alu_op = 14;

parameter [4:0] BGEZAL_branch = 5'b10001;
parameter [4:0] BGEZAL_alu_op = 15;

parameter [4:0] BLTZ_branch = 5'b00000;
parameter [4:0] BLTZ_alu_op = 16;

parameter [4:0] BLTZAL_branch = 5'b10000;
parameter [4:0] BLTZAL_alu_op = 17;
// =============================================================================

// =============================================================================
// other opcodes
parameter [5:0] ADDI_opcode = 6'b001000;
parameter [3:0] ADDI_alu_ctrl = 2;

parameter [5:0] ADDIU_opcode = 6'b001001;
parameter [3:0] ADDIU_alu_ctrl = 3;

parameter [5:0] ANDI_opcode = 6'b001100;
parameter [3:0] ANDI_alu_ctrl = 4;
parameter [4:0] ANDI_alu_op = 18;

parameter [5:0] ORI_opcode = 6'b001101;
parameter [3:0] ORI_alu_ctrl = 5;
parameter [4:0] ORI_alu_op = 19;

parameter [5:0] SLTI_opcode = 6'b001010;
parameter [3:0] SLTI_alu_ctrl = 6;

parameter [5:0] SLTIU_opcode = 6'b001011;
parameter [3:0] SLTIU_alu_ctrl = 7;

parameter [5:0] XORI_opcode = 6'b001110;
parameter [3:0] XORI_alu_ctrl = 8;
parameter [4:0] XORI_alu_op = 20;

parameter [5:0] BEQ_opcode = 6'b000100;
parameter [3:0] BEQ_alu_ctrl = 9;
parameter [4:0] BEQ_alu_op = 21;

parameter [5:0] BNE_opcode = 6'b000101;
parameter [3:0] BNE_alu_ctrl = 10;
parameter [4:0] BNE_alu_op = 22;

parameter [5:0] J_opcode = 6'b000010;

parameter [5:0] JAL_opcode = 6'b000011;

parameter [5:0] LB_opcode = 6'b100000;

parameter [5:0] LBU_opcode = 6'b100100;

parameter [5:0] LH_opcode = 6'b100001;

parameter [5:0] LHU_opcode = 6'b100101;

parameter [5:0] LUI_opcode = 6'b001111;

parameter [5:0] LW_opcode = 6'b100011;

parameter [5:0] SB_opcode = 6'b101000;

parameter [5:0] SH_opcode = 6'b101001;

parameter [5:0] SW_opcode = 6'b101011;
// =============================================================================
`endif