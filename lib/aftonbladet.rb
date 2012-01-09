require "rest-client"
require "plist"

class Aftonbladet
  def articles
    Plist::parse_xml(data)["Sections"].first["Articles"]
  end
  
private
  def data
    @_data ||= RestClient.get("http://144.63.250.12/plist/ver2/section/mm/appar/supernytt/mestlast/nyh")
  end
end