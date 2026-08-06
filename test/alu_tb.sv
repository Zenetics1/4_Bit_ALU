class alu_transaction #(int DATA_WIDTH = 8);
    rand logic [2 : 0]                  OP;
    rand logic signed [DATA_WIDTH-1 : 0] A;
    rand logic signed [DATA_WIDTH-1 : 0] B;
    rand logic                    carry_in;

    logic signed [DATA_WIDTH-1 : 0] result;
    logic flag_zero;
    logic flag_carry;
    logic flag_neg;
    logic flag_overflow;

    function void display(string name = "TRANSACTION");
     $display("[%s] OP=%b | A=%0d | B=%0d | Carry In=%0d => RESULT=%0d | Z=%b C=%b N=%b O=%b", name, OP, A, B, carry_in, result, flag_zero, flag_carry, flag_neg, flag_overflow);
    endfunction
endclass


module alu_tb;

    localparam MAX_SIZE = 8;

    logic [2 : 0] OP;
    logic signed [MAX_SIZE-1 : 0] A;
    logic signed [MAX_SIZE-1 : 0] B;
    logic carry_in;
    logic signed [MAX_SIZE-1 : 0] result;
    logic flag_zero;
    logic flag_carry;
    logic flag_neg;
    logic flag_overflow;

    int pass_count;
    int fail_count;

    top_module #(.INIT_SIZE(MAX_SIZE)) DUT (
        .OP(OP),
        .A(A),
        .B(B),
        .carry_in(carry_in),
        .result(result),
        .flag_zero(flag_zero),
        .flag_carry(flag_carry),
        .flag_neg(flag_neg),
        .flag_overflow(flag_overflow)
    );

    task automatic drive(alu_transaction#(MAX_SIZE) tr);
            OP = tr.OP;
            A = tr.A;
            B = tr.B;
            carry_in = tr.carry_in;

            #10

            tr.result = result;
            tr.flag_zero = flag_zero;
            tr.flag_carry = flag_carry;
            tr.flag_neg = flag_neg;
            tr.flag_overflow = flag_overflow;

            tr.display("DRIVEN");
    endtask

    function automatic void predict(
        alu_transaction#(MAX_SIZE) tr,
        output logic signed [MAX_SIZE-1 : 0] exp_result,
        output logic exp_zero, exp_carry, exp_neg, exp_overflow
    );
        logic adder_cin;
        logic [MAX_SIZE-1 : 0] b_mux;
        logic [MAX_SIZE : 0]   sum_full;
        logic [MAX_SIZE-1 : 0] sum_low;
        logic carry_in_msb;

        adder_cin = (tr.OP == 3'b001) ? 1'b1 : tr.carry_in;
        b_mux     = (tr.OP == 3'b001) ? ~tr.B : tr.B;

        sum_full = {1'b0, tr.A} + {1'b0, b_mux} + adder_cin;
        sum_low  = {1'b0, tr.A[MAX_SIZE-2:0]} + {1'b0, b_mux[MAX_SIZE-2:0]} + adder_cin;
        carry_in_msb = sum_low[MAX_SIZE-1];

        case (tr.OP)
            3'b000, 3'b001: exp_result = sum_full[MAX_SIZE-1:0];
            3'b010:         exp_result = tr.A & tr.B;
            3'b011:         exp_result = tr.A | tr.B;
            3'b100:         exp_result = tr.A ^ tr.B;
            3'b101:         exp_result = ~tr.A;
            3'b110:         exp_result = tr.A << 1;
            3'b111:         exp_result = tr.A >>> 1;
            default:        exp_result = '0;
        endcase

        exp_zero = (exp_result == '0);
        exp_neg  = exp_result[MAX_SIZE-1];

        if (tr.OP == 3'b000 || tr.OP == 3'b001) begin
            exp_carry    = sum_full[MAX_SIZE];
            exp_overflow = carry_in_msb ^ sum_full[MAX_SIZE];
        end else begin
            exp_carry    = 1'b0;
            exp_overflow = 1'b0;
        end
    endfunction

    task automatic check(alu_transaction#(MAX_SIZE) tr);
        logic signed [MAX_SIZE-1 : 0] exp_result;
        logic exp_zero, exp_carry, exp_neg, exp_overflow;

        predict(tr, exp_result, exp_zero, exp_carry, exp_neg, exp_overflow);

        if (tr.result === exp_result && tr.flag_zero === exp_zero &&
            tr.flag_carry === exp_carry && tr.flag_neg === exp_neg &&
            tr.flag_overflow === exp_overflow) begin
            pass_count++;
            $display("  -> PASS");
        end else begin
            fail_count++;
            $display("  -> FAIL: expected RESULT=%0d Z=%b C=%b N=%b O=%b",
                      exp_result, exp_zero, exp_carry, exp_neg, exp_overflow);
        end
    endtask

    initial begin

        automatic alu_transaction #(MAX_SIZE) trans = new();

        $display("==============================================");
        $display(" ALU Testbench");
        $display("==============================================");

        $display("\n--- Running Random Simulus Tests ---");
        repeat (100) begin
            if(!trans.randomize()) begin
                $error("Randomization Failed");
            end else begin
                drive(trans);
                check(trans);
            end
        end

        $display("\n==============================================");
        $display("    Simulation Complete: %0d PASSED, %0d FAILED", pass_count, fail_count);
        $display("==============================================");
        $finish;
    end
endmodule
