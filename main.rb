require 'sinatra'
require 'pry'
require 'json'
require 'yaml'
require 'sinatra/reloader' if development?
require_relative 'lib/file_processor'


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



get '/test' do

  config = YAML.load_file File.expand_path('./config.yml', File.dirname(__FILE__))
  drop = config[:drop_path]
  
  fetcher = FileProcessor.new name: "alice.txt" ,  url: 'http://icourse.cuc.edu.cn/computernetworks/labs/alice.txt' , drop: drop
  fetcher.fetch_if_needed
#  binding.pry  
  fetcher.open_file.to_json
  
end