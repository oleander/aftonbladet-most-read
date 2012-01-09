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

articles = Aftonbladet.new.articles
ids = Article.all(token: articles.map(&:id)).map(&:token)

articles.reject{|article| ids.include?(article.id)}.each do |article|
  url    = B.shorten(article.url).short_url
  length = 140 - url.length - 1
  post   = StringUtils.truncate("#{article.title} – #{article.description}", length, "...") + " " + url
  Article.create(token: article.id, published_at: article.published_at)  
  Twitter.update(post)
  abort
end