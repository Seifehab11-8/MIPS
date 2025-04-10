module MIPS_processor (input wire clk);
    reg [31:0] PC_sig;           
    wire [31:0] mips_instruction;
    reg [31:0] write_data;       
    wire [31:0] reg_out_1;        
    wire [31:0] reg_out_2;        
    reg [31:0] alu_second_input; 
    wire [31:0] ALU_result;       
    wire [31:0] read_data;        
    wire [31:0] signed_extent_in; 
    wire [3:0] alu_sig;           
    wire zero_sig;                

    wire RegDst;
    wire Jump;
    wire Branch;
    wire MemRead;
    wire MemtoReg;
    wire [1:0] ALUOp;
    wire MemWrite;
    wire ALUSrc;
    wire RegWrite;

    assign signed_extent_in  = {{16{mips_instruction[15]}}, mips_instruction[15:0]};

    initial begin 
        PC_sig = 32'b0; // Set the initial value in the register
    end

    IR_Memory ir(
        .PC(PC_sig),
        .instruction(mips_instruction)
    );
	

	Control ctrl(
		.control_sig(mips_instruction[31:26]),
		.RegDst(RegDst),
		.Jump(Jump),
		.Branch(Branch),
		.MemRead(MemRead),
		.MemtoReg(MemtoReg),
		.ALUOp(ALUOp),
		.MemWrite(MemWrite),
		.ALUSrc(ALUSrc),
		.RegWrite(RegWrite)
	);


    REG_Memory rg(
        .reg_1(mips_instruction[25:21]),
        .reg_2(mips_instruction[20:16]),
        .write_reg(mips_instruction[15:11]),
        .write_data(write_data),
        .reg_write(RegWrite),
        .reg_dst(RegDst),
		.clk(clk),
        .read_data_1(reg_out_1),
        .read_data_2(reg_out_2)
    );

    DATA_Memory dt(
        .data_in(reg_out_2),
        .mem_address(ALU_result),
        .mem_read(MemRead),
        .mem_write(MemWrite),
        .data_out(read_data)
    );

    ALU_Control al_ctrl(
        .ALUOp_sig(ALUOp),
        .funct(mips_instruction[5:0]),
        .ALU_control_lines(alu_sig)
    );

    ALU al(
        .ALU_Control_sig(alu_sig),
        .data_1(reg_out_1),
        .data_2(alu_second_input), 
        .ALU_result(ALU_result),
        .zero_sig(zero_sig)
    );

    // Write data either it is from data memory or ALU result
    always @(*) begin
        if (MemtoReg == 1) begin
            write_data = read_data;
        end else begin
            write_data = ALU_result;
        end
    end
	
	always @(*) begin
		if(ALUSrc == 1) begin
			alu_second_input = (signed_extent_in>>2);
		end
		else begin
			alu_second_input = reg_out_2;
		end
	end


    always @(posedge clk) begin
        if (Jump == 1) begin
            PC_sig = (mips_instruction[25:0])<<2;
		end
		else if(Branch == 1 && zero_sig == 1)begin
			PC_sig = PC_sig + (signed_extent_in<<2) + 4;
		end 
		else begin
            PC_sig = PC_sig + 4; // Next instruction
        end
    end
endmodule
