require 'ots'
require 'open-uri'
require 'cgi'
require './lib/summarize'
require 'pry'

unless File.file?('test.txt')
  f = open('http://icourse.cuc.edu.cn/computernetworks/labs/alice.txt').read
  File.open("test.txt", 'w') { |file| file.write(f) }
end



data = File.open('test.txt').read
s = Summarize.new text: data

arr = []
s.process.each do |x|
  x[:sentence] = x[:sentence].gsub("\n", "<br/>")

  if x[:score].to_i > 25
    arr << "<span class='highlighted' style='background: #fff2a8;'>" + x[:sentence] + "</span>"
  else
    arr <<  x[:sentence]
  end
end





puts "summerized"

html =<<HTML
<HTML>
<BODY>
#{arr.join}
</BODY>
</HTML>
HTML


File.open("converted.htm", "w") do |fileHtml|
  fileHtml.puts html
end
