# レイトレサーバ
#  自作CPUから送られてくるレイトレデータを受信する。
#  受信が終わった頃を見計らって、Ctrl+C で終了する。
#
#  usage: ruby script/server.rb > contest.ppm

require 'rubyserial'

begin
  serialport = Serial.new '/dev/cu.usbserial-D00084', 115200

  # 不要なデータを読み捨て
  while serialport.getbyte
    # 何もしない
  end

  # 自作CPUに送信開始を依頼
  serialport.write " "

  # UART読み込み
  while true
    puts serialport.gets
    $stderr.puts "receiving..."
  end
rescue Interrupt
  serialport.close
end
