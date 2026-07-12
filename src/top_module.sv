module top_module #(
    parameter INIT_SIZE = 8
) (
    input [2 : 0] OP,
    input [INIT_SIZE-1 : 0] A,
    input [INIT_SIZE-1 : 0] B,
    input carry_in,
    output logic [INIT_SIZE-1 : 0] result,
    output logic flag_zero,
    output logic flag_carry,
    output logic flag_neg,
    output logic flag_overflow
);
    logic [INIT_SIZE-1 : 0] adder_result;
    logic adder_carry_in, adder_carry_out;
    logic [INIT_SIZE-1 : 0] B_Mux;

    assign adder_carry_in = (OP == 3'b001) ? 1'b1 : carry_in;
    assign B_Mux = (OP == 3'b001) ? ~B : B;

    full_adder_8bit full_adder_8bit (
        .carry_in (adder_carry_in),
        .IN1      (A),
        .IN2      (B_Mux),
        .ADDR_OUT (adder_result),
        .Carry_MSB(adder_carry_out)
    );

    always_comb begin
        case (OP)
        3'b000: result = adder_result;
        3'b001: result = adder_result;
        3'b010: result = A & B;
        3'b011: result = A | B;
        3'b100: result = A ^ B;
        3'b101: result = ~A;
        3'b110: result = A << 1;
        3'b111: result = A >> 1;
            default: result = 8'b0; 
        endcase
    end

    assign flag_zero = (result == 8'b0);
    assign flag_carry = adder_carry_out;
    assign flag_neg = result[INIT_SIZE-1];
    assign flag_overflow = full_adder_8bit.Carry_B6_B7 ^ adder_carry_out;
endmodule
