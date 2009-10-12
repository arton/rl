#!/usr/local/bin/ruby -Ks
# coding: cp932

require 'readline'

IO.popen("cmd.exe /A", "a") do |cmd|
  Thread.start do
    while s = cmd.gets.rstrip
      puts s
    end
  end
  while buf = Readline.readline('', true)
    if buf == 'exit'
      exit 0
    end
    cmd.puts buf
  end
end

