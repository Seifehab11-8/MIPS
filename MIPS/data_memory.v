module DATA_Memory #(
    parameter DATA_MEM_SIZE = 4000
) (
    input wire [31:0] data_in,
    input wire [31:0] mem_address,
    input wire mem_read,
    input wire mem_write,
    output reg [31:0] data_out);

    reg [31:0]mem[DATA_MEM_SIZE-1:0]; 
	reg write_complete_flag;
	initial begin
		write_complete_flag = 0;
	end
	
    always@(*)begin
        if(mem_read == 1)begin
            data_out = mem[mem_address];
			$display("At time %t, mem_address (read) = %d, data_out = %d", $time, mem_address, data_out);
        end 
		else begin 
			data_out = 32'bz; // High-impedance state when not reading 
		end
    end

    always@(*)begin
		if (write_complete_flag == 0 && mem_write == 1) begin 
			write_complete_flag = 1; 
		end 
		else if (mem_write == 1) begin 
		mem[mem_address] = data_in; 
		write_complete_flag = 0; 
		$display("At time %t, mem_address = %d, data = %d", $time, mem_address, mem[mem_address]);
		end
    end

endmodule

