# マクローリン展開でcos(x)を求める

def my_cos(x)

    # 2nの階乗を求める
    def fact(n)
        if n == 0
            return 1
        else
            return (1..n).inject(:*)
        end
    end

    # xの2n乗を求める
    def pow(x, n)
        return x ** n
    end

    # cos(x)を求める
    def cos(x)
        result = 0.0
        0.step(10, 1) do |n|
            result += pow(-1, n) * pow(x, 2 * n) / fact(2 * n)
        end
        return result
    end

    return cos(x)
end

# Math.cos と比較（CSVへ出力）
open("cos.csv", "w") do |f|
    f.puts "x,my_cos,Math.cos"

    -10.step(10, 0.1) do |i|
        x = i.to_f
        f.puts "#{x},#{my_cos(x)},#{Math.cos(x)}"
    end
end
