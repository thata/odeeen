# マクローリン展開でatan(x)を求める

def my_atan(x)
    result = 0.0
    0.step(10, 1) do |n|
        result += (-1) ** n * x ** (2 * n + 1) / (2 * n + 1)
    end
    return result
end

# Math.atan と比較（CSVへ出力）
open("atan.csv", "w") do |f|
    f.puts "x,my_atan,Math.atan"
    (-1.5).step(1.5, 0.1) do |i|
        x = i.to_f
        f.puts "#{x},#{Math.tan(x)},#{Math.atan(x)}"
        # f.puts "#{x},#{my_atan(x)},#{Math.atan(x)}"
    end
end
