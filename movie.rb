require 'nokogiri'
require 'open-uri'

doc = Nokogiri::HTML(open("http://movie.naver.com/movie/running/current.nhn"))
movie_title = Array.new

doc.css("ul.lst_detail_t1 dt a").each do |title|
    movie_title << title.text
end

puts movie_title.sample