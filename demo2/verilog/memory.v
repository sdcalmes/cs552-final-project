module memory(memRead, memWrite, alu_out, reg2_data, read_data,
              createdump, clk, rst);

    input memRead, memWrite, createdump, clk, rst;
    input [15:0] alu_out, reg2_data;
    output [15:0] read_data;

    memory2c	data_mem(.data_in(reg2_data), .data_out(read_data),
                .addr(alu_out), .enable(memRead), .wr(memWrite),
                .createdump(createdump), .clk(clk), .rst(rst));

endmodule
