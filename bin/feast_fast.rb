#!/usr/bin/env ruby
# coding: utf-8

require File.expand_path(File.join(File.dirname(__FILE__), %w[.. lib feast_fast]))

if ARGV.any? && ARGV.size == 3
  begin
    d1 = FeastFast::Day.new(ARGV[0].to_i, ARGV[1].to_i, ARGV[2].to_i)
  rescue Exception => e
    puts "Не удалось сформировать дату"
    puts e
    exit 1
  end
else
  d1 = FeastFast::Day.today
end

puts "====================="
puts "Дата:      #{d1}"
puts "Пост:      #{d1.fast}"
if d1.feasts.any?
  d1.feasts.each_with_index do |feast, index|
    if index == 0
      puts "Праздники: #{feast}"
    else 
      puts "           #{feast}"
    end
  end
else
  puts "Праздники: Нет праздников"
end