module full_addr #(
    INIT_CARRY = 1'b0
)(
    input [3:0] num1_IN, num2_IN,
    output [3:0] ADDR_OUT,
    output Carry_MSB
);

    wire Carry_Bit0_to_Bit1, Carry_Bit1_to_Bit2, Carry_Bit2_to_Bit3;

    full_addr_1_bit bit0(
        .in1(num1_IN[0]),
        .in2(num2_IN[0]),
        .carry_in(INIT_CARRY),
        .carry_out(Carry_Bit0_to_Bit1),
        .sum(ADDR_OUT[0])
    );

    full_addr_1_bit bit1(
        .in1(num1_IN[1]),
        .in2(num2_IN[1]),
        .carry_in(Carry_Bit0_to_Bit1),
        .carry_out(Carry_Bit1_to_Bit2),
        .sum(ADDR_OUT[1])
    );

    full_addr_1_bit bit2(
        .in1(num1_IN[2]),
        .in2(num2_IN[2]),
        .carry_in(Carry_Bit1_to_Bit2),
        .carry_out(Carry_Bit2_to_Bit3),
        .sum(ADDR_OUT[2])
    );

    full_addr_1_bit bit3(
        .in1(num1_IN[3]),
        .in2(num2_IN[3]),
        .carry_in(Carry_Bit2_to_Bit3),
        .carry_out(Carry_MSB),
        .sum(ADDR_OUT[3])
    );





endmodule