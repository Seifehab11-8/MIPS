module testbench;

reg clk; // Instantiate the MIPS processor 
MIPS_processor uut (.clk(clk));

// Clock generation 
always begin 
    #5 clk = ~clk; // Toggle clock every 5 time units end
end

initial begin
    clk = 0;
end
endmodule