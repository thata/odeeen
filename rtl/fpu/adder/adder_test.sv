 `timescale 1ns/1ps

 // adder.v のテストベンチ
module adder_test;
    reg clk;
    reg rst;
    reg [31:0] input_a, input_b;
    reg input_a_stb, input_b_stb;
    logic input_a_ack, input_b_ack;
    logic [31:0] output_z;
    logic output_z_stb;
    reg output_z_ack;

    adder adder_inst (
        .clk(clk),
        .rst(rst),
        .input_a(input_a),
        .input_a_stb(input_a_stb),
        .input_a_ack(input_a_ack),
        .input_b(input_b),
        .input_b_stb(input_b_stb),
        .input_b_ack(input_b_ack),
        .output_z(output_z),
        .output_z_stb(output_z_stb),
        .output_z_ack(output_z_ack)
    );

    initial begin
        clk = 0;
        input_a_stb = 0;
        input_b_stb = 0;
        output_z_ack = 0;

        $dumpfile("adder_test.vcd");
        $dumpvars(0, adder_test);

        // リセット
        rst = 1;
        #10;
        rst = 0;
        #10;

        //----------------------------------------------------------------------
        // 0.0 + 0.0 = 0.0
        //----------------------------------------------------------------------

        // a と b をセット
        input_a = 32'b0_00000000_00000000000000000000000; // a = 0.0
        input_b = 32'b0_00000000_00000000000000000000000; // b = 0.0
        input_a_stb = 1;
        input_b_stb = 1;
        output_z_ack = 0; // 入力が受理される前に z_ack をデアサートしておく

        // z_stb がアサートされるまで待機
        wait(output_z_stb);

        // z の出力を確認（z = 0.0）
        assert(output_z == 32'h00000000) $display("PASSED"); else $display("FAILED");

        // 結果を見終えたら z_ack を返す
        // 同じタイミングで a_stb と b_stb をデアサートしておく
        output_z_ack = 1;
        input_a_stb = 0;
        input_b_stb = 0;
        #20;

        //----------------------------------------------------------------------
        // 1.0 + 1.0 = 2.0
        //----------------------------------------------------------------------

        // a と b をセット
        input_a = 32'b0_01111111_00000000000000000000000; // a = 1.0
        input_b = 32'b0_01111111_00000000000000000000000; // b = 1.0
        input_a_stb = 1;
        input_b_stb = 1;
        output_z_ack = 0; // 入力が受理される前に z_ack をデアサートしておく

        // z_stb がアサートされるまで待機
        wait(output_z_stb);

        // z の出力を確認（z = 2.0）
        assert(output_z == 32'b0_10000000_00000000000000000000000) $display("PASSED"); else $display("FAILED: %b", output_z);

        // a_stb と b_stb をデアサートしてから、z_ack を返す
        input_a_stb = 0;
        input_b_stb = 0;
        output_z_ack = 1;
        #20;

        $finish;
    end

    // 5ns ごとに clk を反転
    always #5
        clk <= ~clk;
endmodule