module addr_1b (
    input in1, in2,
    input carry_in,

    output carry_out,
    output sum
);
    assign sum = in1 ^ in2 ;
    
    assign carry_out = in1 & in2;

endmodule