# 以下のアルゴリズムで平方根を求める
# https://cpplover.blogspot.com/2010/11/blog-post_20.html

def sqrt(s)
  x = s / 2.0
  last_x = 0.0

  while x != last_x
    last_x = x
    x = (x + s / x) / 2.0
  end
  x
end

10.times do |i|
  printf "my sqrt: %f, Ruby sqrt: %f\n", sqrt(i), Math.sqrt(i)
end
