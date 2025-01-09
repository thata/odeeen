def my_sin(x)
  x = adjustx(x)
  x2 = x * x
  x3 = x2 * x
  x5 = x3 * x2
  x7 = x5 * x2
  x9 = x7 * x2
  x - x3 / 6 + x5 / 120 - x7 / 5040 + x9 / 362880
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

# Math.sin と比較（CSVへ出力）
open("sin.csv", "w") do |f|
  f.puts "x,my_sin,Math.sin"
  -15.step(15, 0.1) do |i|
    x = i.to_f
    f.puts "#{x},#{my_sin(x)},#{Math.sin(x)}"
  end
end
