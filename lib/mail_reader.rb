require 'pry'
require 'date'
require 'gmail'

class MailReader
  attr_reader :email_username , :email_password, :days
  
  def initialize(options)
    @email_username   = options.fetch(:username)
    @email_password = options.fetch(:password)
  end
  
  def process days
    toreturn = []
    date  = DateTime.now - days
    Gmail.new(@email_username, @email_password) do |gmail|
      gmail.peek = true
      gmail.inbox.emails(:after => date ).each do |x|
        msg = clean x.message.body.to_s
        toreturn.push msg
      end
    end  
    toreturn
  end
  
  def clean text
      re = /<("[^"]*"|'[^']*'|[^'">])*>/
      text.gsub!(re, ' ')
    end
    
end




