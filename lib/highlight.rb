require 'ots'

class highlight
  attr_reader :text, :percent

  def initialize(options)
    @text = options.fetch(:text)
    @percent =  options.fetch(:percent){25}
  end

  def process
    OTS.parse(text).summarize(percent: percent)
  end
end
