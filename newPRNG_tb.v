module universal_modified_reg_tb;
    reg clk, rst_n;
    reg [1:0] select;
    reg s_left_din, s_right_din;
    wire [3:0] p_dout;
    wire s_left_dout, s_right_dout;
    
    // Instantiate the module
    universal_modified_reg uut (
        .clk(clk),
        .rst_n(rst_n),
        .select(select),
        .s_left_din(s_left_din),
        .s_right_din(s_right_din),
        .p_dout(p_dout),
        .s_left_dout(s_left_dout),
        .s_right_dout(s_right_dout)
    );
    
    // Clock generation
    always #5 clk = ~clk;
    
    // Test stimulus
    initial begin
        // Initialize signals
        clk = 0;
        rst_n = 0;
        select = 2'b00;
        s_left_din = 0;
        s_right_din = 0;
        
        // Release reset
        #10 rst_n = 1;
        
        // Test PRNG operation using right shift with feedback
        select = 2'b10;  // Right shift mode for PRNG
        #80;  // Run for several cycles to see pattern
        
        // Test value retention
        select = 2'b00;
        #20;
        
        // Test complement (adds randomization)
        select = 2'b01;
        #20;
        
        // Test PRNG with left shift feedback
        select = 2'b11;
        #40;  // Run for several cycles to see pattern
        
        // Back to right shift PRNG
        select = 2'b10;
        #40;

        #10 $finish;
    end
    
    initial begin
        $monitor("Time=%0t rst_n=%b select=%b s_left_din=%b s_right_din=%b p_dout=%b",
                 $time, rst_n, select, s_left_din, s_right_din, p_dout);
        
        // Generate VCD file
        $dumpfile("universal_reg.vcd");
        $dumpvars(0, universal_modified_reg_tb);
    end
    
endmodule
