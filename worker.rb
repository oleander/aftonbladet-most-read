# -*- encoding : utf-8 -*-
require "data_mapper"
require "rest-client"
require "plist"
require "dm-sqlite-adapter"
require "jsonify"
require "dm-core" 
require "dm-validations"
require "dm-timestamps"
require "twitter"
require "string_utils"
require "bitly"
require "./lib/config"
require "./lib/aftonbladet"
require "./lib/models"

sleep_time = 60*10 # 10 minutes
loop do
  # Fetching (top 5) news from source
  articles = Aftonbladet.new.articles[0..4]
  ids = Article.all(token: articles.map(&:id)).map(&:token)
  
  # Removing old ones
  articles.reject!{|article| ids.include?(article.id)}
  puts "#{articles.count} articles found." if articles.any?
  articles.each do |article|
    url    = B.shorten(article.url).short_url
    length = 140 - url.length - 1
    post   = StringUtils.truncate("#{article.title} – #{article.description}", length, "...") + " " + url
    Article.create(token: article.id, published_at: article.published_at)
    
    begin
      Twitter.update(post)
    rescue
      puts "Error: #{$!.message}"
    end
  end
  
  sleep(sleep_time)
end