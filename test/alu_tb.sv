module alu_tb;

    localparam MAX_SIZE = 8;

    logic [2 : 0] OP,
    logic signed [INIT_SIZE-1 : 0] A,
    logic signed [INIT_SIZE-1 : 0] B,
    logic carry_in,
    logic signed [INIT_SIZE-1 : 0] result,
    logic flag_zero,
    logic flag_carry,
    logic flag_neg,
    logic flag_overflow

    int pass_count, fail_count;

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
    //testing addition. Uses: A, B, carry_in, result, all flags. OPCODE: 000
    task automatic ();
        
    endtask

    //testing subtraction. Uses: A, B, carry_in, result, all flags. OPCODE: 001


    //testing AND gate. Uses: A, B, Result, flag_zero, flag_neg. OPCODE: 010

    //testing OE gate. Uses: A, B, Result, flag_zero, flag_neg. OPCODE: 011

    //testing XOR gate. Uses: A, B, Result, flag_zero, flag_neg. OPCODE: 100

    //testing Invert gate. Uses: A, Result, flag_zero, flag_neg. OPCODE: 101

    //testing Left Shift. Uses: A, Result, flag_zero, flag_neg. OPCODE: 110

    //testing Right Shift. Uses: A, B, Result, flag_zero, flag_neg. OPCODE: 111

    initial begin
        $display("==============================================");
        $display("  ALU testbench");
        $display("==============================================");
        pass_count = 0;
        fail_count = 0;

        

        // implement tests here


        $display("\n==============================================");
        $display("  Results: %0d PASSED, %0d FAILED", pass_count, fail_count);
        $display("==============================================");
        $finish;
    end
endmodule
