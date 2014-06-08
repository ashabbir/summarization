require 'ots'
require 'open-uri'
require 'cgi'
require 'pry'

arr = Array.new



unless File.file?('test.txt')
  f = open('http://icourse.cuc.edu.cn/computernetworks/labs/alice.txt').read
  File.open("test.txt", 'w') { |file| file.write(f) }
end



File.open("converted.htm", "w") do |fileHtml|
  fileHtml.puts "<HTML>"
  fileHtml.puts "<BODY>"
end


File.readlines("test.txt").each  do |line|
  article = OTS.parse(line)
  a = article.summarize(percent: 25)
  a.each do |x|
    x[:sentence] = x[:sentence].gsub("\n", "<br/>")
    if x[:score].to_i > 25
      arr.push "<span class='highlighted' style='background: #fff2a8;'>" + x[:sentence] + "</span>"
    else
      arr.push  x[:sentence]
    end
  end
end
puts "summerized"



File.open("converted.htm", "a") do |f|
  f.puts(arr)
  f.puts "</BODY></HTML>"
end 


File.open("converted.htm", "a") do |fileHtml|
  fileHtml.puts "</BODY></HTML>"
end

