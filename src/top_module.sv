module moduleName #(
    INIT_SIZE = 8
) (
    input [2 : 0] OP,
    input [INIT_SIZE - 1 : 0] A,
    input [INIT_SIZE - 1 : 0] B,
    input carry_in,
    output [INIT_SIZE - 1 : 0] result,
    output flag_zero,
    output flag_carry,
    output flag_neg,
    output flag_overflow
);
    
endmodule