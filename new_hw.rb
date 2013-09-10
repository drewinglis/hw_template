#!/usr/bin/env  rvm 2.0 do ruby

require 'erb'

class TexHW
  def initialize(name, username, dep_num, course_num, hw_num)
    @name = name
    @username = username
    @dep_num = dep_num
    @course_num = course_num
    @hw_num = hw_num
  end
end

USERNAME = ENV['ANDREWID'] || ENV['USER']
NAME = ENV['LEGAL_NAME'] || ENV['NAME'] || USERNAME

puts "using username as name :(" if USERNAME == NAME

begin
  HW_NUM = ARGV[0].to_i
rescue
  puts "usage: ./new_hw.rb hw_num [problem_count]"
  exit
end
begin
  PROBLEM_COUNT = ARGV[1].to_i
rescue # default to 1 if num problems is invalid
  PROBLEM_COUNT = 1
end

match = `pwd`.match(/\/(\d{2})\/(\d{3})/)

while !match
  puts "couldn't parse classes from directory. please enter course number (xx-xxx):"
  match = $stdin.gets.chomp.match(/(\d{2}).{0,1}(\d{3})/)
end

DEPARTMENT_NUM = match[1]
COURSE_NUM = match[2]

filename = File.expand_path(File.dirname(__FILE__)) + "/hw.tex.erb"

erb = ERB.new(File.read(filename))
erb.filename = filename
ERBTexHW = erb.def_class(TexHW, 'render(first_problem_number)')
erb = ERBTexHW.new(NAME, USERNAME, DEPARTMENT_NUM, COURSE_NUM, HW_NUM)

pwd = `pwd`.chomp
problem_number = 1

while (problem_number <= PROBLEM_COUNT)
  outfile ="#{pwd}/#{DEPARTMENT_NUM}#{COURSE_NUM}-#{USERNAME}-hw#{HW_NUM}#{(PROBLEM_COUNT > 1) ? ".#{problem_number}" : ""}.tex" 
  File.open(outfile, "w") do |f|
    f.write erb.render(problem_number)
  end
  problem_number += 1
end
