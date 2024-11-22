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
    
    // Initialize registers to known values
    initial begin
        p_dout = 4'b0000;
    end
    
    // Synchronous logic with async reset
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            p_dout <= 4'b0000;
        end else begin
            case (select)
                2'b01: p_dout <= ~p_dout;
                2'b10: p_dout <= {s_right_din, p_dout[3:1]};
                2'b11: p_dout <= {p_dout[2:0], s_left_din};
                default: p_dout <= p_dout;
            endcase
        end
    end
    
    // Continuous assignments for outputs
    assign s_left_dout = p_dout[0];
    assign s_right_dout = p_dout[3];
    
endmodule
