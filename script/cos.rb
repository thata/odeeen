def my_cos(x)
  x = adjustx(x)
  x2 = x * x
  x4 = x2 * x2
  x6 = x4 * x2
  x8 = x6 * x2
  x10 = x8 * x2
  1 - x2 / 2 + x4 / 24 - x6 / 720 + x8 / 40320 - x10 / 3628800
end

# x が -PI から PI までの範囲に収まるようにして返す
# 例)
#  x = 3 → 3
#  x = -3 → -3
#  x = 3.2 → -3.083185307179586
#  x = -3.2 → 3.083185307179586
#  x = 6.5 → 0.641592653589793
#  x = -6.5 → -0.641592653589793
def adjustx(x)
  if x > Math::PI
    adjustx(x - 2 * Math::PI)
  elsif x < -Math::PI
    adjustx(x + 2 * Math::PI)
  else
    x
  end
end

# Math.cos と比較（CSVへ出力）
open("cos.csv", "w") do |f|
  f.puts "x,my_cos,Math.cos"
  -10.step(10, 0.1) do |i|
    x = i.to_f
    f.puts "#{x},#{my_cos(x)},#{Math.cos(x)}"
  end
end
