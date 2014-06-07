require 'ots'
require 'open-uri'

arr = Array.new



unless File.file?('test.txt')
  f = open('http://icourse.cuc.edu.cn/computernetworks/labs/alice.txt').read
  File.open("test.txt", 'w') { |file| file.write(f) }
end
  
  
File.readlines("test.txt").each  do |line| 
  article = OTS.parse(line)
  a = article.summarize(percent: 25)
  a.each do |x|
    arr.push x[:sentence] if x[:score].to_i > 25
  end
end

File.open("converted.txt", "w") do |f|
  f.puts(arr)
end 

