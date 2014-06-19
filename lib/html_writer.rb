require 'ots'
require 'open-uri'
require 'cgi'
require './summarize'
require 'pry'


data = File.open(File.expand_path('../drop/') + '/test.txt').read
s = Summarize.new text: data, percent: 70, cutoff_percent: 50
arr = []
s.process
s.calculate_cutoff
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
