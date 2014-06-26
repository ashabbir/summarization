require 'sad_panda'


class Sentimental
  attr_reader :text, :total, :calculated , :sentences, :scores , :verdict

  def initialize(options)
    @text = options.fetch(:text).to_s.scrub.chomp
    @total = 0 
    @calculated = 0
    @sentences = []
    @scores = []
    @verdict ="undecided"
  end

  def process
    @sentences = @text.split(/((?<=[a-z0-9)][.?!])|(?<=[a-z0-9][.?!]"))\s+(?="?[A-Z])/)
    @sentences.reject! { |c| c.empty? }
    @sentences.each do |s|
      score = SadPanda.polarity(s)
      score = score.to_f / 10
      @scores.push score
      @calculated = @calculated + score
      @total = @total + 1
    end
    @verdict = SadPanda.emotion(@text)
    @calculated

  end
    
end
