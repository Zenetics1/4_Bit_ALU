module full_addr_1_bit (
    input in1, in2, carry_in,

    output carry_out, sum
);
    wire half_adder_sum, half_adder_carry;

    assign half_adder_sum = in1 ^ in2;
    assign half_adder_carry = in1 & in2;

    assign sum = half_adder_sum ^ carry_in;
    assign carry_out = half_adder_carry | (half_adder_sum & carry_in);

endmodule