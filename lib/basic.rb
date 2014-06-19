require 'sinatra'
require 'sinatra/reloader' if development?



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
