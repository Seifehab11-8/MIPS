module IR_Memory #(
    parameter IR_MEM_SIZE = 1000
) (
    input wire [31:0] PC,
    output reg [31:0] instruction
);
    reg [31:0] ir_mem [IR_MEM_SIZE-1:0];
    integer i; 
    initial begin
        // Initializing the memory with machine code
        //ir_mem[0] = 32'h20080005; // addi $t0, $zero, 5
        //ir_mem[1] = 32'h2009000A; // addi $t1, $zero, 10
        //ir_mem[2] = 32'h200A0014; // addi $t2, $zero, 20
        ir_mem[0] = 32'h01095820; // add  $t3, $t0, $t1
        ir_mem[1] = 32'h01496022; // sub  $t4, $t2, $t1
        ir_mem[2] = 32'h08000003; // j    jump_label
        ir_mem[3] = 32'h01686820; // add  $t5, $t3, $t0
        ir_mem[4] = 32'h018A7020; // add  $t6, $t4, $t2
        ir_mem[5] = 32'hAD0E0008; // sw   $t6, 8($t0)
        ir_mem[6] = 32'hAD2D000C; // sw   $t5, 12($t1)
		ir_mem[7] = 32'h8D2E000C; // lw   $t6, 12($t1)
        ir_mem[8] = 32'h8D0D0008; // lw   $t5, 8($t0)
		ir_mem[9] = 32'h114EFFF9; // beq  t2,  t6,  0xFFF6
        // Fill the rest with no-ops or other values as needed

        for (i = 12; i < IR_MEM_SIZE; i = i + 1) begin
            ir_mem[i] = 32'h00000000; // no-op or default value
        end
    end

    always @(*) begin
        instruction <= ir_mem[PC>>2];
    end

endmodule
// 01095020
// 0000 0001 0000 1001 0101 0000 0010 0000