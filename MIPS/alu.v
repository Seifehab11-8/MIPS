module ALU (
    input wire [3:0] ALU_Control_sig,
    input wire [31:0] data_1,
    input wire [31:0] data_2,
    output reg [31:0] ALU_result,
    output reg zero_sig
);
    always @(*) begin
        casez (ALU_Control_sig)
            4'b0010: begin
                ALU_result <= data_1 + data_2;
                if(ALU_result == 0)begin
                    zero_sig <= 1;
                end
                else begin
                    zero_sig <= 0;
                end
            end

            4'b0110: begin
                ALU_result <= data_1 - data_2;
                if(ALU_result == 0)begin
                    zero_sig <= 1;
                end
                else begin
                    zero_sig <= 0;
                end
            end
        endcase
    end
    
endmodule
