module universal_modified_reg(
    input clk,
    input rst_n,
    input [1:0] select,
    input s_left_din,
    input s_right_din,
    output reg [3:0] p_dout,
    output s_left_dout,
    output s_right_dout
);
    
    // Wire for PRNG feedback: x^4 + x^3 + 1
    wire feedback = p_dout[3] ^ p_dout[2]; 
    
    // Initialize register to non-zero value for PRNG operation
    initial begin
        p_dout = 4'b1111;  
    end
    
    // Synchronous logic with async reset
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            p_dout <= 4'b1111;  // Reset to non-zero initial value
        end else begin
            case (select)
                2'b00: p_dout <= p_dout;                         // Retain value
                2'b01: p_dout <= ~p_dout;                        // Complement for randomization
                2'b10: p_dout <= {feedback, p_dout[3:1]};        // Right shift with feedback
                2'b11: p_dout <= {p_dout[2:0], feedback};        // Left shift with feedback 
            endcase
        end
    end
    
    // Output assignments
    assign s_left_dout = p_dout[0];
    assign s_right_dout = p_dout[3];
    
endmodule


