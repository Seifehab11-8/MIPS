module ALU_Control (

    input wire [1:0] ALUOp_sig,
    input wire [5:0] funct,
    output reg [3:0] ALU_control_lines
);

    always @(*) begin
        if(ALUOp_sig == 2'b10)begin
            casez (funct)
            // add instruction
                6'b100000: begin
                    ALU_control_lines = 4'b0010;
                end
            // sub instruction
                6'b100010: begin
                    ALU_control_lines = 4'b0110;
                end
            endcase
        end
        else if(ALUOp_sig == 2'b00) begin // lw, sw, addi
            ALU_control_lines = 4'b0010;
        end
        else if(ALUOp_sig == 2'b01) begin // beq, subi
            ALU_control_lines = 4'b0110;
        end
		else begin
			ALU_control_lines = 4'bxxxx;
		end
    end

endmodule