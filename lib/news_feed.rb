require 'rss'
require 'open-uri'
require 'pry'


class NewsFeed
  attr_reader :url
  
  
  def initialize(options)
    @url   = options.fetch(:url)
  end
  
  
  def get_feed
    toreturn = []
    url = @url
    open(url) do |rss|
      feed = RSS::Parser.parse(rss)
      feed.items.each do |item|
        binding.pry
        toreturn.push "#{feed.channel.title}  \n #{item.title}  \n    #{item.description}"
      end
    end
    toreturn
  end

end