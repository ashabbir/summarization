require 'json'
require 'ots'

class Summarize
  attr_reader :text, :percent

  def initialize(options)
    @text = options.fetch(:text)
    @percent =  options.fetch(:percent){25}
  end

  def process
    OTS.parse(line).summarize(percent: percent).to_json
  end
end
