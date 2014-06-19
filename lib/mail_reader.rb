require_relative 'lib/summarize'
require_relative 'lib/mail_processor'
require 'dotenv'
require 'pry'
require 'gmail'

Dotenv.load


Gmail.new(ENV['EMAIL_USER'], ENV['EMAIL_PASSWORD']) do |gmail|
  gmail.peek = true
  gmail.inbox.emails(:after => Date.parse("2014-06-06")).each do |x|
    s = Summarize.new text: x.text_part.body
    arr = s.process
    puts arr
    puts "---"
    puts s.text
    puts "***********"
  end
  
  
end
