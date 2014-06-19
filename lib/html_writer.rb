require 'ots'
require 'open-uri'
require 'cgi'
require './summarize'
require 'pry'

unless File.file?('test.txt')
  f = open('http://icourse.cuc.edu.cn/computernetworks/labs/alice.txt').read
  File.open("test.txt", 'w') { |file| file.write(f) }
end



data = File.open('test.txt').read
s = Summarize.new text: data, percent: 25
arr = []
s.process
s.cutoff
arr = s.highlight





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
