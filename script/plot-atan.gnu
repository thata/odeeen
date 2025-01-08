set terminal pngcairo size 800,800  # 出力形式とサイズを指定
set output "atan.png"  # 出力ファイル名を指定

set datafile separator ","
set title "Comparison of my_sin and Math.sin"
set xlabel "x"
set ylabel "y"
set grid

plot "atan.csv" using 1:2 with lines title "my_atan", \
     "atan.csv" using 1:3 with lines title "Math.sin"
