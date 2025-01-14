# SLD to ASM converter
# usage:
#  ruby script/sld2asm.rb firmware/min-rt/ball.sld > firmware/sld_data.s
ARGF.read.each_byte do |b|
  puts "	.word #{b}	# '#{ b == 10 ? '\n' : b.chr }'"
end

