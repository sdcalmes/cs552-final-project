module id_ex(id_alu_res_sel, id_branch, id_branch_eqz, id_branch_gtz,
        id_branch_ltz, id_Cin, id_invA, id_invB, id_memEn, id_memWrite,
        id_regWrite, id_sign_alu, id_createdump, id_ALUSrc_a, id_ALUSrc_b,
        id_memToReg, id_pc_dec, id_set_select, id_alu_op, id_write_reg,
        id_reg1_data, id_reg2_data, id_sign_ext_low_bits, id_instruction,
        id_pc_plus, id_halt, ex_alu_res_sel, ex_branch, ex_branch_eqz, ex_branch_gtz,
        ex_branch_ltz, ex_Cin, ex_invA, ex_invB, ex_memEn, ex_memWrite,
        ex_regWrite, ex_sign_alu,ex_createdump, ex_ALUSrc_a, ex_ALUSrc_b,
        ex_memToReg, ex_pc_dec, ex_set_select, ex_alu_op, ex_write_reg,
        ex_instruction, ex_pc_plus, ex_reg1_data, ex_reg2_data,
        ex_sign_ext_low_bits, ex_halt, clk, rst, flop_stall,
        id_rs_valid, id_rt_valid, ex_rs_valid, ex_rt_valid, id_reg1_sel, id_reg2_sel,
	ex_reg1_sel, ex_reg2_sel);

    input id_alu_res_sel, id_branch, id_branch_eqz, id_branch_gtz, id_branch_ltz,
          id_Cin, id_invA, id_invB, id_memEn, id_memWrite, id_regWrite,
          id_sign_alu, id_createdump, id_halt, clk, rst, flop_stall, id_rs_valid,
	  id_rt_valid;
    input [1:0] id_ALUSrc_a, id_ALUSrc_b, id_memToReg, id_pc_dec, id_set_select;
    input [2:0] id_alu_op, id_write_reg, id_reg1_sel, id_reg2_sel;
    input [15:0] id_instruction, id_pc_plus, id_reg1_data, id_reg2_data,
          id_sign_ext_low_bits;
    
    output ex_alu_res_sel, ex_branch, ex_branch_eqz, ex_branch_gtz,
           ex_branch_ltz, ex_Cin, ex_invA, ex_invB, ex_memEn, ex_memWrite,
           ex_regWrite, ex_sign_alu, ex_createdump, ex_halt, ex_rs_valid,
	   ex_rt_valid;
    output [1:0] ex_ALUSrc_a, ex_ALUSrc_b, ex_memToReg, ex_pc_dec, ex_set_select;
    output [2:0] ex_alu_op, ex_write_reg, ex_reg2_sel, ex_reg1_sel;
    output [15:0] ex_instruction, ex_pc_plus, ex_reg1_data, ex_reg2_data,
            ex_sign_ext_low_bits;


    reg_1 reg1_valid_flop(
        .WriteData(id_rs_valid),
	.ReadData(ex_rs_valid),
	.WriteSel(flop_stall),
	.clk(clk),
	.rst(rst)
    );
    reg_1 reg2_valid_flop(
        .WriteData(id_rt_valid),
	.ReadData(ex_rt_valid),
	.WriteSel(flop_stall),
	.clk(clk),
	.rst(rst)
    );
    reg_1 alu_res_sel_flop(
        .WriteData(id_alu_res_sel),
        .ReadData(ex_alu_res_sel),
        .WriteSel(flop_stall),
        .clk(clk),
        .rst(rst)
    );
    reg_1 branch_flop(
        .WriteData(id_branch),
        .ReadData(ex_branch),
        .WriteSel(flop_stall),
        .clk(clk),
        .rst(rst)
    );
    reg_1 branch_eqz_flop(
        .WriteData(id_branch_eqz),
        .ReadData(ex_branch_eqz),
        .WriteSel(flop_stall),
        .clk(clk),
        .rst(rst)
    );
    reg_1 branch_gtz_flop(
        .WriteData(id_branch_gtz),
        .ReadData(ex_branch_gtz),
        .WriteSel(flop_stall),
        .clk(clk),
        .rst(rst)
    );
    reg_1 branch_ltz_flop(
        .WriteData(id_branch_ltz),
        .ReadData(ex_branch_ltz),
        .WriteSel(flop_stall),
        .clk(clk),
        .rst(rst)
    );
    reg_1 Cin_flop(
        .WriteData(id_Cin),
        .ReadData(ex_Cin),
        .WriteSel(flop_stall),
        .clk(clk),
        .rst(rst)
    );
    reg_1 invA_flop(
        .WriteData(id_invA),
        .ReadData(ex_invA),
        .WriteSel(flop_stall),
        .clk(clk),
        .rst(rst)
    );
    reg_1 invB_flop(
        .WriteData(id_invB),
        .ReadData(ex_invB),
        .WriteSel(flop_stall),
        .clk(clk),
        .rst(rst)
    );
    reg_1 memEn_flop(
        .WriteData(id_memEn),
        .ReadData(ex_memEn),
        .WriteSel(flop_stall),
        .clk(clk),
        .rst(rst)
    );
    reg_1 memWrite_flop(
        .WriteData(id_memWrite),
        .ReadData(ex_memWrite),
        .WriteSel(flop_stall),
        .clk(clk),
        .rst(rst)
    );
    reg_1 regWrite_flop(
        .WriteData(id_regWrite),
        .ReadData(ex_regWrite),
        .WriteSel(flop_stall),
        .clk(clk),
    .rst(rst)
    );
    reg_1 sign_alu_flop(
        .WriteData(id_sign_alu),
        .ReadData(ex_sign_alu),
        .WriteSel(flop_stall),
        .clk(clk),
        .rst(rst)
    );
    reg_1 createdump_flop(
        .WriteData(id_createdump),
        .ReadData(ex_createdump),
        .WriteSel(flop_stall),
        .clk(clk),
        .rst(rst)
    );
    reg_1 halt_flop(
        .WriteData(id_halt),
        .ReadData(ex_halt),
        .WriteSel(flop_stall),
        .clk(clk),
        .rst(rst)
    );
    reg_1 ALUSrc_a_flop[1:0](
        .WriteData(id_ALUSrc_a),
        .ReadData(ex_ALUSrc_a),
        .WriteSel(flop_stall),
        .clk(clk),
        .rst(rst)
    );
    reg_1 ALUSrc_b_flop[1:0](
        .WriteData(id_ALUSrc_b),
        .ReadData(ex_ALUSrc_b),
        .WriteSel(flop_stall),
        .clk(clk),
        .rst(rst)
    );
    reg_1 memToReg_flop[1:0](
        .WriteData(id_memToReg),
        .ReadData(ex_memToReg),
        .WriteSel(flop_stall),
        .clk(clk),
        .rst(rst)
    );
    reg_1 pc_dec_flop[1:0](
        .WriteData(id_pc_dec),
        .ReadData(ex_pc_dec),
        .WriteSel(flop_stall),
        .clk(clk),
        .rst(rst)
    );
    reg_1 set_select_flop[1:0](
        .WriteData(id_set_select),
        .ReadData(ex_set_select),
        .WriteSel(flop_stall),
        .clk(clk),
        .rst(rst)
    );
    reg_1 alu_op_flop[2:0](
        .WriteData(id_alu_op),
        .ReadData(ex_alu_op),
        .WriteSel(flop_stall),
        .clk(clk),
        .rst(rst)
    );
    reg_1 write_reg_flop[2:0](
        .WriteData(id_write_reg),
        .ReadData(ex_write_reg),
        .WriteSel(flop_stall),
        .clk(clk),
        .rst(rst)
    );
    reg_1 instruction_flop[15:0](
        .WriteData(id_instruction),
        .ReadData(ex_instruction),
        .WriteSel(flop_stall),
        .clk(clk),
        .rst(rst)
    );
    reg_1 pc_plus_flop[15:0](
        .WriteData(id_pc_plus),
        .ReadData(ex_pc_plus),
        .WriteSel(flop_stall),
        .clk(clk),
        .rst(rst)
    );
    reg_1 reg1_data_flop[15:0](
        .WriteData(id_reg1_data),
        .ReadData(ex_reg1_data),
        .WriteSel(flop_stall),
        .clk(clk),
        .rst(rst)
    );
    reg_1 reg2_data_flop[15:0](
        .WriteData(id_reg2_data),
        .ReadData(ex_reg2_data),
        .WriteSel(flop_stall),
        .clk(clk),
        .rst(rst)
    );
    reg_1 sign_ext_low_bits_flop[15:0](
        .WriteData(id_sign_ext_low_bits),
        .ReadData(ex_sign_ext_low_bits),
        .WriteSel(flop_stall),
        .clk(clk),
        .rst(rst)
    );
    reg_1 reg1_sel_flop[2:0](
        .WriteData(id_reg1_sel),
        .ReadData(ex_reg1_sel),
        .WriteSel(flop_stall),
        .clk(clk),
        .rst(rst)
    );
    reg_1 reg2_sel_flop[2:0](
        .WriteData(id_reg2_sel),
        .ReadData(ex_reg2_sel),
        .WriteSel(flop_stall),
        .clk(clk),
        .rst(rst)
    );

endmodule
