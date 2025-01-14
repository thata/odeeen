puts "	.text"
puts "	.align 4"
puts "	.globl sld_data"
puts "sld_data:"

ARGF.read.each_byte do |b|
  puts "	.word #{b}	// '#{ b == 10 ? '\n' : b.chr }'"
end

