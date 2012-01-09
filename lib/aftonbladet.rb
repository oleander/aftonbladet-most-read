require "rest-client"
require "plist"
require "charlock_holmes/string"

class Aftonbladet
  def initialize
    @article = Struct.new(:title, :published_at, :description, :image_url, :id, :url)
    @user_agent = "Mozilla/5.0 (iPhone; U; CPU like Mac OS X; en) AppleWebKit/420+ (KHTML, like Gecko) Version/3.0 Mobile/1A543a Safari/419.3"
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
    @_data ||= RestClient.get("http://144.63.250.12/plist/ver2/section/mm/appar/supernytt/mestlast/nyh", headers: {
      "UserAgent" => @user_agent
    }).detect_encoding!
  end
end
