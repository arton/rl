#!/usr/local/bin/ruby -Ks
# coding: cp932

require 'readline'

def mode(m)
  if m == 'vi'
    Readline.vi_editing_mode
  elsif m == 'emacs'  
    Readline.emacs_editing_mode
  end
end

IO.popen("#{ENV['ComSpec']} /A /Q", "w") do |cmd|
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
      elsif buf[0] == ?:
        mode buf[1..-1].lstrip
        cmd.puts
      else
        p "-#{buf.length}-#{buf}--" if $DEBUG
        cmd.puts buf
      end
    end
  end
end

