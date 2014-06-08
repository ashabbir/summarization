require 'fetcher'
require_relative 'lib/summarize'
require_relative 'lib/mail_processor'
require 'pry'
require 'dotenv'




fetcher = Fetcher.create(:type => :imap, :receiver => MailProcessor, :server => 'imap.gmail.com',
                        :username => ENV['EMAIL_USER'], :password => ENV['EMAIL_PASSWORD'], :ss => true, :port => 993)


fetcher.fetch
