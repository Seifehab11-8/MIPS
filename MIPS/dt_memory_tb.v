module DATA_Memory_tb;

    reg [31:0] data_in;
    reg [31:0] mem_address;
    reg mem_read;
    reg mem_write;
    wire [31:0] data_out;

    // Instantiate the DATA_Memory module
    DATA_Memory #(4000) uut (
        .data_in(data_in),
        .mem_address(mem_address),
        .mem_read(mem_read),
        .mem_write(mem_write),
        .data_out(data_out)
    );

    initial begin
        // Initialize signals
        data_in = 0;
        mem_address = 0;
        mem_read = 0;
        mem_write = 0;

        // Test case 1: Write operation
        #5 data_in = 32'd10; mem_address = 5; mem_write = 1;
        #10 mem_write = 0;

        // Test case 2: Write operation
        #5 data_in = 32'd20; mem_address = 7; mem_write = 1;
        #10 mem_write = 0;

        // Test case 3: Read operation
        #5 mem_read = 1; mem_address = 5;
        #10 mem_read = 0;

        // Test case 4: Read operation
        #5 mem_read = 1; mem_address = 7;
        #10 mem_read = 0;

        // Finish the simulation
        #20 $stop;
    end

    initial begin
        // Monitor the signals
        $monitor("At time %t, data_in = %d, mem_address = %d, mem_read = %b, mem_write = %b, data_out = %d", 
            $time, data_in, mem_address, mem_read, mem_write, data_out);
    end
endmodule

