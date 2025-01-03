//------------------------------------------------------------------------------
// FPU Controller
//
// op   | operation
// -----|----------
// 0000 | fadd
// 0001 | fsub
// 0010 | fmul
// 0011 | fdiv
// 0100 | fcvt.s.w
// 0101 | fcvt.w.s
// 0110 | feq
// 0111 | flt
// 1000 | fle
//------------------------------------------------------------------------------

module fpu_controller(
    input logic clk,
    input logic reset_n,
    input logic [3:0] op,
    input [31:0] in1, in2,
    input in1_stb, in2_stb,
    output in1_ack, in2_ack,
    output [31:0] out,
    output out_stb,
    input out_ack
);

    //------------------------------------------------------------------------------
    // 入力セレクタ
    //------------------------------------------------------------------------------

    // fsub の場合は、in2 の最上位ビットにある符号を反転して加算を行う
    assign adder_in2 = (op === 4'b0001) ? {~in2[31], in2[30:0]} : in2;
    assign adder_in1_stb = (op === 4'b0000 || op === 4'b0001) ? in1_stb : 1'b0;
    assign adder_in2_stb = (op === 4'b0000 || op === 4'b0001) ? in1_stb : 1'b0;
    assign adder_out_ack = (op === 4'b0000 || op === 4'b0001) ? out_ack : 1'b0;

    //------------------------------------------------------------------------------
    // 出力セレクタ
    //------------------------------------------------------------------------------

    assign in1_ack = (op === 4'b0000 || op === 4'b0001) ? adder_in1_ack : 1'bx;
    assign in2_ack = (op === 4'b0000 || op === 4'b0001) ? adder_in2_ack : 1'bx;
    assign out_stb = (op === 4'b0000 || op === 4'b0001) ? adder_out_stb : 1'bx;
    assign out = (op === 4'b0000 || op === 4'b0001) ? adder_out : 32'bx;

    //------------------------------------------------------------------------------
    // Floating-point Adder
    //------------------------------------------------------------------------------

    logic [31:0] adder_in2;
    logic adder_in1_stb; // in1 が有効になったらアサートする
    logic adder_in2_stb; // in2 が有効になったらアサートする
    logic adder_in1_ack; // 受け手側で in1 の読み込みが終わったらアサートされる
    logic adder_in2_ack; // 受け手側で in2 の読み込みが終わったらアサートされる
    logic [31:0] adder_out;
    logic adder_out_stb; // 計算結果が out に返ってきたらアサートされる
    logic adder_out_ack; // out の読み込みが終わったらアサートしてあげる

    adder adder_inst (
        .clk(clk),
        .rst(~reset_n),
        .input_a(in1),
        .input_a_stb(adder_in1_stb),
        .input_a_ack(adder_in1_ack),
        .input_b(adder_in2),
        .input_b_stb(adder_in2_stb),
        .input_b_ack(adder_in2_ack),
        .output_z(adder_out),
        .output_z_stb(adder_out_stb),
        .output_z_ack(adder_out_ack)
    );

endmodule
