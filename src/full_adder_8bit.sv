module full_adder_8bit(
    input carry_in,
    input [7 : 0] IN1, IN2,
    output [7 : 0] ADDR_OUT,
    output Carry_MSB
);

    logic Carry_B0_B1, Carry_B1_B2, Carry_B2_B3, Carry_B3_B4, Carry_B4_B5, Carry_B5_B6, Carry_B6_B7;

    adder_1bit  bit0(
        .in1(IN1[0]),
        .in2(IN2[0]),
        .carry_in(carry_in),
        .carry_out(Carry_B0_B1),
        .sum(ADDR_OUT[0])
    );

    adder_1bit  bit1(
        .in1(IN1[1]),
        .in2(IN2[1]),
        .carry_in(Carry_B0_B1),
        .carry_out(Carry_B1_B2),
        .sum(ADDR_OUT[1])
    );

    adder_1bit  bit2(
        .in1(IN1[2]),
        .in2(IN2[2]),
        .carry_in(Carry_B1_B2),
        .carry_out(Carry_B2_B3),
        .sum(ADDR_OUT[2])
    );

    adder_1bit  bit3(
        .in1(IN1[3]),
        .in2(IN2[3]),
        .carry_in(Carry_B2_B3),
        .carry_out(Carry_B3_B4),
        .sum(ADDR_OUT[3])
    );
    adder_1bit  bit4(
        .in1(IN1[4]),
        .in2(IN2[4]),
        .carry_in(Carry_B3_B4),
        .carry_out(Carry_B4_B5),
        .sum(ADDR_OUT[4])
    );
    adder_1bit  bit5(
        .in1(IN1[5]),
        .in2(IN2[5]),
        .carry_in(Carry_B4_B5),
        .carry_out(Carry_B5_B6),
        .sum(ADDR_OUT[5])
    );
    adder_1bit  bit6(
        .in1(IN1[6]),
        .in2(IN2[6]),
        .carry_in(Carry_B5_B6),
        .carry_out(Carry_B6_B7),
        .sum(ADDR_OUT[6])
    );
    adder_1bit  bit7(
        .in1(IN1[7]),
        .in2(IN2[7]),
        .carry_in(Carry_B6_B7),
        .carry_out(Carry_MSB),
        .sum(ADDR_OUT[7])
    );

endmodule
