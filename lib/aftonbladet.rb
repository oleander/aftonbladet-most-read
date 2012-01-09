require "rest-client"
require "plist"

class Aftonbladet
  def initialize
    @article = Struct.new(:title, :published_at, :description, :image_url, :id, :url)
  end
  
  def articles
    @_articles ||= Plist::parse_xml(data)["Sections"].first["Articles"].map do |article|
      @article.new(
        article["Title"].gsub(/^\d+. /, ""),
        article["PubDate"],
        article["Description"],
        article["Image"],
        article["Id"].to_i,
        "http://www.aftonbladet.se/nyheter/article#{article["Id"]}.ab"
      )
    end
  end
  
private
  def data
    @_data ||= RestClient.get("http://144.63.250.12/plist/ver2/section/mm/appar/supernytt/mestlast/nyh")
  end
end