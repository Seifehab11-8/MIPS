module REG_Memory(
    input wire [4:0]reg_1,
    input wire [4:0]reg_2,
    input wire [4:0]write_reg,
    input wire [31:0]write_data,
	input wire clk,
    input wire reg_write,
    input wire reg_dst,
    output reg [31:0]read_data_1,
    output reg [31:0]read_data_2
);

    reg [31:0]reg_mem[31:0];
	
    integer i;

    initial begin
        for(i = 0; i < 32; i = i+1)begin
            reg_mem[i] = 0;
        end
		reg_mem[8] = 32'd5;
		reg_mem[9] = 32'd10;
		reg_mem[10] = 32'd20;
    end

    always@(reg_1 or reg_2)begin
        read_data_1 = reg_mem[reg_1];
        read_data_2 = reg_mem[reg_2];
    end

    always@(posedge clk)begin
        if(reg_write == 1)begin
            if((reg_dst == 1) && (write_reg != 0))begin
			// write reg condition to make sure it is not allowed to write in $zero
				reg_mem[write_reg] <= write_data;
            end
            else if (reg_2 != 0) begin
				reg_mem[reg_2] <= write_data;
            end
        end
		
    end
	
endmodule
