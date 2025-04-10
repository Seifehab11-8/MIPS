module Control (

    input wire [5:0] control_sig,
    output reg RegDst,
    output reg Jump,
    output reg Branch,
    output reg MemRead,
    output reg MemtoReg,
    output reg [1:0] ALUOp,
    output reg MemWrite,
    output reg ALUSrc,
    output reg RegWrite
);

    always @(*) begin
        casez (control_sig)
        // lw instruction
            6'b100011: begin
                RegDst = 0;
                ALUSrc = 1;
                MemtoReg = 1;
                RegWrite = 1;
                MemRead = 1;
                MemWrite = 0;
                Branch = 0;
                ALUOp = 0;
                Jump = 0;
            end 
        // sw instruction
            6'b101011: begin
                RegDst = 1'bx;
                ALUSrc = 1;
                MemtoReg = 1'bx;
                RegWrite = 0;
                MemRead = 0;
                MemWrite = 1;
                Branch = 0;
                ALUOp = 0;
                Jump = 0;
            end
        // unconditional branch (j)
            6'b000010: begin
                RegDst = 1'bx;
                ALUSrc = 1'bx;
                MemtoReg = 1'bx;
                RegWrite = 0;
                MemRead = 0;
                MemWrite = 0;
                Branch = 0;
                ALUOp = 2'bxx;
                Jump = 1;
            end
        // R-format instructions
            6'b000000: begin
                RegDst = 1;
                ALUSrc = 0;
                MemtoReg = 0;
                RegWrite = 1;
                MemRead = 0;
                MemWrite = 0;
                Branch = 0;
                ALUOp = 2'b10;
                Jump = 0;
            end

            6'b000100: begin
                RegDst = 1'bx;
                ALUSrc = 0;
                MemtoReg = 1'bx;
                RegWrite = 0;
                MemRead = 0;
                MemWrite = 0;
                Branch = 1;
                ALUOp = 2'b01;
                Jump = 0;
            end
        endcase
    end
    
endmodule
