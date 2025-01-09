# マクローリン展開でatan(x)を求める

def my_atan(x)
  x2 = x * x
  x3 = x2 * x
  x5 = x3 * x2
  x7 = x5 * x2
  x9 = x7 * x2
  x11 = x9 * x2
  x13 = x11 * x2
  x15 = x13 * x2
  x17 = x15 * x2
  x19 = x17 * x2
  x21 = x19 * x2
  x23 = x21 * x2
  x25 = x23 * x2
  x27 = x25 * x2
  x29 = x27 * x2
  x31 = x29 * x2
  x33 = x31 * x2
  x35 = x33 * x2
  x37 = x35 * x2
  x39 = x37 * x2
  x41 = x39 * x2
  x43 = x41 * x2
  x45 = x43 * x2
  x47 = x45 * x2
  x49 = x47 * x2
  x51 = x49 * x2
  x53 = x51 * x2
  x55 = x53 * x2
  x57 = x55 * x2
  x59 = x57 * x2
  x61 = x59 * x2
  x63 = x61 * x2
  x65 = x63 * x2
  x67 = x65 * x2
  x69 = x67 * x2
  x71 = x69 * x2
  x73 = x71 * x2
  x75 = x73 * x2
  x77 = x75 * x2
  x79 = x77 * x2
  x81 = x79 * x2
  x83 = x81 * x2
  x85 = x83 * x2
  x87 = x85 * x2
  x89 = x87 * x2
  x91 = x89 * x2
  x93 = x91 * x2
  x95 = x93 * x2
  x97 = x95 * x2
  x99 = x97 * x2

  x - x3 / 3 + x5 / 5 - x7 / 7 + x9 / 9 - x11 / 11 + x13 / 13 - x15 / 15 + x17 / 17 - x19 / 19 + x21 / 21 - x23 / 23 + x25 / 25 - x27 / 27 + x29 / 29 - x31 / 31 + x33 / 33 - x35 / 35 + x37 / 37 - x39 / 39 + x41 / 41 - x43 / 43 + x45 / 45 - x47 / 47 + x49 / 49 - x51 / 51 + x53 / 53 - x55 / 55 + x57 / 57 - x59 / 59 + x61 / 61 - x63 / 63 + x65 / 65 - x67 / 67 + x69 / 69 - x71 / 71 + x73 / 73 - x75 / 75 + x77 / 77 - x79 / 79 + x81 / 81 - x83 / 83 + x85 / 85 - x87 / 87 + x89 / 89 - x91 / 91 + x93 / 93 - x95 / 95 + x97 / 97 - x99 / 99
end

# Math.atan と比較（CSVへ出力）
open("atan.csv", "w") do |f|
  f.puts "x,my_atan,Math.atan"
  # (-1.5).step(1.5, 0.1) do |i|
  (-1.05).step(1.05, 0.01) do |i|
    x = i.to_f
    f.puts "#{x},#{my_atan(x)},#{Math.atan(x)}"
    # f.puts "#{x},#{Math.atan(x)},#{Math.atan(x)}"
  end
end
