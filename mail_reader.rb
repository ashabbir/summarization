require_relative 'lib/summarize'
require_relative 'lib/mail_processor'
require 'dotenv'
require 'pry'
require 'gmail'

Dotenv.load


Gmail.new(ENV['EMAIL_USER'], ENV['EMAIL_PASSWORD']) do |gmail|
binding.pry
end
