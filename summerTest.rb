require 'ots'
require 'open-uri'

arr = Array.new

if File.file?('test.txt')
  
else
  f = open('http://icourse.cuc.edu.cn/computernetworks/labs/alice.txt').read
  File.open("test.txt", 'w') { |file| file.write(f) }
  puts 'file saved'
end
  
  
File.readlines("test.txt").each  do |line| 
  article = OTS.parse(line)
  a = article.summarize(percent: 25)
  a.each do |x|
    arr.push x[:sentence]
  end
end

File.delete("converted.txt")
File.open("converted.txt", "w+") do |f|
  f.puts(arr)
end 

