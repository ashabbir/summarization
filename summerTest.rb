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
#  a = article.summarize(percent: 80)
  b = article.summarize(sentences: 1 , percent: 5)
  b.each do |x|
    arr.push x[:sentence]
  end
end
if File.file?('converted.txt')
  File.delete("converted.txt")
  puts "file deleted"
end

File.open("converted.txt", "w+") do |f|
  f.puts(arr)
end 

