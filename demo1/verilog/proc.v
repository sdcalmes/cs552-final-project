/* $Author: karu $ */
/* $LastChangedDate: 2009-03-04 23:09:45 -0600 (Wed, 04 Mar 2009) $ */
/* $Rev: 45 $ */
module proc (/*AUTOARG*/
    // Outputs
    err, 
    // Inputs
    clk, rst
    );

    input clk;
    input rst;

    output err;

    // None of the above lines can be modified

    // OR all the err ouputs for every sub-module and assign it as this
    // err output
   
    // As desribed in the homeworks, use the err signal to trap corner
    // cases that you think are illegal in your statemachines

    /////////////////////////////////
    /////    REG/Wire          /////
    ///////////////////////////////
   
    //pc adder stuff
    reg [15:0] pc_plus;
    wire ofl, z;
    reg PC;
    //memory2c elements
    reg [15:0] instruction;
    reg [15:0] PC_address;
    reg [15:0] mem_address;
    reg [15:0] write_data_mem;
    reg [15:0] read_data;
    wire enable_read, enable_write;

    //control elements
    wire regDst, jump, branch, memRead, memToReg, ALUOp, memWrite, ALUSrc, regWrite,
	    branch_eq_z, branch_gt_z, branch_lt_z;

    //register components
    reg [2:0] read_reg_1, read_reg_2, write_reg;
    reg [15:0] write_data_reg, read_reg_1_data, read_reg_2_data;
    wire reg_err;

    //branch alu elemtns
    reg [15:0] sign_ext_low_bits;
    wire branch_out, b_ofl, b_z;

    //main alu elements
    reg [15:0] alu_b_input, main_alu_out;
    wire main_ofl, main_z;

    //shifter elements
    reg [15:0] shift_in, shift_out;
    reg [3:0] shift_cnt;
    reg [1:0] shift_op;

    ////////////////////////////////
    /////    Instantiate     //////
    //////////////////////////////
    
    alu         main_alu(.A(read_reg_1), .B(alu_b_input), .Cin(1'b0), .Op(alu_op),
	    			.invA(1'b0), .invB(1'b0), .sign(1'b0), .Out(main_alu_out),
				.Ofl(main_ofl), .Z(main_z));

    memory2c    inst_mem(.data_in(PC_address), .data_out(instruction), .addr(),
	    			.enable(enable_read), .wr(enable_write), 
                         	.createdump(), .clk(clk), .rst(rst));

    rf_bypass   register(.read1regsel(read_reg_1), .read2regsel(read_reg_2),
	    			.writeregsel(write_reg), .writedata(write_data_reg), 
                         	.write(regWrite), .read1data(read_reg_1_data),
				.read2data(read_reg_2_data), .err(reg_err));

    memory2c    data_mem(.data_in(write_data_mem), .data_out(read_data), .addr(mem_address),
	    			.enable(enable_read), .wr(enable_write), 
                         	.createdump(), .clk(clk), .rst(rst));

    control     control(.instr(instruction[15:11]), .regDst(regDst), .jump(jump), .branch(branch),
	    			.memRead(memRead), .memToReg(memToReg), .ALUOp(ALUOp),
				.memWrite(memWrite), .ALUSrc(ALUSrc), .regWrite(regWrite),
				.branch_eq_z(branch_eq_z), .branch_gt_z(branch_gt_z),
				.branch_lt_z(branch_lt_z));

    alu_control alu_cntl(.cmd(ALUOp), .alu_op(), .lowerBits());

    alu         pc_add(.A(PC), .B(16'h0002), .Cin(1'b0), .Op(3'b100), .invA(1'b0), .invB(1'b0),
    				.sign(1'b0), .Out(pc_plus), .Ofl(ofl), .Z(z));

    alu		branch_add(.A(pc_plus), .B(shift_out), .Cin(1'b0), .Op(3'b100), .invA(1'b0),
	    			.invB(1'b0), .sign(1'b0), .Out(branch_out), .Ofl(b_ofl), .Z(b_z));

    shifter	branch_shifter(.In(shift_in), .Cnt(shift_cnt), .Op(shift_op), .Out(shift_out));



    //////////////////////////////
    /////    Logic          /////
    ////////////////////////////
    
    //pc update
    assign PC = branch_logic_out ? branch_out : pc_plus;

    //sign extended lower 8 bits
    assign sign_ext_low_bits = { {8{instruction[7]}}, instruction[7:0]};
    
    //mux before main alu
    assign alu_b_input = ALUSrc ? sign_ext_low_bits : read_reg_2_data;

    //branch alu input
    assign shift_in = sign_ext_low_bits;
    assign shift_cnt = 2'b10;
    assign shift_op = 2'b01;




endmodule // proc
// DUMMY LINE FOR REV CONTROL :0:
