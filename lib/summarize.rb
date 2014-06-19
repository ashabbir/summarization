require 'ots'
class Summarize
  attr_reader :text, :percent, :result , :cutoff , :spanned

  def initialize(options)
    @text = options.fetch(:text).to_s.scrub
    @percent =  options.fetch(:percent){25}
    @spanned = []
  end

  def process
    @result = OTS.parse(text).summarize(percent: percent)
    @result
  end
  
  def cutoff
    arr = Array.new
    @result.each {|x|  arr.push  x[:score]  }
    arr = arr.sort
    ind = (arr.length * @percent  ) / 100
    @cutoff =  arr[ind]
    @cutoff
  end
  
  
  def highlight
    @result.each do |x|
      
      x[:sentence] = x[:sentence].gsub("\n \n", "<p>")
      if x[:score].to_i > @cutoff
        @spanned << "<span class='highlighted' style='background: #fff2a8;'>" + x[:sentence] + "</span>"
      else
        @spanned <<  x[:sentence]
      end
    end
    @spanned
  end
  
  
end
