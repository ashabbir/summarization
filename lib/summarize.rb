require 'ots'


class Summarize
  attr_reader :text, :percent, :result , :cutoff_percent, :cutoff , :spanned

  def initialize(options)
    @text = options.fetch(:text).to_s.scrub
    @percent =  options.fetch(:percent){25}
    @cutoff_percent =  options.fetch(:cutoff_percent){ @percent}
    @spanned = []
  end

  def process
    @result = OTS.parse(text).summarize(percent: percent)
    @result
  end
  
  def calculate_cutoff
    arr = Array.new
    @result.each {|x|  arr.push  x[:score]  }
    arr = arr.sort
    ind = (arr.length * @cutoff_percent  ) / 100
    @cutoff =  arr[ind]
    @cutoff
  end
  
  
  def highlight
    @result.each do |x|
      x[:sentence] = x[:sentence].gsub("\n \n", "<p>").gsub("\r\n", "<p>")
      if x[:score].to_i > @cutoff
        @spanned << "<span class='highlighted' style='background: #fff2a8;'>" + x[:sentence] + "</span>"
      else
        @spanned <<  x[:sentence]
      end
    end
    @spanned
  end
  
  
end
