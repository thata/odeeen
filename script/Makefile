all: sin.png cos.png atan.png

sin.csv:
	ruby sin.rb

cos.csv:
	ruby cos.rb

atan.csv:
	ruby atan.rb

sin.png: sin.csv
	gnuplot plot-sin.gnu

cos.png: cos.csv
	gnuplot plot-cos.gnu

atan.png: atan.csv
	gnuplot plot-atan.gnu

open: sin.png cos.png atan.png
	open sin.png
	open cos.png
	open atan.png

clean:
	rm -f sin.csv cos.csv atan.csv sin.png cos.png atan.png
