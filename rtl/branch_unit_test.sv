// 条件分岐判定ユニットのテストベンチ
module branch_unit_test;
    logic [31:0] in1, in2;
    logic [2:0] funct3;
    logic result;

    branch_unit dut(
        .in1(in1),
        .in2(in2),
        .funct3(funct3),
        .result(result)
    );

    initial begin
        //------------------------------------------------------------------
        // beq
        //------------------------------------------------------------------

        // 0x00000000 == 0x00000000
        in1 = 32'h00000000; in2 = 32'h00000000;
        funct3 = 3'b000;
        #10
        assert (
            result === 1'b1
        ) $display("PASSED"); else $display("FAILED %h", result);

        // 0x00000000 == 0xFFFFFFFF
        in1 = 32'h00000000; in2 = 32'hFFFFFFFF;
        funct3 = 3'b000;
        #10
        assert (
            result === 1'b0
        ) $display("PASSED"); else $display("FAILED %h", result);

        //------------------------------------------------------------------
        // bne
        //------------------------------------------------------------------

        // 0x00000000 != 0x00000000
        in1 = 32'h00000000; in2 = 32'h00000000;
        funct3 = 3'b001;
        #10
        assert (
            result === 1'b0
        ) $display("PASSED"); else $display("FAILED %h", result);

        // 0x00000000 != 0xFFFFFFFF
        in1 = 32'h00000000; in2 = 32'hFFFFFFFF;
        funct3 = 3'b001;
        #10
        assert (
            result === 1'b1
        ) $display("PASSED"); else $display("FAILED %h", result);

        //------------------------------------------------------------------
        // blt
        //------------------------------------------------------------------

        // 0x00000000 < 0x00000000
        in1 = 32'h00000000; in2 = 32'h00000000;
        funct3 = 3'b100;
        #10
        assert (
            result === 1'b0
        ) $display("PASSED"); else $display("FAILED %h", result);

        // 0x00000000 < 0xFFFFFFFF
        // 符号付きで比較されるため、0xFFFFFFFF は -1 として扱われる
        in1 = 32'h00000000; in2 = 32'hFFFFFFFF;
        funct3 = 3'b100;
        #10
        assert (
            result === 1'b0
        ) $display("PASSED"); else $display("FAILED %h", result);

        // 0xFFFFFFFF < 0x00000000
        // 符号付きで比較されるため、0xFFFFFFFF は -1 として扱われる
        in1 = 32'hFFFFFFFF; in2 = 32'h00000000;
        funct3 = 3'b100;
        #10
        assert (
            result === 1'b1
        ) $display("PASSED"); else $display("FAILED %h", result);

        // 0xFFFFFFFF < 0xFFFFFFFF
        // 符号付きで比較されるため、0xFFFFFFFF は -1 として扱われる
        in1 = 32'hFFFFFFFF; in2 = 32'hFFFFFFFF;
        funct3 = 3'b100;
        #10
        assert (
            result === 1'b0
        ) $display("PASSED"); else $display("FAILED %h", result);

        //------------------------------------------------------------------
        // bge
        //------------------------------------------------------------------

        // 0x00000000 >= 0x00000000
        in1 = 32'h00000000; in2 = 32'h00000000;
        funct3 = 3'b101;
        #10
        assert (
            result === 1'b1
        ) $display("PASSED"); else $display("FAILED %h", result);

        // 0x00000000 >= 0xFFFFFFFF
        // 符号付きで比較されるため、0xFFFFFFFF は -1 として扱われる
        in1 = 32'h00000000; in2 = 32'hFFFFFFFF;
        funct3 = 3'b101;
        #10
        assert (
            result === 1'b1
        ) $display("PASSED"); else $display("FAILED %h", result);

        // 0xFFFFFFFF >= 0x00000000
        // 符号付きで比較されるため、0xFFFFFFFF は -1 として扱われる
        in1 = 32'hFFFFFFFF; in2 = 32'h00000000;
        funct3 = 3'b101;
        #10
        assert (
            result === 1'b0
        ) $display("PASSED"); else $display("FAILED %h", result);

        // 0xFFFFFFFF >= 0xFFFFFFFF
        // 符号付きで比較されるため、0xFFFFFFFF は -1 として扱われる
        in1 = 32'hFFFFFFFF; in2 = 32'hFFFFFFFF;
        funct3 = 3'b101;
        #10
        assert (
            result === 1'b1
        ) $display("PASSED"); else $display("FAILED %h", result);

        //------------------------------------------------------------------
        // bltu
        //------------------------------------------------------------------

        // 0x00000000 < 0x00000000
        in1 = 32'h00000000; in2 = 32'h00000000;
        funct3 = 3'b110;
        #10
        assert (
            result === 1'b0
        ) $display("PASSED"); else $display("FAILED %h", result);

        // 0x00000000 < 0xFFFFFFFF
        // 符号なしで比較されるため、0xFFFFFFFF は 4294967295 として扱われる
        in1 = 32'h00000000; in2 = 32'hFFFFFFFF;
        funct3 = 3'b110;
        #10
        assert (
            result === 1'b1
        ) $display("PASSED"); else $display("FAILED %h", result);

        // 0xFFFFFFFF < 0x00000000
        // 符号なしで比較されるため、0xFFFFFFFF は 4294967295 として扱われる
        in1 = 32'hFFFFFFFF; in2 = 32'h00000000;
        funct3 = 3'b110;
        #10
        assert (
            result === 1'b0
        ) $display("PASSED"); else $display("FAILED %h", result);

        // 0xFFFFFFFF < 0xFFFFFFFF
        // 符号なしで比較されるため、0xFFFFFFFF は 4294967295 として扱われる
        in1 = 32'hFFFFFFFF; in2 = 32'hFFFFFFFF;
        funct3 = 3'b110;
        #10
        assert (
            result === 1'b0
        ) $display("PASSED"); else $display("FAILED %h", result);

        //------------------------------------------------------------------
        // bgeu
        //------------------------------------------------------------------

        // 0x00000000 >= 0x00000000
        in1 = 32'h00000000; in2 = 32'h00000000;
        funct3 = 3'b111;
        #10
        assert (
            result === 1'b1
        ) $display("PASSED"); else $display("FAILED %h", result);

        // 0x00000000 >= 0xFFFFFFFF
        // 符号なしで比較されるため、0xFFFFFFFF は 4294967295 として扱われる
        in1 = 32'h00000000; in2 = 32'hFFFFFFFF;
        funct3 = 3'b111;
        #10
        assert (
            result === 1'b0
        ) $display("PASSED"); else $display("FAILED %h", result);

        // 0xFFFFFFFF >= 0x00000000
        // 符号なしで比較されるため、0xFFFFFFFF は 4294967295 として扱われる
        in1 = 32'hFFFFFFFF; in2 = 32'h00000000;
        funct3 = 3'b111;
        #10
        assert (
            result === 1'b1
        ) $display("PASSED"); else $display("FAILED %h", result);
    end

endmodule
