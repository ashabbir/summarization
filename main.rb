require 'sinatra'
require 'yaml'
require 'pry'
require 'sinatra/reloader' if development?
require_relative 'lib/file_processor'
require_relative 'lib/summarize'
require_relative 'lib/mail_reader'



set :static, true
set :root, File.dirname(__FILE__)
set :public, 'public'




not_found do
  erb :not_found
end



# login 
get '/' do
  erb :login, :layout => false
end




# login 
get '/contact' do
  erb :contact
end



get '/cnn' do

  config = YAML.load_file File.expand_path('./config.yml', File.dirname(__FILE__))
  drop = config[:drop_path]
  drop = File.expand_path(".././drop/" , __FILE__) + '/'
  fetcher = FileProcessor.new name: "test.txt" ,  drop: drop
  fetcher.fetch_if_needed
  @data = fetcher.open_file
  s = Summarize.new text: @data, percent: 70, cutoff_percent: 50
  s.process
  s.calculate_cutoff
  @arr = s.highlight
  @data = @data.gsub("\r\n", "<p>")
  erb :summary
  
end


get '/alice' do

  config = YAML.load_file File.expand_path('./config.yml', File.dirname(__FILE__))
  drop = config[:drop_path]
  drop = File.expand_path(".././drop/" , __FILE__) + '/'
  fetcher = FileProcessor.new name: "text.txt" ,  url: 'http://icourse.cuc.edu.cn/computernetworks/labs/alice.txt' , drop: drop
  fetcher.fetch_if_needed
  @data = fetcher.open_file
  s = Summarize.new text: @data, percent: 70, cutoff_percent: 50
  s.process
  s.calculate_cutoff
  @arr = s.highlight
  @data = @data.gsub("\r\n", "<p>")
  erb :summary
  
end



get '/gmail' do
  erb :gmail
end

post '/gmail' do
  username = params[:user_name]
  password = params[:password]
  days = params[:days]
  m = MailReader.new username: username , password: password
  @msg = m.process days.to_i
  @arr = []
  @msg.each do |m| 
    s = Summarize.new text: m, percent: 70, cutoff_percent: 50
    s.process
    s.calculate_cutoff
    @arr.push s.highlight.join
  end
  
  erb :gmail_result
end



