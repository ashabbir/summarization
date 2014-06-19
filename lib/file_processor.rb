require 'open-uri'
require 'pry'


class FileProcessor
  attr_reader :name, :url, :drop_location, :final_path
  
  def initialize(options)
    @name   = options.fetch(:name)
    @url    = options.fetch(:url)
    @drop_location = options.fetch(:drop)
    @final_path = @drop_location + @name
  end

  def fetch_if_needed

    unless File.file?(@final_path)
      f = open(@url).read
      File.open(@final_path, 'w') { |file| file.write(f) }
    end
  end
  
  
  def open_file
    toreturn = Array.new
    File.readlines(@final_path).each  do |line|
      toreturn.push line
    end
    toreturn
  end


    
end
