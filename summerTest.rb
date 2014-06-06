require 'ots'
require 'open-uri'



response = open('http://icourse.cuc.edu.cn/computernetworks/labs/alice.txt').each_line { |line| 
    article = OTS.parse(line)
    puts article.summarize(percent: 50)
}
