module top_module #(
    parameter INIT_SIZE = 8
) (
    input  logic [2 : 0] OP,
    input  logic signed [INIT_SIZE-1 : 0] A,
    input  logic signed [INIT_SIZE-1 : 0] B,
    input  logic carry_in,
    output logic signed [INIT_SIZE-1 : 0] result,
    output logic flag_zero,
    output logic flag_carry,
    output logic flag_neg,
    output logic flag_overflow
);
    logic signed [INIT_SIZE-1 : 0] adder_result;
    logic adder_carry_in, adder_carry_out, carry_in_MSB;
    logic signed [INIT_SIZE-1 : 0] B_Mux;

    assign adder_carry_in = (OP == 3'b001) ? 1'b1 : carry_in;
    assign B_Mux = (OP == 3'b001) ? ~B : B;

    full_adder_8bit #(
        .WIDTH(INIT_SIZE)
    ) full_adder (
        .carry_in (adder_carry_in),
        .IN1      (A),
        .IN2      (B_Mux),
        .ADDR_OUT (adder_result),
        .Carry_MSB(adder_carry_out),
        .carry_in_MSB(carry_in_MSB)
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
        3'b111: result = A >>> 1;
            default: result = '0; 
        endcase

        flag_zero = (result == '0);
        flag_neg = result[INIT_SIZE-1];


        if(OP == 3'b000 || OP == 3'b001) begin
            flag_carry = adder_carry_out;
            flag_overflow = carry_in_MSB ^ adder_carry_out;
        end else begin
            flag_carry = 1'b0;
            flag_overflow = 1'b0;
        end
        
    end
   
endmodule
