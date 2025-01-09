all: sin.png cos.png atan.png

sin.csv: sin.rb
	ruby sin.rb

cos.csv: cos.rb
	ruby cos.rb

atan.csv: atan.rb
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
