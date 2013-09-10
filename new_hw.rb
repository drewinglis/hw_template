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

USERNAME = (ENV['ANDREWID'] || ENV['USER']).downcase.gsub(/[^\w]/, "")
NAME = ENV['LEGAL_NAME'] || ENV['NAME'] || USERNAME

puts "using username as name :(" if USERNAME == NAME

HW_NUM = ARGV[0]
if !HW_NUM
  puts "usage: ./new_hw.rb hw_num [problem_count]" 
  exit
end

begin
  PROBLEM_COUNT = ARGV[1].to_i
rescue # default to 1 if num problems is invalid
  PROBLEM_COUNT = 1
end

classname_regex = /\/(\d{2}).{0,1}(\d{3}[A-Za-z]{0,1})/

pwd = `pwd`.strip
match = pwd.match(classname_regex)

while !match
  puts "couldn't parse classes from directory. please enter course number (xx-xxx):"
  match = $stdin.gets.chomp.match(classname_regex)
end

DEPARTMENT_NUM = match[1]
COURSE_NUM = match[2]

filename = File.expand_path(File.dirname(__FILE__)) + "/hw.tex.erb"

erb = ERB.new(File.read(filename))
erb.filename = filename
ERBTexHW = erb.def_class(TexHW, 'render(first_problem_number)')
erb = ERBTexHW.new(NAME, USERNAME, DEPARTMENT_NUM, COURSE_NUM, HW_NUM)

problem_number = 1

while (problem_number <= PROBLEM_COUNT)
  course = "#{DEPARTMENT_NUM}#{COURSE_NUM}"
  hw_name = "hw#{HW_NUM.downcase.gsub(/[^\w]/, "")}#{(PROBLEM_COUNT > 1) ? ".#{problem_number}" : ""}"
  outfile = "#{pwd}/#{course}-#{USERNAME}-#{hw_name}.tex" 
  File.open(outfile, "w") do |f|
    f.write erb.render(problem_number)
  end
  problem_number += 1
end
