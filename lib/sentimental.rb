require 'sad_panda'


class Sentimental
  attr_reader :text, :total, :calculated , :sentences, :scores

  def initialize(options)
    @text = options.fetch(:text).to_s.scrub.chomp
    @total = 0 
    @calculated = 0
    @sentences = []
    @scores = []
  end

  def process
    @sentences = @text.split(/((?<=[a-z0-9)][.?!])|(?<=[a-z0-9][.?!]"))\s+(?="?[A-Z])/)
    @sentences.reject! { |c| c.empty? }
    @sentences.each do |s|
      score = SadPanda.polarity(s)
      @scores.push score
      @calculated = @calculated + score
      @total = @total + 10
    end
    @calculated
  end
    
end
