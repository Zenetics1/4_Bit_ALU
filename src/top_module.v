module top_module #(
    INIT_SIZE = 4
) (
    input wire [INIT_SIZE-1:0] in,
    input wire [INIT_SIZE-2:0] ARITHMIC_SELECT,
    output wire [INIT_SIZE-1:0] out
);
    
    always @(*) begin
        case (ARITHMIC_SELECT)
            3'b001:
            3'b010:
            3'b011:
            3'b100: 
            default: 
        endcase    
    end


    addr addr_inst (
        .addr_IN(in),
        .addr_OUT(out)
    )

    subtraction subtraction_inst(
        .sub_IN(in),
        .sub_OUT(out)
    )


endmodule