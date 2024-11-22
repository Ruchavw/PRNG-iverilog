module TB;
    // Signal declarations
    reg clk, rst_n;
    reg [1:0] select;
    reg s_left_din, s_right_din;
    wire [3:0] p_dout;
    wire s_left_dout, s_right_dout;
    
    // Module instantiation
    universal_modified_reg usr(
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
    always #2 clk = ~clk;
    
    // Test stimulus
    initial begin
        // Initialize signals to known values
        clk = 0;
        rst_n = 0;
        select = 2'b00;
        s_left_din = 0;
        s_right_din = 0;
        
        // Monitor format
        $monitor("Time=%0t rst_n=%b select=%b s_left=%b s_right=%b p_dout=%b left_out=%b right_out=%b",
                 $time, rst_n, select, s_left_din, s_right_din, p_dout, s_left_dout, s_right_dout);
        
        // Reset sequence
        #3 rst_n = 1;
        
        // Test sequence 1: Both inputs 0
        s_left_din = 1'b0;
        s_right_din = 1'b0;
        
        select = 2'b11; #10;  // Left shift
        select = 2'b10; #10;  // Right shift
        select = 2'b01; #10;  // Complement
        select = 2'b00; #10;  // Hold
        
        // Test sequence 2: Right input 1
        s_left_din = 1'b0;
        s_right_din = 1'b1;
        
        select = 2'b11; #10;
        select = 2'b10; #10;
        select = 2'b01; #10;
        select = 2'b00; #10;
        
        // Test sequence 3: Left input 1
        s_left_din = 1'b1;
        s_right_din = 1'b0;
        
        select = 2'b11; #10;
        select = 2'b10; #10;
        select = 2'b01; #10;
        select = 2'b00; #10;
        
        // Test sequence 4: Both inputs 1
        s_left_din = 1'b1;
        s_right_din = 1'b1;
        
        select = 2'b11; #10;
        select = 2'b10; #10;
        select = 2'b01; #10;
        select = 2'b00; #10;
        
        $finish;
    end
    
    // Waveform generation
    initial begin
        $dumpfile("work.vcd");
        $dumpvars(0, TB);
    end
    
endmodule
