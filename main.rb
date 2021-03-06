require 'sinatra'
require 'yaml'
require 'pry'
require 'json'
require 'sinatra/reloader' if development?
require_relative 'lib/file_processor'
require_relative 'lib/summarize'
require_relative 'lib/mail_reader'
require_relative 'lib/news_feed'
require_relative 'lib/sentimental'



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
  s = Summarize.new text: @data, percent: 7, cutoff_percent: 50
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
  summarize = params[:summarize]
  highlight = params[:highlight]
  days = params[:days]
  m = MailReader.new username: username , password: password
  @msg = m.process days.to_i
  @arr = []
  @msg.each do |m| 
    s = Summarize.new text: m, percent: summarize.to_i, cutoff_percent: highlight.to_i
    s.process
    s.calculate_cutoff
    @arr.push s.highlight.join
  end
  @arr = @arr.reverse
  erb :result
end


get '/rss' do
  rss_reader = NewsFeed.new url: 'http://rss.cnn.com/rss/cnn_world.rss'
  @feed = rss_reader.get_feed
  @arr = []
  @feed.each do |m| 
    s = Summarize.new text: m, percent: 90, cutoff_percent: 10
    s.process
    s.calculate_cutoff
    @arr.push s.highlight.join
  end
  
  rss_reader = NewsFeed.new url: 'http://rss.cnn.com/rss/cnn_topstories.rss'
  @feed = rss_reader.get_feed
  @feed.each do |m| 
    s = Summarize.new text: m, percent: 90, cutoff_percent: 10
    s.process
    s.calculate_cutoff
    @arr.push s.highlight.join
  end
  
  erb :result
end



post '/summarize' do
  content_type :json  
  request.body.rewind
  json = request.body.read
  json = json.scrub.gsub(/\r/, " ").gsub(/\n/, " ").strip
  
  @request_payload = JSON.parse json, :quirks_mode => true
  word_count = @request_payload["word"].to_f
  text = @request_payload["text"]
  total = text.split.size.to_f
  pct = (word_count / total) * 100
  @summary = []  
  s = Summarize.new text: text, percent: pct, cutoff_percent: 0
  s.process
  @summary = s.plaintext.join
  sen = Sentimental.new text: @summary
  sen.process
  @result = Hash["total_sentiment" => sen.total, "calculated_sentiment" => sen.calculated , 
    "summmary" => @summary , "verdict" => sen.verdict , "score_part" => sen.scores]
  @result.to_json
end


get '/sentiment' do
  content_type :json  
  config = YAML.load_file File.expand_path('./config.yml', File.dirname(__FILE__))
  drop = config[:drop_path]
  drop = File.expand_path(".././drop/" , __FILE__) + '/'
  fetcher = FileProcessor.new name: "test.txt" ,  drop: drop
  fetcher.fetch_if_needed
  text = fetcher.open_file
  
  s = Sentimental.new text: text
  s.process
  @result = Hash["total" => s.total, "scores" => s.scores , "sentences" => s.sentences , "calculated" => s.calculated]
  @result.to_json
end

