#!/usr/local/bin/ruby -Ks
# coding: cp932

require 'readline'

IO.popen("cmd.exe /A /Q", "a") do |cmd|
  loop do
    buf = Readline.readline('', true)
    if buf.nil?
      cmd.puts "\x1a"
      puts
    else 
      Readline::HISTORY.pop if buf =~ /\A\s*\Z/
      if buf.size == 0
        cmd.puts "\x1a"
      elsif buf == 'exit'
        exit 0
      else
        p "-#{buf.length}-#{buf}--" if $DEBUG
        cmd.puts buf
      end
    end
  end
end

