//------------------------------------------------------------------------------
// FPU Controller
//
// op   | operation
// -----|----------
// 0000 | fadd
// 0001 | fsub
// 0010 | fmul
// 0011 | fdiv
// 0100 | fcvt.s.w (int to float)
// 0101 | fcvt.w.s (float to int)
// 0110 | fsgnj
// 0111 | fsgnjn
// 1000 | feq
// 1001 | flt
// 1010 | fle
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

    assign multiplier_in1_stb = (op === 4'b0010) ? in1_stb : 1'b0;
    assign multiplier_in2_stb = (op === 4'b0010) ? in1_stb : 1'b0;
    assign multiplier_out_ack = (op === 4'b0010) ? out_ack : 1'b0;

    assign divider_in1_stb = (op === 4'b0011) ? in1_stb : 1'b0;
    assign divider_in2_stb = (op === 4'b0011) ? in1_stb : 1'b0;
    assign divider_out_ack = (op === 4'b0011) ? out_ack : 1'b0;

    assign int2float_in1_stb = (op === 4'b0100) ? in1_stb : 1'b0;
    assign int2float_out_ack = (op === 4'b0100) ? out_ack : 1'b0;

    assign float2int_in1_stb = (op === 4'b0101) ? in1_stb : 1'b0;
    assign float2int_out_ack = (op === 4'b0101) ? out_ack : 1'b0;

    //------------------------------------------------------------------------------
    // 出力セレクタ
    //------------------------------------------------------------------------------

    assign in1_ack = (op === 4'b0000 || op === 4'b0001) ? adder_in1_ack :
                     (op === 4'b0100)                   ? int2float_in1_ack :
                     (op === 4'b0101)                   ? float2int_in1_ack :
                     (op === 4'b0110)                   ? fsgnj_in1_ack :
                     (op === 4'b0111)                   ? fsgnjn_in1_ack :
                     (op === 4'b1000)                   ? feq_in1_ack :
                     (op === 4'b1001)                   ? flt_in1_ack :
                     (op === 4'b1010)                   ? fle_in1_ack :
                     (op === 4'b0010)                   ? multiplier_in1_ack :
                     (op === 4'b0011)                   ? divider_in1_ack
                                                        : 1'bx;
    assign in2_ack = (op === 4'b0000 || op === 4'b0001) ? adder_in2_ack :
                     (op === 4'b0100)                   ? int2float_in1_ack :
                     (op === 4'b0101)                   ? float2int_in1_ack :
                     (op === 4'b0110)                   ? fsgnj_in2_ack :
                     (op === 4'b0111)                   ? fsgnjn_in2_ack :
                     (op === 4'b1000)                   ? feq_in2_ack :
                     (op === 4'b1001)                   ? flt_in2_ack :
                     (op === 4'b1010)                   ? fle_in2_ack :
                     (op === 4'b0010)                   ? multiplier_in2_ack :
                     (op === 4'b0011)                   ? divider_in2_ack
                                                        :1'bx;
    assign out_stb = (op === 4'b0000 || op === 4'b0001) ? adder_out_stb :
                     (op === 4'b0100)                   ? int2float_out_stb :
                     (op === 4'b0101)                   ? float2int_out_stb :
                     (op === 4'b0110)                   ? fsgnj_out_stb :
                     (op === 4'b0111)                   ? fsgnjn_out_stb :
                     (op === 4'b1000)                   ? feq_out_stb :
                     (op === 4'b1001)                   ? flt_out_stb :
                     (op === 4'b1010)                   ? fle_out_stb :
                     (op === 4'b0010)                   ? multiplier_out_stb :
                     (op === 4'b0011)                   ? divider_out_stb
                                                        : 1'bx;
    assign out = (op === 4'b0000 || op === 4'b0001) ? adder_out :
                 (op === 4'b0100)                   ? int2float_out :
                 (op === 4'b0101)                   ? float2int_out :
                 (op === 4'b0110)                   ? fsgnj_out :
                 (op === 4'b0111)                   ? fsgnjn_out :
                 (op === 4'b1000)                   ? feq_out :
                 (op === 4'b1001)                   ? flt_out :
                 (op === 4'b1010)                   ? fle_out :
                 (op === 4'b0010)                   ? multiplier_out :
                 (op === 4'b0011)                   ? divider_out
                                                    : 32'bx;

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

    //------------------------------------------------------------------------------
    // Floating-point Multiplier
    //------------------------------------------------------------------------------

    logic multiplier_in1_stb; // in1 が有効になったらアサートする
    logic multiplier_in2_stb; // in2 が有効になったらアサートする
    logic multiplier_in1_ack; // 受け手側で in1 の読み込みが終わったらアサートされる
    logic multiplier_in2_ack; // 受け手側で in2 の読み込みが終わったらアサートされる
    logic [31:0] multiplier_out;
    logic multiplier_out_stb; // 計算結果が out に返ってきたらアサートされる
    logic multiplier_out_ack; // out の読み込みが終わったらアサートしてあげる

    multiplier multiplier_inst (
        .clk(clk),
        .rst(~reset_n),
        .input_a(in1),
        .input_a_stb(multiplier_in1_stb),
        .input_a_ack(multiplier_in1_ack),
        .input_b(in2),
        .input_b_stb(multiplier_in2_stb),
        .input_b_ack(multiplier_in2_ack),
        .output_z(multiplier_out),
        .output_z_stb(multiplier_out_stb),
        .output_z_ack(multiplier_out_ack)
    );

    //------------------------------------------------------------------------------
    // Floating-point Divider
    //------------------------------------------------------------------------------

    logic divider_in1_stb; // in1 が有効になったらアサートする
    logic divider_in2_stb; // in2 が有効になったらアサートする
    logic divider_in1_ack; // 受け手側で in1 の読み込みが終わったらアサートされる
    logic divider_in2_ack; // 受け手側で in2 の読み込みが終わったらアサートされる
    logic [31:0] divider_out;
    logic divider_out_stb; // 計算結果が out に返ってきたらアサートされる
    logic divider_out_ack; // out の読み込みが終わったらアサートしてあげる

    divider divider_inst (
        .clk(clk),
        .rst(~reset_n),
        .input_a(in1),
        .input_a_stb(divider_in1_stb),
        .input_a_ack(divider_in1_ack),
        .input_b(in2),
        .input_b_stb(divider_in2_stb),
        .input_b_ack(divider_in2_ack),
        .output_z(divider_out),
        .output_z_stb(divider_out_stb),
        .output_z_ack(divider_out_ack)
    );

    //------------------------------------------------------------------------------
    // Floating-point Converter (int to float)
    //------------------------------------------------------------------------------

    logic int2float_in1_stb; // in1 が有効になったらアサートする
    logic int2float_in1_ack; // 受け手側で in1 の読み込みが終わったらアサートされる
    logic [31:0] int2float_out;
    logic int2float_out_stb; // 計算結果が out に返ってきたらアサートされる
    logic int2float_out_ack; // out の読み込みが終わったらアサートしてあげる

    int_to_float int_to_float_inst (
        .clk(clk),
        .rst(~reset_n),
        .input_a(in1),
        .input_a_stb(int2float_in1_stb),
        .input_a_ack(int2float_in1_ack),
        .output_z(int2float_out),
        .output_z_stb(int2float_out_stb),
        .output_z_ack(int2float_out_ack)
    );

    //------------------------------------------------------------------------------
    // Floating-point Converter (float to int)
    //------------------------------------------------------------------------------

    logic float2int_in1_stb; // in1 が有効になったらアサートする
    logic float2int_in1_ack; // 受け手側で in1 の読み込みが終わったらアサートされる
    logic [31:0] float2int_out;
    logic float2int_out_stb; // 計算結果が out に返ってきたらアサートされる
    logic float2int_out_ack; // out の読み込みが終わったらアサートしてあげる

    float_to_int float_to_int_inst (
        .clk(clk),
        .rst(~reset_n),
        .input_a(in1),
        .input_a_stb(float2int_in1_stb),
        .input_a_ack(float2int_in1_ack),
        .output_z(float2int_out),
        .output_z_stb(float2int_out_stb),
        .output_z_ack(float2int_out_ack)
    );

    //------------------------------------------------------------------------------
    // 符号インジェクト
    //------------------------------------------------------------------------------

    // fsgnj: 「in2 の符号部 + in1 の指数部 + in1 の仮数部」を返す
    logic [31:0] fsgnj_out;
    logic fsgnj_in1_ack;
    logic fsgnj_in2_ack;
    logic fsgnj_out_stb;

    assign fsgnj_out = {in2[31], in1[30:23], in1[22:0]};
    // 常にアサートでもいいかな？
    assign fsgnj_in1_ack = 1'b1;
    assign fsgnj_in2_ack = 1'b1;
    assign fsgnj_out_stb = 1'b1;

    // fsgnjn: 「in2 の符号部の反転 + in1 の指数部 + in1 の仮数部」を返す
    logic [31:0] fsgnjn_out;
    logic fsgnjn_in1_ack;
    logic fsgnjn_in2_ack;
    logic fsgnjn_out_stb;

    assign fsgnjn_out = {~in2[31], in1[30:23], in1[22:0]};
    // 常にアサートでもいいかな？
    assign fsgnjn_in1_ack = 1'b1;
    assign fsgnjn_in2_ack = 1'b1;
    assign fsgnjn_out_stb = 1'b1;

    //------------------------------------------------------------------------------
    // 浮動小数点数比較演算（FEQ, FLT, FLE）
    //------------------------------------------------------------------------------

    logic fp_sign1;
    logic fp_sign2;
    logic [7:0] fp_exp1;
    logic [7:0] fp_exp2;
    logic [22:0] fp_frac1;
    logic [22:0] fp_frac2;

    assign fp_sign1 = in1[31];
    assign fp_sign2 = in2[31];
    assign fp_exp1 = in1[30:23];
    assign fp_exp2 = in2[30:23];
    assign fp_frac1 = in1[22:0];
    assign fp_frac2 = in2[22:0];

    // FEQ
    // NOTE: 雑に実装しているので、NaN などの特殊なケースは考慮していない
    logic [31:0] feq_out;
    logic feq_in1_ack;
    logic feq_in2_ack;
    logic feq_out_stb;

    assign feq_out = (fp_sign1 === fp_sign2 && fp_exp1 === fp_exp2 && fp_frac1 === fp_frac2) ? 32'h00000001 : 32'h00000000;
    assign feq_in1_ack = 1'b1;
    assign feq_in2_ack = 1'b1;
    assign feq_out_stb = 1'b1;

    // FLT
    // NOTE: 雑に実装しているので、NaN などの特殊なケースは考慮していない
    logic [31:0] flt_out;
    logic flt_in1_ack;
    logic flt_in2_ack;
    logic flt_out_stb;

    assign flt_out = (fp_sign1 === fp_sign2 && fp_exp1 === fp_exp2 && fp_frac1 === fp_frac2)          ? 32'h00000000 :
                     (fp_sign1 === 1 && fp_sign2 === 0)                                               ? 32'h00000001 :
                     (fp_sign1 === 0 && fp_sign2 === 1)                                               ? 32'h00000000 :
                     (fp_sign1 === 0 && fp_sign2 === 0 && fp_exp1 < fp_exp2)                          ? 32'h00000001 :
                     (fp_sign1 === 1 && fp_sign2 === 1 && fp_exp1 > fp_exp2)                          ? 32'h00000000 :
                     (fp_sign1 === 0 && fp_sign2 === 0 && fp_exp1 === fp_exp2 && fp_frac1 < fp_frac2) ? 32'h00000001
                                                                                                      : 32'h00000000;
    assign flt_in1_ack = 1'b1;
    assign flt_in2_ack = 1'b1;
    assign flt_out_stb = 1'b1;

    // FLE
    // NOTE: 雑に実装しているので、NaN などの特殊なケースは考慮していない
    logic [31:0] fle_out;
    logic fle_in1_ack;
    logic fle_in2_ack;
    logic fle_out_stb;

    assign fle_out = (fp_sign1 === fp_sign2 && fp_exp1 === fp_exp2 && fp_frac1 === fp_frac2)          ? 32'h00000001 :
                     (fp_sign1 === 1 && fp_sign2 === 0)                                               ? 32'h00000001 :
                     (fp_sign1 === 0 && fp_sign2 === 1)                                               ? 32'h00000000 :
                     (fp_sign1 === 0 && fp_sign2 === 0 && fp_exp1 < fp_exp2)                          ? 32'h00000001 :
                     (fp_sign1 === 1 && fp_sign2 === 1 && fp_exp1 > fp_exp2)                          ? 32'h00000000 :
                     (fp_sign1 === 0 && fp_sign2 === 0 && fp_exp1 === fp_exp2 && fp_frac1 < fp_frac2) ? 32'h00000001
                                                                                                      : 32'h00000000;
    assign fle_in1_ack = 1'b1;
    assign fle_in2_ack = 1'b1;
    assign fle_out_stb = 1'b1;

endmodule
