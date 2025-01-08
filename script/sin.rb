def my_sin(x)
  # マクローリン展開でsin(x)を求める

    # 2n+1の階乗を求める
    def fact(n)
        if n == 0
            return 1
        else
            return (1..n).inject(:*)
        end
    end

    # xの2n+1乗を求める
    def pow(x, n)
        return x ** n
    end

    # sin(x)を求める
    def sin(x)
        result = 0.0
        0.step(10, 1) do |n|
            result += pow(-1, n) * pow(x, 2 * n + 1) / fact(2 * n + 1)
        end
        return result
    end

    return sin(x)

end

# Math.sin と比較（CSVへ出力）
open("sin.csv", "w") do |f|
    f.puts "x,my_sin,Math.sin"

    -10.step(10, 0.1) do |i|
        x = i.to_f
        f.puts "#{x},#{my_sin(x)},#{Math.sin(x)}"
    end
end
